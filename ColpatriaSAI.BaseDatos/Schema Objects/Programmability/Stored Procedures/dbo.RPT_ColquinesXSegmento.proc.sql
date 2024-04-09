-- =============================================
-- Author:		<Juan Pablo Ruiz>
-- Create date: <15/03/2012>
-- Description:	Reporte de colquines por segmento
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ColquinesXSegmento]
(
	@fechaInicio SMALLDATETIME,
	@fechaFin SMALLDATETIME,
	@compania_id INT,
	@ramo_id INT,
	@zona_id INT,
	@localidad_id INT,
	@clave as NVARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @fechaInicio as smalldatetime = '2011-01-01',@fechaFin as smalldatetime = '2011-01-31',@compania_id as int = 5,@ramo_id as int = 0,@zona_id as int = 0 ,@localidad_id as int = 0,@clave as nvarchar(100)= null

	DECLARE 	@fechaInicioTemp SMALLDATETIME	= @fechaInicio,
				@fechaFinTemp SMALLDATETIME		= @fechaFin,
				@compania_idTemp INT			= @compania_id,
				@ramo_idTemp INT				= @ramo_id,
				@zona_idTemp INT				= @zona_id,
				@localidad_idTemp INT			= @localidad_id,
				@claveTemp as NVARCHAR(50)		= @clave

    SELECT     
		c.nombre AS Compania
		, z.nombre AS Zona
		, l.nombre AS Localidad
		, r.clave AS Clave
		, LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
		, ra.nombre AS Ramo
		, CASE s.nombre WHEN '' THEN 'Ninguno' ELSE s.nombre END AS Segmento
		, COALESCE(SUM(r.Colquines),0) AS Colquines
	FROM Recaudo r
		INNER JOIN Compania c ON c.id = r.compania_id
		INNER JOIN Segmento s ON s.id = r.segmento_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN Ramo ra ON ra.id = rd.ramo_id
		INNER JOIN Participante pa ON pa.id = r.participante_id
		LEFT JOIN Zona z ON z.id = r.zona_id
		LEFT JOIN Localidad l ON l.id = r.localidad_id
	WHERE
		r.fechaRecaudo BETWEEN @fechaInicioTemp AND @fechaFinTemp
		AND (@compania_idTemp = 0 OR r.compania_id = @compania_idTemp)
		AND (@ramo_idTemp = 0 OR ra.id = @ramo_idTemp)
		AND r.clave LIKE ISNULL(@claveTemp, r.clave)
		AND (@zona_idTemp = 0 OR r.zona_id = @zona_idTemp)
		AND (@localidad_idTemp = 0 OR r.localidad_id = @localidad_idTemp)
	GROUP BY r.clave, c.nombre, ra.nombre, z.nombre, l.nombre, s.nombre, pa.nombre, pa.apellidos
END