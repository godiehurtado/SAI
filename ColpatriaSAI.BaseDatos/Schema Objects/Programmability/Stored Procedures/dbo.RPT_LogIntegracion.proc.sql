CREATE PROCEDURE [dbo].[RPT_LogIntegracion]
(
	@fechaConsulta AS DATE
)
AS
BEGIN

	SELECT li.fechaInicio
	, li.fechaFin
	, li.proceso
	, (CASE WHEN li.estado = 1 THEN 'En Proceso' ELSE
	  CASE WHEN li.estado = 2 THEN 'Terminado' ELSE 
	  CASE WHEN li.estado = 3 THEN 'Con Error' END END END) AS estado
	, li.cantidad
	, li.sistemaOrigen
	, li.sistemaDestino
	, li.tablaDestino 
	FROM LogIntegracion li
	WHERE CAST(li.fechaInicio AS DATE) = @fechaConsulta
	
END