/*
=========================================
Data Load in MashaBronze Layer
=========================================

Purpose: This SQL script performs a bulk data import into the mashabronze schema within the MashaDB database. Specifically, it loads structured data from CSV files into key tables: currency, calendar, locations, product, and actuals_qty.
Assumes the first row of each CSV file is a header and skips it. Uses the TABLOCK option to improve performance during insert.Applies specific data formatting options for proper handling of delimiters, row terminators, and encoding (e.g., UTF-8 via CODEPAGE = '65001').
Executes a full load for the actuals_qty table by truncating existing data before importing fresh data. In bronze layer we will just load the original data.
A stored procedure is created for the load. 
Warning : 
The TRUNCATE TABLE mashabronze.actuals_qty command permanently deletes all existing data in the actuals_qty table before loading new data. 
Ensure this is intentional, and backups exist if needed.
*/
CREATE OR ALTER PROCEDURE mashabronze.load_mashabronze AS
BEGIN
BULK INSERT mashabronze.currency
FROM 'D:\Documents\Maloshree\2025\Project- Supply Chain\Data\csv2\Currency.csv'
WITH(
FIRSTROW= 2,
FIELDTERMINATOR=',',
TABLOCK
);
BULK INSERT mashabronze.calendar
FROM 'D:\Documents\Maloshree\2025\Project- Supply Chain\Data\csv2\Calender.csv'
WITH(
FIRSTROW= 2,
FIELDTERMINATOR=',',
TABLOCK
);
BULK INSERT mashabronze.locations
FROM 'D:\Documents\Maloshree\2025\Project- Supply Chain\Data\csv2\Location.csv'
WITH(
    FIRSTROW = 2,              -- Skip the header row
    FIELDTERMINATOR = ',',     -- Columns are separated by commas
    ROWTERMINATOR = '\n',      -- Lines end with a line break
    CODEPAGE = '65001',        --  to support special characters
    FORMAT = 'CSV',            -- Tells SQL what type of file is it
    TABLOCK  
);

BULK INSERT mashabronze.product
FROM 'D:\Documents\Maloshree\2025\Project- Supply Chain\Data\csv2\Products.csv'
WITH(
FIRSTROW= 2,
FIELDTERMINATOR=',',
ROWTERMINATOR = '\n', 
TABLOCK 
);
--- Full Load
TRUNCATE TABLE mashabronze.actuals_qty
BULK INSERT mashabronze.actuals_qty
FROM
'D:\Documents\Maloshree\2025\Project- Supply Chain\Data\csv2\Actuals_qty.csv'
WITH(
FIRSTROW= 2,
FIELDTERMINATOR=',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    FORMAT = 'CSV',
TABLOCK 
);
END
