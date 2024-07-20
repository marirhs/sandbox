

with pizza_runners as (

	select 
		 runner_id
		,registration_date
		,timezone('EST', now())::TIMESTAMP(0) as dw_date_created
	from 
	 {{source('dim_runners','runners')}}
),
final as ( 
    select * from pizza_runners
)
select * from final