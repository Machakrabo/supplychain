/*
=============================================================
Create Schemas and databases:
===============================================================
Purpose : To create Data WareHouse Layers - bronze for  extraction and storing, silver for transforming the data and gold that will store the business ready data.
The data from the gold layer will be used for further analyis

Warning : 
If the Data base is already present, it will show error.
*/

USE master;
GO
--Verify if the database exist, Note if the DB exist
SELECT name
FROM sys.databases
WHERE name = 'MashaDB';
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'MashaDB')
    PRINT 'Database exists';
ELSE
    PRINT 'Database does not exist';
-- Create Database 'Mashalocal'
USE master;
CREATE DATABASE MashaDB;

USE MashaDB;
GO
CREATE SCHEMA mashabronze;
GO
CREATE SCHEMA mashasilver;
GO
CREATE SCHEMA mashagold;
