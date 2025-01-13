
drop table if exists staging.Ordertable;
CREATE TABLE staging.Ordertable
 (
 Order_ID INT,
 Order_Date DATE,
 User_ID INT,
 Sku1 VARCHAR(10),
 Sku2 VARCHAR(10),
 Sku3 VARCHAR(10)
);

INSERT INTO staging.Ordertable (Order_ID, Order_Date, User_ID, Sku1, Sku2, Sku3) VALUES
(1, '2024-07-01', 101, 'A123', 'B456', 'C789'),
(2, '2024-07-01', 102, 'B456', 'C789', 'A123'),
(3, '2024-07-01', 102, 'G678', 'H123', 'I456'),
(4, '2024-07-01', 103, 'I456', 'G678', 'H123'),
(5, '2024-07-01', 104, 'H123', 'G678', 'I456'),
(6, '2024-07-02', 105, 'C789', 'A123', 'B456'),
(7, '2024-07-02', 106, 'B456', 'A123','C789'),
(8, '2024-07-03', 107, 'A123', 'C789', 'B456'),
(9, '2024-07-04', 101, 'D123', 'E456', 'F789');

  with union_cte AS
	(
		select order_id, order_date ,user_id, sku1 as sku from staging.Ordertable
		union 
		select order_id, order_date ,user_id, sku2 as sku from staging.Ordertable
		union 
		select order_id, order_date ,user_id, sku3 as sku from staging.Ordertable
	)
	, agg_cte AS
	(
		select order_id, order_date ,user_id, string_agg(sku,',' order by sku) as sku
		from union_cte
		group by order_id, order_date ,user_id
	)
	select 
			 order_date
			 ,sku
			 ,count(order_id)
	FROM
				agg_cte
	group by 
				order_date
				,sku
	order by order_date
	 ;
