/* ==========================================================================================
   Purpose: This script re-creates several views in the [mashagold] schema for use in analytics 
   tools such as Power BI reporting. These views are built to expose
   structured data from various underlying dimension and fact tables in a clean and 
   consistent format.
   Views Created:
   - dim_actual_sales :The views use LEFT JOINs and basic SELECTs to flatten and standardize datafor ease of use in BI tools.
   - dim_locations
   - dim_products
   - dim_currency
   - dim_calendar

 Warning:This script will DROP and RECREATE views if they already exist. Any existing permissions, dependencies, or custom modifications to those views
   will be lost.
   ==========================================================================================
*/
IF OBJECT_ID('mashagold.dim_actual_sales', 'V') IS NOT NULL
BEGIN
    DROP VIEW mashagold.dim_actual_sales;
END
GO  
CREATE VIEW mashagold.dim_actual_sales AS
SELECT
    c.dates ,
    c.holidays ,
    l.loc_id ,
    l.loc_region ,
    l.loc_details ,
    p.prd_id ,
    p.prd_family ,
    p.prd_desc ,
    p.prd_seasons  ,
    cur.currency_id, 
    cur.currency_desc,
    f.actuals_qty,
    f.sales_forecast,
    f.actuals_sales,
    f.algorithm_forecast,
    f.algo_error,
    f.algo_error_absolute,
    f.algo_error_squared
FROM mashagold.actuals_qty f
LEFT JOIN mashagold.locations l ON f.loc_id = l.loc_id
LEFT JOIN mashagold.product p ON f.prd_id = p.prd_id
LEFT JOIN mashagold.calendar c ON f.dates = c.dates
LEFT JOIN mashagold.currency cur ON f.currency_id = cur.currency_id;
GO  
IF OBJECT_ID('mashagold.dim_locations', 'V') IS NOT NULL
BEGIN
    DROP VIEW mashagold.dim_locations;
END
GO  
CREATE VIEW mashagold.dim_locations AS
SELECT
    loc_id,
    loc_details,
	loc_region
FROM mashagold.locations;
GO
IF OBJECT_ID('mashagold.dim_products', 'V') IS NOT NULL
BEGIN
    DROP VIEW mashagold.dim_products;
END
GO  
CREATE VIEW mashagold.dim_products AS
SELECT
    prd_id,
	prd_desc,
	prd_size,
	prd_family,
	prd_sku,
	prd_seasons,
	prd_price,
	currency_desc
FROM mashagold.product;
GO
IF OBJECT_ID('mashagold.dim_currency', 'V') IS NOT NULL
BEGIN
    DROP VIEW mashagold.dim_currency;
END
GO
CREATE VIEW mashagold.dim_currency AS
SELECT
    currency_id,
	currency_desc
FROM mashagold.currency;
GO
IF OBJECT_ID('mashagold.dim_calendar', 'V') IS NOT NULL
BEGIN
    DROP VIEW mashagold.dim_calendar;
END
GO
CREATE VIEW mashagold.dim_calendar AS
SELECT
    dates,
	holidays
FROM mashagold.calendar;
GO

PRINT ' All the Views are created'

