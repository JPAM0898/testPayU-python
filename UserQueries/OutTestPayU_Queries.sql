USE [PayU]
GO

SELECT [trans_date_trans_time]
      ,[cc_num]
      ,[merchant]
      ,[category]
      ,[amt]
      ,[first]
      ,[last]
      ,[gender]
      ,[street]
      ,[city]
      ,[state]
      ,[zip]
      ,[lat]
      ,[long]
      ,[city_pop]
      ,[job]
      ,[dob]
      ,[trans_num]
      ,[unix_time]
      ,[merch_lat]
      ,[merch_long]
      ,[is_fraud]
      ,[currency]
      ,[amt_cop]
      ,[bin]
      ,[Calculation]
	  ,[count_zip]
	  ,[full_name]
	  ,[count_trans_person]
  FROM [JPAM].[tbOutTestPayU]

 --WHERE count_trans_person >1
 --WHERE [is_fraud] = 1
 --WHERE [count_trans_person] = '2'
 --WHERE city = 'Meridian'
 --ORDER BY [cc_num]

  /*SELECT [cc_num]
      ,[merchant]
      ,[bin]
      ,[Calculation]
  FROM [JPAM].[tbOutTestPayU]
  WHERE merchant = 'fraud_Deckow-O''Conner'
  ORDER BY bin*/

/*SELECT [merchant], SUM(CASE WHEN is_fraud = '1' then amt_cop else 0 END) as amt_total 
  FROM [JPAM].[tbOutTestPayU]
  GROUP BY merchant
  order by amt_total DESC*/


