show tables;
show all tables;

describe information_schema.columns;

select * from information_schema.tables;
select table_schema, table_name, column_name, data_type from information_schema.columns;

summarize ccone_transactions;