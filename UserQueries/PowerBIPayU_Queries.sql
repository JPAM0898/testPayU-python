
SELECT CAST([trans_date_trans_time] AS DATE) [trans_date]
      ,[cc_num]
      ,[merchant]
      ,[category]
      ,[gender]
      ,[city]
      ,[state]
      ,[trans_num]
      ,[is_fraud]
      ,[currency]
      ,[amt_cop]
      ,[bin]
      ,[Calculation]
	  ,[count_zip]
	  ,[full_name]
	  ,[count_trans_person]
  FROM [JPAM].[tbOutTestPayU] WITH (NOLOCK)
  WHERE[merchant] IN (SELECT TOP 10 [merchant]
  FROM [JPAM].[tbP10PayU] WITH (NOLOCK)
  ORDER BY [perc_fraud_total] DESC)
