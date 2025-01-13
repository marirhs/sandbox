create table dim_phonelog
(
    caller_id int, 
    recipient_id int,
    date_called timestamp
);

insert into dim_phonelog(caller_id, recipient_id, date_called)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
			 
			 -- get all callers whose first call and last call was to the same person on a given day.
			 
			 option 1;
			 with phone_log as
			 (
			 select 
			   caller_id
				 ,recipient_id
				 ,date_called
				 ,FIRST_VALUE(recipient_id) over ( partition by caller_id, date_called::date order by date_called
													ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
												  ) as first_person
					,last_value(recipient_id) over ( partition by caller_id, date_called::date order by date_called
							                         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							                        ) as last_person
			 from 
			 dim_phonelog
			 order by caller_id, date_called
			 )
			 select 
			   distinct
				 caller_id
				 ,first_person
				 ,last_person
				 ,date_called::date 
				 from 
				   phone_log
					where first_person=last_person 
				order by caller_id, date_called::date	
			 ;
			 
		--	  option 2 using row_num
			 with first_call as
			 (
				 select 
					 caller_id
					 ,recipient_id
					 ,date_called
					 ,row_number() over ( partition by caller_id, date_called::date order by date_called) as first_call
				 from 
				 dim_phonelog
				 order by caller_id, date_called
			 ),
			 	 last_call as
			 (
				 select 
					 caller_id
					 ,recipient_id
					 ,date_called
					 ,row_number() over ( partition by caller_id, date_called::date order by date_called desc) as last_call
				 from 
				 dim_phonelog
				 order by caller_id, date_called
			 )
			 select 
			   distinct
					a.caller_id
          ,a.recipient_id as first_recipient
					,b.recipient_id as last_recipient
				 ,a.date_called::date 
				 from 
				   first_call A
					 join last_call b on b.caller_id=a.caller_id and b.date_called::date=a.date_called::date and a.first_call=1 and b.last_call=1
					where  b.recipient_id=a.recipient_id
				order by a.caller_id, a.date_called::date	
			 ;