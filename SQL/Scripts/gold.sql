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
   sales_qty INT,
   sales_forecast_qty INT,
   sales_revenue DECIMAL(15,2),
   currency_id VARCHAR(50),
   PRIMARY KEY(dates, loc_id, prd_id),
   FOREIGN KEY(loc_id) REFERENCES mashagold.locations(loc_id),
   FOREIGN KEY(prd_id) REFERENCES mashagold.product(prd_id),
   FOREIGN KEY(dates) REFERENCES mashagold.calendar(dates),
   FOREIGN KEY(currency_id) REFERENCES mashagold.currency(currency_id)
);
