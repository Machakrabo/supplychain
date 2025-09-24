/*
=====================================================
RECREATE GOLD LAYER SCHEMA
=====================================================
Purpose: Reset and recreate several key tables in the mashagold schema of the MashaDB database.
Ensure a clean starting point by dropping existing tables (if they exist) and then recreating them with the specified structure.
Include a fact table (actuals_qty) without foreign key references.
Automatically populate dwh_create_date with the current timestamp for data tracking.

Warnings: 
This script drops existing tables if they already exist.
The script assumes the mashagold schema already exists. If not, you'll get errors unless you create it first.
No Error Handling
*/

USE MashaDB;
GO
IF OBJECT_ID ('mashagold.locations', 'U')IS NOT NULL
  DROP TABLE mashagold.locations;
CREATE TABLE mashagold.locations(
loc_id VARCHAR(50),
loc_details NVARCHAR(MAX),
loc_region VARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
IF OBJECT_ID ('mashagold.product', 'U')IS NOT NULL
  DROP TABLE mashagold.product;
CREATE TABLE mashagold.product(
prd_id VARCHAR(50),
prd_desc VARCHAR(50),
prd_size VARCHAR(50),
prd_family VARCHAR(50),
prd_sku VARCHAR(50),
prd_seasons VARCHAR(50),
prd_price VARCHAR(50),
currency_desc VARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()

);
GO
IF OBJECT_ID ('mashagold.currency', 'U')IS NOT NULL
  DROP TABLE mashagold.currency;
CREATE TABLE mashagold.currency(
currency_id VARCHAR(50),
currency_desc VARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE(),
PRIMARY KEY(currency_id)
);

GO
IF OBJECT_ID ('mashagold.calendar', 'U')IS NOT NULL
  DROP TABLE mashagold.calendar;
CREATE TABLE mashagold.calendar(
dates DATE,
holidays INT,
dwh_create_date DATETIME2 DEFAULT GETDATE(),
PRIMARY KEY(dates)
);
GO
IF OBJECT_ID ('mashagold.actuals_qty', 'U')IS NOT NULL
  DROP TABLE mashagold.actuals_qty;
CREATE TABLE mashagold.actuals_qty (
   dates DATE,
   loc_id VARCHAR(50),
   prd_id VARCHAR(50),
   actuals_qty DECIMAL (18,0),
   prd_price VARCHAR(50),
   currency_id VARCHAR(50),
   actuals_sales DECIMAL(18,0),
   sales_forecast DECIMAL(18,0),
   currency_desc VARCHAR(50),
   location_details NVARCHAR(MAX),
   loc_region VARCHAR(50),
   prd_desc VARCHAR(50),
   prd_size VARCHAR(50),
   prd_sku VARCHAR(50),
   prd_family VARCHAR(50),
   prd_seasons VARCHAR(50),
   holidays INT,
   algorithm_forecast NVARCHAR(50),
   algo_error DECIMAL(18,0),
   algo_error_absolute DECIMAL(18,0),
   algo_error_squared DECIMAL(18,0),
   dwh_create_date DATETIME2 DEFAULT GETDATE()
);


