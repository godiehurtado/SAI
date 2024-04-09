-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_LiquidarAgrupadas]
	-- Add the parameters for the stored procedure here
	@liquidacionReglaXParticipante_Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	DECLARE @totalRegistros int
		
	-- ACTUALIZAMOS LAS REGLAS CON SUBREGLAS SIMPLES	
	UPDATE LiquidacionReglasAgrupadas
	SET resultado = (CASE operador
						WHEN 'AND' THEN 
							CASE
								WHEN resultado1 = 1 AND resultado2 = 1 THEN 1 ELSE 0
							END								
						WHEN 'OR' THEN 
							CASE
								WHEN resultado1 = 0 AND resultado2 = 0 THEN 0 ELSE 1
							END								
					 END) 				 	
	WHERE resultado1 is not null AND resultado2 is not null and resultado is null	
	
	-- DETERMINAMOS SI HAY AUN REGISTROS CON RESULTADO EN NULL
	SELECT @totalRegistros = (SELECT count(*) FROM LiquidacionReglasAgrupadas lra WHERE lra.resultado1 is null OR lra.resultado2 is null) 	
	
	-- SI HAY TODAVIA REGISTROS EN NULL EJECUTAMOS LAS CONSULTAS PARA ACTUALIZAR LOS RESULTADOS	
	WHILE @totalRegistros > 0
		BEGIN

			UPDATE lra
			SET lra.resultado1 = lra1.resultado
			FROM LiquidacionReglasAgrupadas lra
			INNER JOIN LiquidacionReglasAgrupadas lra1 ON lra.subregla_id1 = lra1.subregla_id
			WHERE lra.resultado1 is null 

			UPDATE lra
			SET lra.resultado2 = lra1.resultado
			FROM LiquidacionReglasAgrupadas lra
			INNER JOIN LiquidacionReglasAgrupadas lra1 ON lra.subregla_id2 = lra1.subregla_id
			WHERE lra.resultado2 is null 

			UPDATE LiquidacionReglasAgrupadas
			SET resultado = (CASE operador
								WHEN 'AND' THEN 
									CASE
										WHEN resultado1 = 1 AND resultado2 = 1 THEN 1 ELSE 0
									END								
								WHEN 'OR' THEN 
									CASE
										WHEN resultado1 = 0 AND resultado2 = 0 THEN 0 ELSE 1
									END								
							 END) 				 	
			WHERE resultado1 is not null AND resultado2 is not null and resultado is null

			SELECT @totalRegistros = (SELECT count(*) FROM LiquidacionReglasAgrupadas lra WHERE lra.resultado1 is null OR lra.resultado2 is null) 	
		END			
	
	--INSERTAMOS LOS REGISTROS DE LA EVALUACION EN DETALLE LIQUIDACION REGLA
	INSERT INTO DetalleLiquiRegla (liquidacionReglaxParticipante_id, subregla_id, resultado)
	SELECT
		@liquidacionReglaXParticipante_Id,
		subregla_id,
		resultado
	FROM 
		LiquidacionReglasAgrupadas	
	
	--ACTUALIZAMOS LOS RESULTADOS A NULL PARA LIQUIDACIONES DE OTROS PARTICIPANTES
	UPDATE LiquidacionReglasAgrupadas SET resultado1 = NULL, resultado2 = NULL, resultado = NULL
	
END

