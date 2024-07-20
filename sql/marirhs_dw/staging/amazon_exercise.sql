
  create table orders
(
marketplace_id    INTEGER,
order_id          			INTEGER,
customer_id       	INTEGER,
item              					VARCHAR(255),
units            						INTEGER ,       
order_date        		DATE
)
;

insert into orders (marketplace_id, order_id,customer_id,item,units,order_date)
values 
(1,9021,123,'A22',1,'2021-02-01'),
(3,8763,241,'T14',1,'2021-01-14'),
(1,4321,123 ,'C13',2,'2020-11-17'),
(1,6757,443,'A22',3,'2020-12-07')
;   

create table catalog
(
		marketplace_id           				INTEGER,
		item                     									VARCHAR(255),
		product_group            			VARCHAR(20),
		has_bullet_points        			CHAR(1),
		has_customer_reviews     CHAR(1)
)
;



insert into catalog (marketplace_id,item,product_group,has_bullet_points,has_customer_reviews)
VALUES
(1,'A22','books','Y','Y'),
(1,'T14','electronics','Y','N'),
(3,'B20','books',null,'N'),
(1,'C13','games',null,'N'),
(1,'Q72','games','N','Y'),
(4,'A22','electronics','Y','Y')
;

select * from orders;
select * from catalog;

Q1.
select 
			customer_id, 
			sum(units) as total_units_sold 
from orders 
group by customer_id 
order by 1;

Q2.

select 
      distinct product_group
from catalog 
where marketplace_id=1
and has_customer_reviews='Y'
;

Q3

   select 
	    a.marketplace_id
			,a.item
			,a.product_group
			,b.order_id
			,b.customer_id
			,b.units
	 from 
				catalog a 
				left join orders b on b.marketplace_id=a.marketplace_id and b.item=a.item
	order by a.marketplace_id, a.product_group			
				;
				
	select 
	    a.marketplace_id
			,a.product_group
			,count(distinct b.customer_id) as unique_customers
			,sum(case when b.units is null then 0 else units end) as units_sold
	 from 
				catalog a 
				left join orders b on b.marketplace_id=a.marketplace_id and b.item=a.item
		group by 
					 a.marketplace_id
				  ,a.product_group
	order by a.marketplace_id, a.product_group;
	 