/*
=====================================================
RECREATE SILVER LAYER SCHEMA
=====================================================
Purpose: Reset and recreate several key tables in the mashasilver schema of the MashaDB database.
Ensure a clean starting point by dropping existing tables (if they exist) and then recreating them with the specified structure.
Include a fact table (actuals_qty) without foreign key references (commented out for now).
Automatically populate dwh_create_date with the current timestamp for data tracking.

Warnings: 
This script drops existing tables if they already exist.
The script assumes the mashasilver schema already exists. If not, you'll get errors unless you create it first.
No Error Handling
*/
USE MashaDB;
GO
IF OBJECT_ID ('mashasilver.locations', 'U')IS NOT NULL
  DROP TABLE mashasilver.locations;
CREATE TABLE mashasilver.locations(
loc_id VARCHAR(50),
loc_details NVARCHAR(MAX),
loc_region VARCHAR(50),
--PRIMARY KEY(loc_id)
);
GO
IF OBJECT_ID ('mashasilver.product', 'U')IS NOT NULL
  DROP TABLE mashasilver.product;
CREATE TABLE mashasilver.product(
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
IF OBJECT_ID ('mashasilver.currency', 'U')IS NOT NULL
  DROP TABLE mashasilver.currency;
CREATE TABLE mashasilver.currency(
currency_id VARCHAR(50),
currency_desc VARCHAR(50),
PRIMARY KEY(currency_id)
);

GO
IF OBJECT_ID ('mashasilver.calendar', 'U')IS NOT NULL
  DROP TABLE mashasilver.calendar;
CREATE TABLE mashasilver.calendar(
dates DATE,
holidays INT
PRIMARY KEY(dates)
);
GO
IF OBJECT_ID ('mashasilver.actuals_qty', 'U')IS NOT NULL
  DROP TABLE mashasilver.actuals_qty;
CREATE TABLE mashasilver.actuals_qty (
   dates DATE,
   loc_id VARCHAR(50),
   prd_id VARCHAR(50),
   actuals_qty INT,
   prd_price VARCHAR(50),
   currency_id VARCHAR(50),
   dwh_create_date DATETIME2 DEFAULT GETDATE()
   --PRIMARY KEY(dates, loc_id, prd_id),
   --FOREIGN KEY(loc_id) REFERENCES mashasilver.locations(loc_id),
   --FOREIGN KEY(prd_id) REFERENCES mashasilver.product(prd_id),
   --FOREIGN KEY(dates) REFERENCES mashasilver.calendar(dates),
   --FOREIGN KEY(currency_id) REFERENCES mashasilver.currency(currency_id)
);
