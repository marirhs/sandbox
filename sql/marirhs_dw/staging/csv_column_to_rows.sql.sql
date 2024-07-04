	
-- convert csv column to rows.  The CTE does that and then the outer query total ingredients per pizza
		with pizzas as
			( 
				select 
					distinct
					pizza_type_id
					,"name" as pizza_name
					,category
					,trim(unnest(string_to_array(ingredients,','))) individual_ingredients
					,trim(string_to_table(ingredients,',')) as individual_ingredients_2
			from
			staging.pizza_types
			order by 1
			)
			select 
				pizza_type_id
				,pizza_name
				,count(*) as total_ingredients
			from 
					pizzas
			group by 
						pizza_type_id
						,pizza_name
			order by 3 desc
			;
