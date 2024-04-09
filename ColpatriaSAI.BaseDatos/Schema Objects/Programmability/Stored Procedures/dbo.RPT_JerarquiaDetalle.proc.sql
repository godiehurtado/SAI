-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 01/02/2012
-- Description:	Procedimiento para la obtención del arbol de jerarquía como reporte
-- =============================================
CREATE PROCEDURE [dbo].[RPT_JerarquiaDetalle]
	@jerarquia_id INT
AS
BEGIN
	SET NOCOUNT ON;

	WITH Childs AS
	(
		SELECT
			id,
			padre_id,
			jerarquia_id,
			nombre,
			nivel_id,
			zona_id,
			localidad_id,
			canal_id,
			participante_id,
			codigoNivel,
			1 AS hLevel,
			CAST(CAST(id AS BINARY(4)) AS VARBINARY(8000)) AS SortPath
		FROM JerarquiaDetalle
		WHERE nivel_id = 5
		
		UNION ALL
		
		SELECT
			jd.id,
			jd.padre_id,
			jd.jerarquia_id,
			jd.nombre,
			jd.nivel_id,
			jd.zona_id,
			jd.localidad_id,
			jd.canal_id,
			jd.participante_id,
			jd.codigoNivel,
			hLevel + 1 AS hLevel,
			CAST(c.SortPath + CAST(jd.id AS BINARY(4)) AS VARBINARY(8000)) AS SortPath
		FROM
			JerarquiaDetalle AS jd
			INNER JOIN Childs AS c ON jd.padre_id = c.id
		WHERE jd.nivel_id <> 5
	)

	SELECT
		cs.id,
		SPACE((hlevel - 1) * 4) + cs.nombre AS jerarquia_nombre,
		cs.padre_id,
		z.nombre AS zona_nombre,
		l.nombre AS localidad_nombre,
		c.nombre AS canal_nombre,
		p.nombre AS participante_nombre,
		p.apellidos AS participante_apellidos,
		p.documento AS participante_documento,
		codigoNivel AS codigoNivel,
		n.nombre AS nivel_nombre
	FROM Childs cs
		INNER JOIN Zona z ON z.id = cs.zona_id
		INNER JOIN Localidad l ON l.id = cs.localidad_id
		INNER JOIN Canal c ON c.id = cs.canal_id
		INNER JOIN Participante p ON p.id = cs.participante_id
		INNER JOIN Nivel n ON n.id = cs.nivel_id
	WHERE jerarquia_id = @jerarquia_id
	ORDER BY SortPath
END