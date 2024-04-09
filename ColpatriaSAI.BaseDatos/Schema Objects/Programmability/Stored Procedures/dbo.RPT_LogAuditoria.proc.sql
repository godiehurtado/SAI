
CREATE PROCEDURE [dbo].[RPT_LogAuditoria] @fechaConsulta AS DATE
AS
BEGIN
	SELECT L.LogID
		,L.MachineName AS NombreEquipo
		,L.TIMESTAMP FechaHora
		,L.ProcessID IdProceso
		,L.ProcessName NombreProceso
		,L.Title Modulo
		,L.Message AS Mensaje
	FROM log.Log L
	JOIN log.CategoriaLog CL ON CL.LogID = L.LogID
	WHERE CL.CategoryID = 1
		AND CAST(L.TIMESTAMP AS DATE) = @fechaConsulta
END