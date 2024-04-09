CREATE PROCEDURE [dbo].[RPT_IngresosxAsesor]
(
	@fechaActual SMALLDATETIME = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	
	TRUNCATE TABLE IngresosxAsesor
	
	DECLARE
		@Periodo5 DATETIME,
		@Periodo4 DATETIME,
		@Periodo3 DATETIME,
		@Periodo2 DATETIME,
		@Periodo1 DATETIME,
		@Periodo6 DATETIME;
	
	set @Periodo6 = @fechaActual;

	SELECT
		@Periodo5 = DATEADD(MONTH, -1, @Periodo6),
		@Periodo4 = DATEADD(MONTH, -2, @Periodo6),
		@Periodo3 = DATEADD(MONTH, -3, @Periodo6),
		@Periodo2 = DATEADD(MONTH, -4, @Periodo6),
		@Periodo1 = DATEADD(MONTH, -5, @Periodo6);

	-- Inserta en la tabla temporal donde la fecha y el año del parametro @fechaActual sea igual al año y al periodo de la tabla Ingreso
	-- Cambio: 2012-03-15. 
	-- Inserta en la tabla temporal a los participantes que hayan tenido ingresos en los últimos 6 meses
	INSERT INTO IngresosxAsesor(clave, nombres, participante_id)
	SELECT
		RTRIM(LTRIM(p.clave)) as clave
		, RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos)) AS nombres
		, i.participante_id
	FROM Ingreso i
		INNER JOIN Participante p ON p.id = i.participante_id
	WHERE
		i.Periodo BETWEEN @Periodo1 AND @Periodo6
	GROUP BY
		i.participante_id
		, p.clave
		, p.nombre
		, p.apellidos
	ORDER BY
		p.clave

	-- Cambio: 2012-03-15
	-- Actualiza de acuerdo a los periodos calculados
	UPDATE IngresosxAsesor SET mesActual	= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo6) AND MONTH(i.Periodo) = MONTH(@Periodo6)) 
	UPDATE IngresosxAsesor SET [mes-1]		= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo5) AND MONTH(i.Periodo) = MONTH(@Periodo5)) 
	UPDATE IngresosxAsesor SET [mes-2]		= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo4) AND MONTH(i.Periodo) = MONTH(@Periodo4)) 
	UPDATE IngresosxAsesor SET [mes-3]		= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo3) AND MONTH(i.Periodo) = MONTH(@Periodo3)) 
	UPDATE IngresosxAsesor SET [mes-4]		= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo2) AND MONTH(i.Periodo) = MONTH(@Periodo2)) 
	UPDATE IngresosxAsesor SET [mes-5]		= (SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = IngresosxAsesor.participante_id AND YEAR(i.Periodo) = YEAR(@Periodo1) AND MONTH(i.Periodo) = MONTH(@Periodo1)) 

	SELECT
		ia.nombres
		, ia.clave
		, ia.mesActual
		, ia.[mes-1]
		, ia.[mes-2]
		, ia.[mes-3]
		, ia.[mes-4]
		, ia.[mes-5]
	FROM IngresosxAsesor ia
END