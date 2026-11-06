Use sample_sales;
-- 1
SELECT SUM(ss.Sale_Amount) AS Total_Revenue, MIN(ss.Transaction_Date) AS start_date, MAX(ss.Transaction_Date) AS end_date
FROM store_sales  AS ss
JOIN store_locations AS sl
ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts';

-- 2
SELECT  YEAR(ss.Transaction_Date) AS Sales_Year, MONTH(ss.Transaction_Date) AS Sales_Month, SUM(ss.Sale_Amount) AS Total_Revenue
FROM store_sales AS ss JOIN store_locations AS sl ON ss.Store_ID = sl.StoreId 
WHERE sl.State = 'Massachusetts' 
GROUP BY YEAR(ss.Transaction_Date), MONTH(ss.Transaction_Date)
ORDER BY Sales_Year, Sales_Month;

-- Question 3
SELECT sl.State, sl.StoreLocation, SUM(ss.Sale_Amount) AS Total_Revenue
FROM store_sales AS ss JOIN store_locations AS sl ON ss.Store_ID = sl.StoreId 
WHERE sl.State = 'Massachusetts' 
GROUP BY sl.State, sl.StoreLocation;

-- 4
SELECT
    YEAR(ss.Transaction_Date) AS Sales_Year,
    MONTH(ss.Transaction_Date) AS Sales_Month,
    COUNT(*) AS Number_of_Transactions,
    AVG(ss.Sale_Amount) AS Average_Transaction_Amount
FROM store_sales AS ss
JOIN store_locations AS sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts'
GROUP BY
    YEAR(ss.Transaction_Date), MONTH(ss.Transaction_Date)
ORDER BY
    Sales_Year, Sales_Month;


-- Question 5
SELECT ss.Store_ID,
    sl.StoreLocation,
    sl.State,
    SUM(ss.Sale_Amount) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(ss.Sale_Amount) DESC
    ) AS Sales_Rank
FROM store_sales AS ss
JOIN store_locations AS sl ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts'
GROUP BY ss.Store_ID, sl.StoreLocation, sl.State, ss.Date
ORDER BY Sales_Rank, ss.Store_ID; 

-- Question 6
-- Next quarter, the sales team should focus on mid-performing Massachusetts stores that have a lot of customers but lower average spending. These stores have the potential to increase sales through special promotions, product bundles, cross-selling, and keeping popular products in stock. The company should continue supporting top-performing stores while investigating why lower-ranked stores are struggling before investing more money in them.

