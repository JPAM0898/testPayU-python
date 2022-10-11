USE [PayU]
GO

SELECT [merchant]
      ,[trans_num]
      ,[total_amt_cop]
      ,[count_is_fraud]
      ,[countDis_cc_num]
      ,[total_fraud_amt_cop]
      ,[perc_fraud_trans]
      ,[perc_fraud_total]
  FROM [JPAM].[tbP10PayU]
  ORDER BY [perc_fraud_total] DESC
GO



