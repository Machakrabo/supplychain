/*
=====================================
 Purpose: To study data loaded in the bronze layer
======================================
*/
--CHECK FOR NULLS AND DUPLICATES IN PRIMARY KEY
--EXPECTED: No Results

SELECT prd_id , COUNT (*) FROM mashabronze.product
GROUP BY prd_id
HAVING COUNT(*) > 1
GO 
SELECT loc_id , COUNT (*) AS duplicate_values FROM mashabronze.locations
GROUP BY loc_id
HAVING COUNT(*) > 1
GO 
SELECT currency_id , COUNT (*) AS duplicate_values FROM mashabronze.currency
GROUP BY currency_id
HAVING COUNT(*) > 1
GO 
SELECT currency_id , COUNT (*) AS duplicate_values FROM mashabronze.currency
GROUP BY currency_id
HAVING COUNT(*) > 1;
GO
SELECT dates, loc_id, prd_id, actuals_qty, prd_price, currency_id, count(*) AS duplicate_values FROM mashabronze.actuals_qty 
GROUP BY dates, loc_id, prd_id, actuals_qty, prd_price, currency_id
HAVING COUNT(*) > 1;
GO
--CHECK THE DATATYPES OF DATE & PRICE
--EXPECTED: DATE should be in datetime and price should be in decimal
SELECT TABLE_NAME,COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'mashabronze' AND TABLE_NAME ='actuals_qty'
GO
-- CHECK THE IRREGULARITIES OF THE ACTUALS QUANTITY
--EXPECTED: No values should be under 50
SELECT dates, loc_id, prd_id, actuals_qty, prd_price, currency_id 
FROM mashabronze.actuals_qty 
WHERE actuals_qty <50;
