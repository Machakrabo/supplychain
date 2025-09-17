/*
=========================================
Gold Layer Schema
=========================================
Purpose:
- The Gold layer stores curated, aggregated, and business-ready data.
- It is designed for:
  * Business Intelligence (BI) dashboards
  * Advanced analytics and machine learning
  * Direct consumption by end-users
- Gold tables are often fact/dimension models or aggregated marts.

Warning:
- Gold data is derived from Silver, not directly from Bronze.
- Schema changes here can break downstream reports/dashboards.
- Aggregations must be validated against business definitions.

Best Practices:
- Implement star schema or data marts for specific business domains
  (e.g., Sales, Finance, Inventory).
- Ensure versioning or change tracking for key metrics.
- Only expose curated and validated data to business users.
*/
USE MashaDB;
GO
CREATE TABLE mashagold.locations(
loc_id VARCHAR(50),
loc_details VARCHAR(50),
loc_region VARCHAR(50),
PRIMARY KEY(loc_id)
);
GO
CREATE TABLE mashagold.product(
prd_id VARCHAR(50),
prd_season VARCHAR(50),
prd_price VARCHAR(50),
prd_desc VARCHAR(50),
prd_size VARCHAR(50),
prd_family VARCHAR(50),
prd_sku VARCHAR(50),
PRIMARY KEY(prd_id)
);
GO
CREATE TABLE mashagold.currency(
currency_id VARCHAR(50),
currency_desc VARCHAR(50),
PRIMARY KEY(currency_id)
);

GO
CREATE TABLE mashagold.calendar(
dates DATE,
holidays INT
PRIMARY KEY(dates)
);
GO
CREATE TABLE mashagold.actuals_qty (
   dates DATE,
   loc_id VARCHAR(50),
   prd_id VARCHAR(50),
   actuals_qty INT,
   prd_price VARCHAR(50),
   currency_id VARCHAR(50),
   PRIMARY KEY(dates, loc_id, prd_id),
   FOREIGN KEY(loc_id) REFERENCES mashagold.locations(loc_id),
   FOREIGN KEY(prd_id) REFERENCES mashagold.product(prd_id),
   FOREIGN KEY(dates) REFERENCES mashagold.calendar(dates),
   FOREIGN KEY(currency_id) REFERENCES mashagold.currency(currency_id)
);
