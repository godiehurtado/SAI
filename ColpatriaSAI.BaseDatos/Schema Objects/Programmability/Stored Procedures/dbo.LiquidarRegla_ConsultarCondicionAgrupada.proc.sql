
-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Procedimiento almacenado utilizado recursivamente para guardar las subreglas simples en orden de ogrupación y las subreglas agrupadas para liquidar sus resultados
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_ConsultarCondicionAgrupada] (
	@regla_id int,
	@CondicionAgrupada_id int
)
AS
BEGIN --DECLARE @regla_id int = 76   DECLARE @CondicionAgrupada_id int = 17
	IF @CondicionAgrupada_id IS NOT NULL BEGIN
		DECLARE @ID1 int, @ID2 int, @CA_ID1 int, @CA_ID2 int

		SELECT @ID1=CA.subregla_id1, @ID2=CA.subregla_id2
		FROM SubRegla S LEFT JOIN CondicionAgrupada CA on CA.id = S.condicionAgrupada_id 
		WHERE S.regla_id=@regla_id AND S.condicionAgrupada_id=@CondicionAgrupada_id
		
		IF @ID1 IS NOT NULL BEGIN
			SET @CA_ID1 = dbo.LiquidarRegla_BusquedaAgrupada(@ID1) --SELECT @CondicionAgrupada_id, @ID1, @CA_ID1
			IF @CA_ID1 IS NOT NULL BEGIN
				EXEC dbo.LiquidarRegla_ConsultarCondicionAgrupada @regla_id, @CA_ID1
			END ELSE BEGIN
				EXEC dbo.LiquidarRegla_GestionarExistentes 2, @ID1	--EXEC dbo.LiquidarRegla_ConstruirQuery @ID1, @regla_id
			END
		END/**/
		IF @ID2 IS NOT NULL BEGIN
			SET @CA_ID2 = dbo.LiquidarRegla_BusquedaAgrupada(@ID2) --SELECT @CondicionAgrupada_id, @ID2, @CA_ID2
			IF @CA_ID2 IS NOT NULL BEGIN
				EXEC dbo.LiquidarRegla_ConsultarCondicionAgrupada @regla_id, @CA_ID2/**/
			END ELSE BEGIN
				EXEC dbo.LiquidarRegla_GestionarExistentes 2, @ID2	--EXEC dbo.LiquidarRegla_ConstruirQuery @ID2, @regla_id
			END
		END
		--select @ID1, @ID2, @CA_ID1, @CA_ID2
	END
END
