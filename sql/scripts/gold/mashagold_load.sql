/* ==========================================================================================

   Purpose: This stored code performs data loading from the `mashasilver` layer into the 
   `mashagold` layer.

   Tables Involved:
   - mashasilver.currency        → mashagold.currency
   - mashasilver.locations       → mashagold.locations
   - mashasilver.product         → mashagold.product
   - mashasilver.calendar        → mashagold.calendar
   - mashasilver.actuals_qty     → mashagold.actuals_qty

   Each data load:
   - Logs row counts before and after load.
   - Performs simple insert-select transformations.
Warnings: The script does not contain transaction control or error handling. In case of failure, partial inserts may occur.
   ==========================================================================================
*/
CREATE OR ALTER PROCEDURE mashagold.load_mashagold AS
BEGIN
 --DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

 PRINT'=======================================';
 PRINT'>>>>> Load Layer Data Loading with Transformations <<<<<';
 PRINT'=======================================';

 --SET @start_time = GETDATE();

 PRINT'>>>Handling Duplicates<<<<'
 PRINT'Data load intiated..'
 PRINT'Data load from mashasilver.currency initiated..'
 PRINT'Rows in mashasilver.currency'
 SELECT COUNT(*) FROM mashasilver.currency;
 INSERT INTO mashagold.currency(currency_id, currency_desc)
 SELECT currency_id, currency_desc  FROM mashasilver.currency
 PRINT'Rows in mashagold.currency after removing duplicates'
 SELECT COUNT(*) FROM mashagold.currency;
 -------------------------------------------------
 PRINT'Data load from mashasilver.locations initiated..'
 PRINT'Rows in mashasilver.locations'
 SELECT COUNT(*) FROM mashasilver.locations;
 INSERT INTO mashagold.locations(loc_id, loc_details,loc_region)
 SELECT loc_id,loc_details,loc_region FROM mashasilver.locations
 PRINT'Rows in mashagold.location after removing duplicates'
 SELECT COUNT(*)FROM mashagold.locations;
 ----------------------------------------
 PRINT'Data load from mashasilver.products initiated..'
 PRINT'Rows in mashasilver.product'
 SELECT COUNT(*) FROM mashasilver.product;
 INSERT INTO mashagold.product(prd_id,prd_desc,prd_size,prd_family,prd_sku, prd_seasons, prd_price, currency_desc)
 SELECT prd_id,prd_desc,prd_size,prd_family,prd_sku,prd_seasons, prd_price,currency_desc FROM mashasilver.product
 PRINT'Rows in mashagold.product after removing duplicates'
 SELECT COUNT(*) FROM mashagold.product;
 ---------------------------------------------
 PRINT'Data load from mashasilver.calendar initiated..'
 SELECT COUNT(*) FROM mashasilver.calendar;
 PRINT'Rows in mashasilver.calendar'
 INSERT INTO mashagold.calendar (dates,holidays)
 SELECT dates,holidays FROM mashasilver.calendar
 PRINT'Rows in mashagold.calendar after removing duplicates'
 SELECT COUNT(*) FROM mashagold.calendar;
 ----------------------------------------------
 PRINT'Data load from mashasilver.actuals_qty initiated..'
 SELECT COUNT(*) FROM mashasilver.actuals_qty
 PRINT'Rows in mashasilver.actuals_qty'
 INSERT INTO mashagold.actuals_qty (dates,loc_id,prd_id,actuals_qty, prd_price, currency_id, actuals_sales, sales_forecast, currency_desc, location_details, loc_region, prd_desc, prd_size, prd_sku, prd_family,prd_seasons,holidays)
 SELECT dates,loc_id,prd_id,actuals_qty, prd_price, currency_id, actuals_sales, sales_forecast, currency_desc, location_details, loc_region, prd_desc, prd_size, prd_sku, prd_family,prd_seasons,holidays FROM mashasilver.actuals_qty
 PRINT'Rows in mashagold.actuals_qty after removing duplicates'
 SELECT COUNT(*)FROM mashagold.actuals_qty;

 END
