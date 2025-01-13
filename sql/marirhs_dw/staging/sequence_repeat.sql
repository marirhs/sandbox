
--https://www.linkedin.com/posts/tripathi-pooja_dataengineerinterview-sql-microsoft-activity-7228745120651599873-Nx9H?utm_source=share&utm_medium=member_desktop
-- generate a series to repeat the number n times itself... 2 repeats 2 times, 5 repeats 5 times.

drop table if exists staging.tbl_numbers;

CREATE TABLE tbl_numbers (
 int_numbers INT
);

INSERT INTO tbl_numbers (int_numbers)
VALUES
(1),
(2),
(3),
(4),
(5);


  with  cte_1 AS
	(
  select int_numbers,  generate_series(1, int_numbers) from tbl_numbers
	)
	select 
		int_numbers
	from
		cte_1
	order by 1	
	;