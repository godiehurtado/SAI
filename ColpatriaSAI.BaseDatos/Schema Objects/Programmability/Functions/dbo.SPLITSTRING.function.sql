
 CREATE FUNCTION [dbo].[SPLITSTRING]   
    (         @STR NVARCHAR(4000),
              @SEPARATOR CHAR(1)  
                 )     
                 RETURNS TABLE     
                 AS     
                 RETURN 
                 (         
                 WITH TOKENS(P, A, B) 
                 AS 
                 ( 
                             SELECT 1,1,CHARINDEX(@SEPARATOR, @STR)
                             UNION ALL
                             SELECT P + 1,B + 1,CHARINDEX(@SEPARATOR, @STR, B + 1)
                             FROM TOKENS
                             WHERE B > 0)
                             SELECT P-1 ZEROBASEDOCCURANCE,SUBSTRING(@STR,A,CASE WHEN B > 0 THEN B-A ELSE 4000 END)
                             AS S
                             FROM TOKENS)

