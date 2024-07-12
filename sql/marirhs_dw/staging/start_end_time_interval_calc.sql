
-- always rank the start and stop separately
-- join the two ctes based on id and rnk
-- then calculate the time interval
-- just get the epoch of the diff and divide it by 3600 for hours, (3600*24) for days
with server_utilization as
(
select 1 as server_id, 'start' as session_status, '2022-08-02 10:00:00' as status_time union
select 1 as server_id, 'stop' as session_status, '2022-08-04 10:00:00' as status_time union
select 1 as server_id, 'stop' as session_status, '2022-08-13 19:00:00' as status_time union
select 1 as server_id, 'start' as session_status, '2022-08-13 10:00:00' as status_time union
select 3 as server_id, 'stop' as session_status, '2022-08-19 10:00:00' as status_time union
select 3 as server_id, 'start' as session_status, '2022-08-18 10:00:00' as status_time union
select 5 as server_id, 'stop' as session_status, '2022-08-19 10:00:00' as status_time union
select 4 as server_id, 'stop' as session_status, '2022-08-19 14:00:00' as status_time union
select 4 as server_id, 'start' as session_status, '2022-08-16 10:00:00' as status_time union
select 3 as server_id, 'stop' as session_status, '2022-08-14 10:00:00' as status_time union
select 3 as server_id, 'start' as session_status, '2022-08-06 10:00:00' as status_time union
select 2 as server_id, 'stop' as session_status, '2022-08-24 10:00:00' as status_time union
select 2 as server_id, 'start' as session_status, '2022-08-17 10:00:00' as status_time union
select 5 as server_id, 'start' as session_status, '2022-08-14 21:00:00' as status_time
),
cte_start as
(
  SELECT 
    server_id
    ,status_time::timestamp(0)
    ,rank() over (partition by server_id order by status_time::timestamp(0)) as rnk
  FROM 
    server_utilization
  WHERE
    session_status='start'
),
cte_end as
(
  SELECT 
    server_id
    ,status_time::timestamp(0)
    ,rank() over (partition by server_id order by status_time::timestamp(0)) as rnk
  FROM 
    server_utilization
  WHERE
    session_status='stop'
) 
SELECT
   A.SERVER_ID 
   ,a.status_time as start_time
   ,b.status_time as stop_time
   ,(extract(epoch from b.status_time-a.status_time)/3600)::int as uptime_hours_per_server
   ,((sum((extract(epoch from b.status_time-a.status_time)/3600)::int) over (partition by (select 1)))/24)::int as uptime_total_days
 from 
 cte_start a 
 left join cte_end b on a.server_id=b.server_id and a.rnk=b.RNK
;
