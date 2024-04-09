
-- =============================================
-- Author:		<Enrique Gonzalez Araujo>
-- Create date: <30/11/2011>
-- Description:	<Reporte ejecutivo,intermediario,>
-- =============================================
CREATE PROCEDURE [dbo].[ReporteEjecutivoIntermedio] (@GP BIT)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RTRIM(LTRIM(p.nombre)) AS nombre
		,RTRIM(LTRIM(p.apellidos)) AS apellidos
		,td.nombre AS Tipo_Documento
		,p.documento
		,p.clave
		,p.email
		,p.fechaIngreso
		,p.fechaRetiro
		,ep.nombre AS Estado_Participante
		,p.fechaNacimiento
		,n.nombre AS Nivel
		,c.nombre AS Compañia
		,z.nombre AS Zona
		,l.nombre AS Localidad
		,can.nombre AS Canal
		,cat.nombre AS Categoria
		,p.salario
		,p.telefono
		,p.direccion
		,s.nombre AS Segmento
		,p.ingresosMinimos
		,tp.nombre AS Tipo_Participante
		,jPadre.nombre AS director
		,(
			CAST(YEAR(p.fechaIngreso) AS NVARCHAR(50)) + (
				CASE 
					WHEN LEN(CAST(MONTH(p.fechaIngreso) AS NVARCHAR(50))) = 1
						THEN ('0' + CAST(MONTH(p.fechaIngreso) AS NVARCHAR(50)))
					ELSE CAST(MONTH(p.fechaIngreso) AS NVARCHAR(50))
					END
				)) AS mesanioFIngreso FROM Participante p
			INNER JOIN Nivel n ON n.id = p.nivel_id
			INNER JOIN Compania c ON c.id = p.compania_id
			INNER JOIN Zona z ON z.id = p.zona_id
			INNER JOIN Localidad l ON l.id = p.localidad_id
			INNER JOIN Canal can ON can.id = p.canal_id
			INNER JOIN Categoria cat ON cat.id = p.categoria_id
			INNER JOIN TipoDocumento td ON td.id = p.tipoDocumento_id
			INNER JOIN Segmento s ON s.id = p.segmento_id
			INNER JOIN EstadoParticipante ep ON ep.id = p.estadoParticipante_id
			INNER JOIN TipoParticipante tp ON tp.id = p.tipoParticipante_id
			LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
			LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
			WHERE p.GP = @GP

				AND p.id > 0
			ORDER BY p.nombre 

END
		
