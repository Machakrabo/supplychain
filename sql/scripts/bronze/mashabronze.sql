/*
=========================================
Bronze Layer Schema
=========================================
Purpose:
- The Bronze layer is the raw data storage layer.
- It is designed to hold ingested data with minimal transformations.
- Typically stores transactional-level data that will later feed into
  Silver (cleansed) and Gold (aggregated/curated) layers.

Warning:
- Once the code is executed, the tables will be created.
- If the script is re-executed, SQL Server will throw an error because
  the tables already exist (unless DROP/IF EXISTS logic is added).
- Run with caution in production environments.

Best Practices:
- Use schema-qualified names (e.g., mashabronze.table_name).
- Avoid making schema changes directly in production without testing.
- Use DROP TABLE IF EXISTS if you want to re-create tables safely.
*/

USE MashaDB;
GO
IF OBJECT_ID ('mashabronze.locations', 'U')IS NOT NULL
  DROP TABLE mashabronze.locations;
CREATE TABLE mashabronze.locations(
loc_id VARCHAR(50),
loc_details NVARCHAR(MAX),
loc_region VARCHAR(50),
--PRIMARY KEY(loc_id)
);
GO
IF OBJECT_ID ('mashabronze.product', 'U')IS NOT NULL
  DROP TABLE mashabronze.product;
CREATE TABLE mashabronze.product(
prd_id VARCHAR(50),
prd_desc VARCHAR(50),
prd_size VARCHAR(50),
prd_family VARCHAR(50),
prd_sku VARCHAR(50),
prd_seasons VARCHAR(50),
prd_price VARCHAR(50),
currency_desc VARCHAR(50)
--PRIMARY KEY(prd_id)
);
GO
IF OBJECT_ID ('mashabronze.currency', 'U')IS NOT NULL
  DROP TABLE mashabronze.currency;
CREATE TABLE mashabronze.currency(
currency_id VARCHAR(50),
currency_desc VARCHAR(50),
--PRIMARY KEY(currency_id)
);

GO
IF OBJECT_ID ('mashabronze.calendar', 'U')IS NOT NULL
  DROP TABLE mashabronze.calendar;
CREATE TABLE mashabronze.calendar(
dates DATE,
holidays INT
--PRIMARY KEY(dates)
);
GO
IF OBJECT_ID ('mashabronze.actuals_qty', 'U')IS NOT NULL
  DROP TABLE mashabronze.actuals_qty;
CREATE TABLE mashabronze.actuals_qty (
   dates DATE,
   loc_id VARCHAR(50),
   prd_id VARCHAR(50),
   actuals_qty INT,
   prd_price VARCHAR(50),
   currency_id VARCHAR(50),
   dwh_create_date DATETIME2 DEFAULT GETDATE()
   --PRIMARY KEY(dates, loc_id, prd_id),
   --dwh_create_date DATETIME2 DEFAULT GETDATE()
   --FOREIGN KEY(loc_id) REFERENCES mashabronze.locations(loc_id),
   --FOREIGN KEY(prd_id) REFERENCES mashabronze.product(prd_id),
   --FOREIGN KEY(dates) REFERENCES mashabronze.calendar(dates),
   --FOREIGN KEY(currency_id) REFERENCES mashabronze.currency(currency_id)
);
