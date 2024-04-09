CREATE PROCEDURE ValidacionCargueCAPIRecaudos
AS  
BEGIN
DECLARE @countRegistroCAPIRecaudo int
		,@consecutivo INT = 0
		,@valorprimaTotalCAPIRecaudo NUMERIC (18,2)
		,@countRegistroCAPIRecaudoReporte int
		,@valorprimaTotalCAPIRecaudoReporte NUMERIC (18,2)
		
 
 	INSERT INTO [ResultadoCargueEtls]
             (
				[nombreDelProceso]
			   ,[countRegistrosProcesados]
			   ,[sumValorTotalPrima]
			   ,[valido]
            )
 	
	SELECT  'ETLRecaudosCAPI' NombreDelProceso
			, count(*)
			,SUM(ISNULL(valorRecaudo,0))
			,0				
	FROM RecaudostempCAPI
---------------------------------------------

--- REGISTROS  RECAUDO CAPI
	
	SET @countRegistroCAPIRecaudo = (SELECT  TOP 1  [countRegistrosProcesados]
										FROM  [ResultadoCargueEtls] 
										WHERE NombreDelProceso = 'ETLRecaudosCAPI'
										AND   CONVERT(DATE,fechaInicio)  = CONVERT(DATE,GETDATE())
											ORDER BY consecutivo DESC)
											
	SET @valorprimaTotalCAPIRecaudo = (SELECT TOP 1 sumValorTotalPrima
											FROM  [ResultadoCargueEtls]
										WHERE NombreDelProceso = 'ETLRecaudosCAPI'
										AND   CONVERT(DATE,fechaInicio)  = CONVERT(DATE,GETDATE())
										ORDER BY consecutivo DESC)

	SET @consecutivo = (SELECT TOP 1 consecutivo
											FROM  [ResultadoCargueEtls]
										WHERE NombreDelProceso = 'ETLRecaudosCAPI'
										AND   CONVERT(DATE,fechaInicio)  = CONVERT(DATE,GETDATE())
										ORDER BY consecutivo DESC)
										
	------------------ REGISTROS TREPORTRECAUDOSCAPI --------------------------------------
	
		SET @countRegistroCAPIRecaudoReporte = (
												SELECT  TOP 1 [countRegistrosProcesados]
												FROM  [ResultadoCargueEtls] 
												WHERE NombreDelProceso = 'ETLRecaudosCAPIReporte'
												AND   CONVERT(DATE,fechaInicio)  = (select MAX(CONVERT(date,fechainicio))
																 from ResultadoCargueEtls
																 WHERE NombreDelProceso = 'ETLRecaudosCAPIReporte')
														ORDER BY consecutivo DESC		
												)
												 
								
	-- VALIDAMOS QUE EL COUNT Y EL SUM SEAN IGUALES
	
	IF @countRegistroCAPIRecaudo = @countRegistroCAPIRecaudoReporte
	
		BEGIN
		  
			UPDATE RCETL
				SET valido = 1
				, mensaje = 'Los count son iguales countRecaudosCAPI: ' + CAST(@countRegistroCAPIRecaudo as nvarchar(100))  + ' CountRecaudoCAPIReporte=' + CAST(@countRegistroCAPIRecaudoReporte as nvarchar(100))
			FROM [ResultadoCargueEtls] RCETL
			WHERE nombreDelProceso= 'ETLRecaudosCAPI' AND consecutivo = @consecutivo			
		END
	ELSE
		BEGIN
			UPDATE RCETL
			 SET mensaje = 'LOS VALORES NO SON IGUALES: ' + CAST(@countRegistroCAPIRecaudo as nvarchar(100))  + ' CountRecaudoCAPIReporte=' + CAST(@countRegistroCAPIRecaudoReporte as nvarchar(100))
			FROM [ResultadoCargueEtls] RCETL
			WHERE nombreDelProceso= 'ETLRecaudosCAPI' AND consecutivo = @consecutivo	
		END	
					
		SELECT valido from ResultadoCargueEtls 
		where nombreDelProceso = 'ETLRecaudosCAPI'  AND consecutivo = @consecutivo
		
            
END

