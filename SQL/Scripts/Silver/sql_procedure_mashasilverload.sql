/*
++++++++++++++++++
Purpose: This command executes a stored procedure named load_mashasilver that resides in the mashasilver schema. 
The purpose of this stored procedure is to load transformed data into the mashasilver tables.
 Warning: Leads to data overwrite.
++++++++++++++++++
*/
EXECUTE mashasilver.load_mashasilver;
