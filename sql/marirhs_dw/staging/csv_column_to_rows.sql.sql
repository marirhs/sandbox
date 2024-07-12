	
-- convert csv column to rows.  The CTE does that and then the outer query total ingredients per pizza
		with pizzas as
		( 
			select 
				distinct
				pizza_id
				,pizza_name
				,trim(unnest(string_to_array(toppings,','))) toppings
				,trim(string_to_table(toppings,',')) as toppings_2
			from
			production.dim_pizza
			order by 1
		)
		select 
			pizza_id
			,pizza_name
			,count(*) as total_toppings
		from 
			pizzas
		group by 
			pizza_id
			,pizza_name
		order by 3 desc
		;
