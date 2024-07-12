
-- select * from staging.emp_department;
-- select * from staging.employee;

with dept_avg AS
(
    SELECT
    a.DEPARTMENT_ID
    ,b.DEPARTMENT_NAME
    ,avg(salary)::int dept_avg
FROM
staging.employee A
join staging.emp_department b on b.department_id=a.department_id
group by a.department_id,b.department_name
),
company_avg as 
(
    select avg(salary)::int as company_avg from staging.employee
)
select 
  department_id
  ,department_name
  ,dept_avg
  ,company_avg
  ,round(((dept_avg-company_avg)::numeric/company_avg),2) as variance
from   
    dept_avg
    join company_avg on 1=1
;