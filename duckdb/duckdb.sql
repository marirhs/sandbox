show tables;
show all tables;
show  schema;

-- Get a list of databases
SELECT * FROM pg_database;

describe information_schema.columns;

create schema sandbox_shri;

use sandbox_shri;

create table sandbox_shri_2.capital_one_transactions_2 as select * from main.ccone_transactions;

select distinct table_schema,table_name from information_schema.tables;

drop schema sandbox_shri_2 CASCADE  ;

select * from information_schema.tables;

select 
    replace(replace(lower(column_name),' ','_'),'.','')||' '||data_type||',' as column_name
from 
    information_schema.columns
where 
    1=1
    and table_schema='main'
    and table_name='ccone_transactions'
;


summarize ccone_transactions;


create table sandbox_shri.capital_one_transactions
(
    transaction_date  DATE, 
    posted_date       DATE,      
    card_no           BIGINT,        
    description       VARCHAR,   
    category          VARCHAR,      
    debit             DOUBLE,          
    credit            DOUBLE
);

insert into sandbox_shri.capital_one_transactions
(
    transaction_date  , 
    posted_date       ,      
    card_no           ,        
    description       ,   
    category          ,      
    debit             ,          
    credit            
)
select
    *
from
    main.ccone_transactions
;

select 
        transaction_date  , 
        posted_date       ,      
        card_no           ,        
        description       ,   
        category          ,      
        debit             ,          
        credit            ,
        avg(credit) over (order by (select 1))::int as avg_payment
from 
        sandbox_shri.capital_one_transactions
where 
        1=1
        and credit is not null    
        and description='ELECTRONIC PAYMENT'
order by 
        posted_date       
;

SELECT * FROM read_csv('/Users/shri/Documents/tableau_repository/Datasources/CC_Transactions_01_01_2024_to_09_27_2024.csv');
