SHOW con_name;

CREATE PLUGGABLE DATABASE Inventory_Billing 
ADMIN USER Atif_Sarwar IDENTIFIED BY ORACLE_project
ROLES = (DBA)
FILE_NAME_CONVERT = (
    'C:\ORACEL\21C\ORADATA\XE\PDBSEED\', 
    'C:\ORACEL\21C\ORADATA\XE\INVENTORY_BILLING\'
);


--opening database
ALTER PLUGGABLE DATABASE Inventory_Billing OPEN;

-- Saving state 
ALTER PLUGGABLE DATABASE Inventory_Billing SAVE STATE;


ALTER SESSION SET container = Inventory_Billing;
SHOW con_name;

SELECT tablespace_name, status, contents 
FROM dba_tablespaces;



--Allocating Resources and Table Space 

CREATE TABLESPACE inventory_data
DATAFILE 'C:\ORACEL\21C\ORADATA\XE\INVENTORY_BILLING\inventory_data01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

ALTER USER Atif_Sarwar QUOTA UNLIMITED ON inventory_data;
ALTER USER Atif_Sarwar DEFAULT TABLESPACE inventory_data;

show con_name;