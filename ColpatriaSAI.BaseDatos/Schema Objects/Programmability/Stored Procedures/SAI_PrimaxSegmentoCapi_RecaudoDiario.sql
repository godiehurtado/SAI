-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ALBERTO PALENCIA BENEDETTI
-- Create date: 2013-09-27
-- Description:	INSERTA LA DIFERENCIA ENTRE LOS CORE SIG Y SAI, PARA SABER EL VALOR POR SEGMENTO DE PRIMAS RECAUDOS
-- =============================================
CREATE PROCEDURE SAI_PrimaxSegmentoCapi_RecaudoDiario
	
AS
BEGIN

	SET NOCOUNT ON;

DECLARE @idpanel INT = 0
,@mesCierre int = 0
, @anioCierre int = 0

SET @idpanel = (SELECT id FROM TipoPanel WHERE nombre = 'Consolidado Primas x Segmento Diaro')



SET @mesCierre = (SELECT
					 mesCierre
				FROM PERIODOCIERRE
				WHERE COMPANIA_ID = 3 AND ESTADO = 1) 
				
SET @anioCierre = (SELECT
					 anioCierre
				FROM PERIODOCIERRE
				WHERE COMPANIA_ID = 3 AND ESTADO = 1)

/*************** ELIMINAMOS LOS REGISTROS CARGADOS ANTERIORMENTE ***************** */

DELETE  FROM  Dashboard 
WHERE tipoPanel_id = @idpanel 
AND CONVERT(VARCHAR(1000),descripcion) IN('Primas x Segmento Diario CORE') and valor1 = 'CAPI'

/******************************************************* */

--- INSERTAMOS LO VALORES DEL CORE SIG

	INSERT INTO DASHBOARD (DESCRIPCION,VALOR1,VALOR2,VALOR3,TIPOPANEL_ID)
	SELECT 
			 descripcion
			,[COMPANIA]
			,SEGMENTO
			,CONVERT(VARCHAR(1000), CAST(STR(VALORPRIMATOTAL, 13, 2) AS MONEY), 1) VALORPRIMATOTAL 
			,@idpanel TIPOPANEL
		FROM  temporalsegmentoCAPISIG
		WHERE DESCRIPCION = 'Primas x Segmento Diario CORE'
	

--- INSERTAMOS LO VALORES DEL CORE SAI  REPLACE(SUM(valorprimatotal),'.',','))


	INSERT INTO DASHBOARD (DESCRIPCION,VALOR1,VALOR2,VALOR3,TIPOPANEL_ID)
	
		SELECT
			'Primas x Segmento Diario SAI' as descripcion
			,'CAPI'
			,case when segmento_id = 1 then 'PYP' ELSE cast(segmento_id as varchar(100)) END AS Segmento
			,CONVERT(VARCHAR(1000), CAST(STR(SUM(valorRecaudo), 13, 2) AS MONEY), 1) as  ValortotalPrima
			,@idpanel  as tipopanel
		from Recaudo where mesCierre = @mesCierre and anioCierre = @anioCierre and compania_id = 3
		group by segmento_id
	
	
END
GO
