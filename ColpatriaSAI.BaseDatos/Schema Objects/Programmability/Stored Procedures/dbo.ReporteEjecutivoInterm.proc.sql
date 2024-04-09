-- =============================================
-- Author:		<Enrique Gonzalez Araujo>
-- Create date: <30/11/2011>
-- Description:	<Reporte ejecutivo,intermediario,>
-- =============================================
CREATE PROCEDURE [dbo].ReporteEjecutivoInterm
(
	@GP bit
)
AS
	SET NOCOUNT ON;
SELECT        Participante.id, Participante.clave, Participante.codProductor, Participante.nombre, Participante.apellidos, Participante.documento, Participante.email, 
                         Participante.estadoParticipante_id, EstadoParticipante.nombre AS [Estado Participante], Participante.fechaIngreso, Participante.fechaRetiro, 
                         Participante.fechaNacimiento, Segmento.nombre AS Segmento, Nivel.nombre AS Nivel, Compania.nombre AS Compañia, Zona.nombre AS Zona, 
                         Localidad.nombre AS Localidad, Canal.nombre AS Canal, Categoria.nombre AS Categoria, TipoParticipante.nombre AS [Tipo Participante], 
                         TipoDocumento.nombre AS [Tipo Documento], Participante.ingresosMinimos, Participante.salario, Participante.telefono, Participante.direccion, Participante.GP
FROM					 Participante INNER JOIN
                         Segmento ON Participante.segmento_id = Segmento.id INNER JOIN
                         Nivel ON Participante.nivel_id = Nivel.id INNER JOIN
                         Compania ON Participante.compania_id = Compania.id INNER JOIN
                         Zona ON Participante.zona_id = Zona.id INNER JOIN
                         Localidad ON Participante.localidad_id = Localidad.id INNER JOIN
                         Canal ON Participante.canal_id = Canal.id INNER JOIN
                         Categoria ON Participante.categoria_id = Categoria.id INNER JOIN
                         TipoParticipante ON Participante.tipoParticipante_id = TipoParticipante.id INNER JOIN
                         TipoDocumento ON Participante.tipoDocumento_id = TipoDocumento.id INNER JOIN
                         EstadoParticipante ON Participante.estadoParticipante_id = EstadoParticipante.id
WHERE					(Participante.GP = @GP)