CREATE PROCEDURE [dbo].[RPT_xEjecucionIntegracion] @fechaConsulta AS DATE
	-- X EJECUCION
AS
BEGIN
	SELECT p.PackageName AS NombrePaquete
		,pl.STATUS AS EstadoEjecucion
		,pel.StartDateTime AS HoraInicioTarea
		,pel.EndDateTime AS HoraFinTarea
		,pel.SourceName AS NombreTarea
		,dbo.CalcularDiferenciaHora(pel.EndDateTime, pel.StartDateTime) AS DuracionxTarea		
		,dbo.CalcularDiferenciaHora(pl.EndDateTime, pl.StartDateTime) AS DuracionETL
	FROM PackageLog pl
	INNER JOIN PackageVersion pv ON pl.PackageVersionID = pv.PackageVersionID
	INNER JOIN Package p ON pv.PackageID = p.PackageID
	INNER JOIN PackageTaskLog pel ON pel.PackageLogID = pl.PackageLogID
	WHERE CAST(pl.StartDateTime AS DATE) = @fechaConsulta
		AND p.PackageName NOT LIKE '%Reporte_%'
	ORDER BY p.PackageName
		,pl.StartDateTime
END
