/*
===============================================
stored procedure: Load bronze layer
================================================
This stored procedure loads data into the 'bronze' schema from external csv files
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the 'BULK INSERT' command to load data from csv files to bronze tables.
parameters:
None..
usage example:
EXEC bronze.load_bronze;
*/
CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
  DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
SET @batch_start_time = GETDATE();
TRUNCATE TABLE Bronze.crm_cust_info;
BULK INSERT Bronze.crm_cust_info
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);
TRUNCATE TABLE Bronze.crm_prd_info;
BULK INSERT Bronze.crm_prd_info
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);

TRUNCATE TABLE Bronze.crm_sales_details;
BULK INSERT Bronze.crm_sales_details
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);

TRUNCATE TABLE Bronze.erp_loc_a101;
BULK INSERT Bronze.erp_loc_a101
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);

TRUNCATE TABLE Bronze.erp_cust_az12;
BULK INSERT Bronze.erp_cust_az12
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);

TRUNCATE TABLE Bronze.erp_px_cat_glv2;
BULK INSERT Bronze.erp_px_cat_glv2
FROM 'C:\Users\vishh\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK
);
SET @batch_end_time=GETDATE();
PRINT '============='
PRINT 'LOADING BRONZE LAYER IS COMPILED';
PRINT ' Total load duration:'+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR)+ 'seconds';
PRINT '============='
END TRY
BEGIN CATCH
  PRINT '========================'
  PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
  PRINT'Error Message'+ERROR_MESSAGE();
  PRINT'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
  PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
  PRINT '========================'
  
  

END CATCH
END






