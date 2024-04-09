-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Obtiene la condición agrupada de una subregla
-- =============================================
CREATE FUNCTION [dbo].[LiquidarRegla_BusquedaAgrupada] (
	@SubRegla int-- = 100
)
RETURNS int
AS
BEGIN
	RETURN (
		--DECLARE @SubRegla int = 100
		SELECT S.condicionAgrupada_id
		FROM SubRegla S LEFT JOIN 
			CondicionAgrupada CA ON CA.id = S.condicionAgrupada_id 
		WHERE S.id = @SubRegla
	)
END