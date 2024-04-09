CREATE PROCEDURE [dbo].[ListarParticipantesConcurso]
	@p_segmento INT = 0,
	@p_canal  INT = 0,
	@p_nivel INT = 0,
	@p_zona INT = 0,
	@p_localidad INT = 0,
	@p_compania INT = 0,
	@p_categoria INT = 0
	
AS
BEGIN

select	participante.clave, participante.nombre

from	Participante


END
