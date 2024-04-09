CREATE PROCEDURE [dbo].[LiquidacionMadrugadores]
	@p_regla INT = 0,
	@p_condicion as INT = 0,
	@p_desde_fh as smalldatetime = null,
	@p_desde_fh_b as smalldatetime = null
	
AS
BEGIN

select participante.clave

from Participante 
inner join Negocio on negocio.participante_id = participante.id
inner join Recaudo on Recaudo.negocio_id = negocio.id



--WHERE   (@p_regla = 0 or Regla.id = @p_regla) 
--		AND (@p_condicion=0 or Condicion.id = @p_condicion)



END


--[LiquidacionMadrugadores] 