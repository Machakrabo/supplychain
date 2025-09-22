/*
Purpose: This procedure loads and transforms data from the Bronze to the Silver layer. 
It removes duplicates, converts data types, enriches fact tables with dimension details, calculates sales values, and ensures standardized data. 
It prepares the Silver layer to support clean, consistent, and analysis-ready datasets to be uploaded in the gold layer.

Warnings: Improper joins or unmatched keys can result in NULLs or incorrect data updates. 
Overwriting keys like prd_id or loc_id may corrupt relationships. Also, each time new datasets are uploaded, the old dataset has to be deleted.
*/

CREATE OR ALTER PROCEDURE mashasilver.load_mashasilver AS
BEGIN
 --DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
 PRINT'=======================================';
 PRINT'>>>>> Silver Layer Data Loading with Transformations <<<<<';
 PRINT'=======================================';

 --SET @start_time = GETDATE();

 PRINT'>>>Handling Duplicates<<<<'
 PRINT'Data load intiated..'
 PRINT'Data load from mashabronze.currency initiated..'
 PRINT'Rows in mashabronze.currency'
 SELECT COUNT(*) FROM mashabronze.currency;
 INSERT INTO mashasilver.currency(currency_id, currency_desc)
 SELECT DISTINCT currency_id, currency_desc  FROM mashabronze.currency
 PRINT'Rows in mashasilver.currency after removing duplicates'
 SELECT COUNT(*) FROM mashasilver.currency
 -------------------------------------------------
 PRINT'Data load from mashabronze.locations initiated..'
 PRINT'Rows in mashabronze.locations'
 SELECT COUNT(*) FROM mashabronze.locations;
 INSERT INTO mashasilver.locations(loc_id, loc_details,loc_region)
 SELECT DISTINCT loc_id,loc_details,loc_region FROM mashabronze.locations
 PRINT'Rows in mashasilver.location after removing duplicates'
 SELECT * FROM mashasilver.locations
 ----------------------------------------
 PRINT'Data load from mashabronze.products initiated..'
 PRINT'Rows in mashabronze.product'
 SELECT COUNT(*) FROM mashabronze.product;
 INSERT INTO mashasilver.product(prd_id,prd_desc,prd_size,prd_family,prd_sku, prd_seasons, prd_price, currency_desc)
 SELECT DISTINCT prd_id,prd_desc,prd_size,prd_family,prd_sku,prd_seasons, prd_price,currency_desc FROM mashabronze.product
 PRINT'Rows in mashasilver.product after removing duplicates'
 SELECT * FROM mashasilver.product
 ---------------------------------------------
 PRINT'Data load from mashabronze.calendar initiated..'
 SELECT COUNT(*) FROM mashabronze.calendar;
 PRINT'Rows in mashabronze.calendar'
 INSERT INTO mashasilver.calendar (dates,holidays)
 SELECT DISTINCT dates,holidays FROM mashabronze.calendar
 PRINT'Rows in mashasilver.calendar after removing duplicates'
 SELECT * FROM mashasilver.calendar
 ----------------------------------------------
 PRINT'Data load from mashabronze.actuals_qty initiated..'
 SELECT COUNT(*) FROM mashabronze.actuals_qty;
 PRINT'Rows in mashabronze.actuals_qty'
 INSERT INTO mashasilver.actuals_qty (dates,loc_id,prd_id, actuals_qty, prd_price, currency_id)
 SELECT DISTINCT dates,loc_id,prd_id, actuals_qty, prd_price, currency_id FROM mashabronze.actuals_qty
 PRINT'Rows in mashasilver.actuals_qty after removing duplicates'
 SELECT*FROM mashasilver.actuals_qty

 --PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 ----------------------------------------------
 PRINT'>>>>Data Transformation initiated<<<<'
 PRINT'Transforming product prices to decimal'
 UPDATE mashasilver.product
 SET prd_price = TRY_CAST(REPLACE(prd_price, ',', '.') AS DECIMAL(38, 15));
 UPDATE mashasilver.actuals_qty
 SET prd_price = TRY_CAST(REPLACE(prd_price, ',', '.') AS DECIMAL(38, 15));
 PRINT'Transformations completed..'
 ----------------------------------------------
 PRINT'Normalizing values of actuals quantity less than 10 intiated..'
 UPDATE mashasilver.actuals_qty
 SET actuals_qty = 50 
 WHERE actuals_qty <10
 PRINT 'Rows normalized'
 SELECT COUNT(*) actuals_qty  FROM mashasilver.actuals_qty
 WHERE actuals_qty =50
 ----------------------------------------------
 PRINT' calculating vales for sales...'
 UPDATE mashasilver.actuals_qty
 SET actuals_sales = actuals_qty  * prd_price;
 PRINT' mashasilver.actuals_sales has been updated'
 PRINT'Joining columns to actuals_qty'
 -- currency table
UPDATE mashasilver.actuals_qty
SET currency_desc = c.currency_desc
FROM mashasilver.currency c
WHERE mashasilver.actuals_qty.currency_id = c.currency_id;
 -- location table
UPDATE mashasilver.actuals_qty
SET loc_id = l.loc_id,
    location_details = l.loc_details,
	loc_region = l.loc_region 
FROM mashasilver.locations l
WHERE mashasilver.actuals_qty.loc_id = l.loc_id;
 -- product table
UPDATE mashasilver.actuals_qty
SET prd_id = p.prd_id,
    prd_desc =p.prd_desc,
	prd_size =p.prd_size,
	prd_family= p.prd_family,
	prd_sku=p.prd_sku,
	prd_seasons=p.prd_seasons,
	prd_price= p.prd_price,
	currency_desc = p.currency_desc
FROM mashasilver.product p
WHERE mashasilver.actuals_qty.prd_id = p.prd_id;
 --calendar table
UPDATE mashasilver.actuals_qty
SET dates = d.dates,
    holidays = d.holidays
FROM mashasilver.calendar d
WHERE mashasilver.actuals_qty.dates = d.dates;
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
