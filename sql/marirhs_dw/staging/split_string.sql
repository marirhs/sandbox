with titles as (
    select 'Title with word foo' as title union all
    select 'Title with word bar'
)
, data as (
select 
    title,
    string_to_table(title, ' ') as words 
from 
    titles
)
select * from data
where
    words in ('bar')
;