--CREATE SCHEMA JPAM 

/*CREATE TABLE JPAM.tbFraudTestPayU
(
trans_date_trans_time datetime
,cc_num nvarchar(30)
,merchant nvarchar(50)
,category nvarchar(20)
,amt int
,first nvarchar(20)
,last nvarchar(20)
,gender nchar(1)
,street nvarchar(100)
,city nvarchar(50)
,state nvarchar(2)
,zip nchar(10)
,lat nchar(30)
,long nchar(30)
,city_pop int 
,job nvarchar(100)
,dob date
,trans_num nvarchar(100)
,unix_time bigint
,merch_lat bigint
,merch_long bigint
,is_fraud smallint 
,currency nchar(3)
)*/

--Select *FROM PayU.JPAM.tbFraudTestPayU

--DROP TABLE JPAM.tbFraudTestPayU
--TRUNCATE TABLE JPAM.tbFraudTestPayU

/*ALTER DATABASE PayU 
    MODIFY FILE ( NAME = ,   
                  FILENAME = '');  
 
ALTER DATABASE PayU  
    MODIFY FILE ( NAME = ,   
                  FILENAME = '');  */

--SELECT @@SERVERNAME

/*SELECT DISTINCT 
    local_tcp_port 
FROM sys.dm_exec_connections 
WHERE local_tcp_port IS NOT NULL */

/*SELECT category 
FROM PayU.JPAM.tbFraudTestPayU 
GROUP BY category
having COUNT(category) <15000
ORDER BY COUNT(category) DESC*/

/*SELECT Category,COUNT(category) as c_category 
FROM PayU.JPAM.tbFraudTestPayU 
GROUP BY category
having COUNT(category) <15000
ORDER BY c_category DESC*/

/*SELECT city,count(zip) as c_zip
FROM PayU.JPAM.tbFraudTestPayU
GROUP BY [city]
ORDER BY COUNT(zip) DESC*/

/*SELECT trans_date_trans_time, CONCAT(first,' ',last) AS [full_name], COUNT(cc_num) AS [num_trans]
FROM PayU.JPAM.tbFraudTestPayU
GROUP BY trans_date_trans_time,CONCAT(first,' ',last)
ORDER BY COUNT(cc_num) DESC*/

/*SELECT cc_num , is_fraud
FROM PayU.JPAM.tbFraudTestPayU
WHERE is_fraud = 1*/