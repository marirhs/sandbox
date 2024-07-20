			
			create table production.dim_hospital ( emp_id int, action varchar(10), recorded_at timestamp);

			insert into production.dim_hospital values ('1', 'in', '2019-12-22 09:00:00');
			insert into production.dim_hospital values ('1', 'out', '2019-12-22 09:15:00');
			insert into production.dim_hospital values ('2', 'in', '2019-12-22 09:00:00');
			insert into production.dim_hospital values ('2', 'out', '2019-12-22 09:15:00');
			insert into production.dim_hospital values ('2', 'in', '2019-12-22 09:30:00');
			insert into production.dim_hospital values ('3', 'out', '2019-12-22 09:00:00');
			insert into production.dim_hospital values ('3', 'in', '2019-12-22 09:15:00');
			insert into production.dim_hospital values ('3', 'out', '2019-12-22 09:30:00');
			insert into production.dim_hospital values ('3', 'in', '2019-12-22 09:45:00');
			insert into production.dim_hospital values ('4', 'in', '2019-12-22 09:45:00');
			insert into production.dim_hospital values ('5', 'out', '2019-12-22 09:40:00');
			
			-- select * from production.dim_hospital;
			-- find out who is inside the hospital at the moment.
			
			-- option 1 to rank all the entires per employee by timestamp desc and select rnk=1 and action='in'
			with hospital_entries AS
			(
			  select 
					emp_id
					,action
					,recorded_at
					,row_number() over (partition by emp_id order by recorded_at desc) as latest_action
					FROM
				    production.dim_hospital
			)
			select 
			*
			FROM
				hospital_entries
			WHERE
					action='in'
					and latest_action=1
			order by emp_id
			;
			
			
			-- option 2 to get last_value(action) per employee
			-- rows between is very important. Then the window is calculated for each row by the OVER()
			-- clause which is by default equivalent to OVER(ROWS BETWEEN UNBOUDED PRECEDING AND CURRENT ROW) 
			--
			with hospital_entries AS
			(
			  select 
					emp_id
					,action
					,recorded_at
					,last_value(action) over (partition by emp_id order by recorded_at 
																													ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
																													) as latest_action
					FROM
				    production.dim_hospital
					order by emp_id
			)
			select 
			*
			FROM
				hospital_entries
			WHERE
					action='in'
					and latest_action=1
			order by emp_id
			;
			