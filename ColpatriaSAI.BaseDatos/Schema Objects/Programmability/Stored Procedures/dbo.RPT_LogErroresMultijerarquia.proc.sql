-- =============================================
-- Author:		<Periferia I.T>
-- Create date: <2013-04-10>
-- Description:	<Reporte del log de errores de la carga de multijerarquía>
-- =============================================
CREATE PROCEDURE [rpt_LogErroresMultijerarquia] (
	@documentoDirector NVARCHAR(20)
	,@clave NVARCHAR(20)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT m.clave
		,m.companiaClave
		,(
			CASE 
				WHEN m.segmentoClave = ''
					THEN 'Sin Segmento'
				ELSE s.nombre
				END
			) AS segmentoClave
		,m.companiaDirector
		,m.codigoDirector
		,m.claseIntermediario
		,m.jerarquiaPago
		,m.provisional
		,m.tipoDocumentoDirector
		,m.documentoDirector
		,m.ErrorColumnName AS nombreColumna
		,m.ErrorColumnCode AS descripcionError
	FROM MultijerarquiaError m
	INNER JOIN Segmento s ON s.id = CAST(m.segmentoClave AS INT)
	WHERE m.documentoDirector LIKE ISNULL(@documentoDirector, m.documentoDirector)
		AND m.clave LIKE ISNULL(@clave, m.clave)
END

