-- =========================================
-- Project: Retail Sales Analysis
-- Author: Malathi Ramesh
-- Tool: SQL Server
-- =========================================


-- 1. Total Sales by Category

select category,sum(Sales) from practice_db.dbo.Retail_Sales_Dataset_1000_Rows group by category ;

-- 2. Top 5 Products by Revenue

select top 5 product,sum(Sales) as totalsales from practice_db.dbo.Retail_Sales_Dataset_1000_Rows group by product order by totalsales desc;

-- 3. Ranking Categories by Sales using CTE

select category ,ROW_NUMBER() OVER (ORDER BY category DESC) as row_num from practice_db.dbo.Retail_Sales_Dataset_1000_Rows;

-- 4. Percentage Contribution by Category 

select 
category, 
sum(sales)  as totalsales,
sum(sales) * 100.00 / (select sum(sales)  from practice_db.dbo.Retail_Sales_Dataset_1000_Rows) as percentagebycategory
	from practice_db.dbo.Retail_Sales_Dataset_1000_Rows
		group by category ;

--5. Show categories sorted from highest percentage to lowest?

		with percentangelist as
(
select 
category, 
sum(sales)  as totalsales,
sum(sales) * 100.00 / (select sum(sales)  from practice_db.dbo.Retail_Sales_Dataset_1000_Rows) as percentagebycategory

	from practice_db.dbo.Retail_Sales_Dataset_1000_Rows
		group by category

		)
		select category,totalsales,percentagebycategory from percentangelist  order by percentagebycategory desc;

--6. Categories contributing more than 20% to total sales
-- and having total sales greater than 5000

WITH percentangelist AS
(
    SELECT 
        category, 
        SUM(sales) AS totalsales,
        SUM(sales) * 100.00 / 
        (SELECT SUM(sales)  
         FROM practice_db.dbo.Retail_Sales_Dataset_1000_Rows) 
        AS percentagebycategory
    FROM practice_db.dbo.Retail_Sales_Dataset_1000_Rows
    GROUP BY category
)

SELECT 
    category,
    totalsales,
    percentagebycategory
FROM percentangelist
WHERE percentagebycategory > 20 and totalsales >5000
ORDER BY percentagebycategory DESC;

-- TOP Best Selling Category 

SELECT Top 1
    category,
    SUM(sales) AS Total_Sales
FROM practice_db.dbo.Retail_Sales_Dataset_1000_Rows
GROUP BY category
ORDER BY Total_Sales DESC;

--Best Performing Month