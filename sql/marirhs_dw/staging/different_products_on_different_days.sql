				drop table if exists staging.dim_purchase_history;
				
				create table staging.dim_purchase_history
				(user_id int
				,product_id int
				,purchase_date date
				);

		insert into dim_purchase_history values
		(1,1,'01/23/2012')
		,(1,2,'01/23/2012')
		,(1,3,'01/25/2012')
		,(2,1,'01/23/2012')
		,(2,2,'01/23/2012')
		,(2,2,'01/25/2012')
		,(2,4,'01/25/2012')
		,(3,4,'01/23/2012')
		,(3,1,'01/23/2012')
		,(4,1,'01/23/2012')
		,(4,2,'01/25/2012')
		;

  -- users who purchased on multiple days and did not repeat the products.
    with cte_1 as
		(
		select 
		  user_id 
			,product_id 
			,purchase_date
			,dense_rank() over (partition by user_id, product_id order by purchase_date) as purchase_rnk
		from staging.dim_purchase_history
			order by 1,2,3
			)
			select 
			   user_id 
			from 
			  cte_1
			group by user_id
			having max(purchase_rnk)=1	and count(distinct purchase_date)>1
		;