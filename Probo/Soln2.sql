-- create a table
CREATE TABLE sales_data (
    city VARCHAR(50),
    year INT,
    month INT,
    sales INT
);

-- insert some values
INSERT INTO sales_data (city, year, month, sales) VALUES
('Delhi', 2020, 5, 4300),('Delhi', 2020, 6, 2000),('Delhi', 2020, 7, 2100),('Delhi', 2020, 8, 2200),
('Delhi', 2020, 9, 1900),('Delhi', 2020, 10, 200),
('Mumbai', 2020, 5, 4400),('Mumbai', 2020, 6, 2800),('Mumbai', 2020, 7, 6000),('Mumbai', 2020, 8, 9300),
('Mumbai', 2020, 9, 4200),('Mumbai', 2020, 10, 9700),
('Bangalore', 2020, 5, 1000),('Bangalore', 2020, 6, 2300),('Bangalore', 2020, 7, 6800),
('Bangalore', 2020, 8, 7000),('Bangalore', 2020, 9, 2300), ('Bangalore', 2020, 10, 8400);

-- query/read
SELECT *
FROM sales_data;


WITH serial AS(
-- serial order of city Delhi-1, Mumbai-2, Bangalore-3
SELECT *, CASE city WHEN "Delhi" THEN 1
                    WHEN "Mumbai" THEN 2
                    WHEN "Bangalore" THEN 3 
                    END AS city_order
FROM sales_data)

-- Col: city, year, month, sales, [city_order]
SELECT city, year, month, sales,
LAG(sales) OVER(PARTITION BY city_order ORDER BY month) AS previousMonthSales,
LEAD(sales) OVER(PARTITION BY city_order ORDER BY month) AS nextMonthSales,
SUM(sales) OVER(PARTITION BY city_order ORDER BY month) AS YTDSales
FROM serial