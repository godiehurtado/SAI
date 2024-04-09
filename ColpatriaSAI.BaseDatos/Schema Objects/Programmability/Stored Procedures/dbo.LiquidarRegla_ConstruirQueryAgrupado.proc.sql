-- =============================================
-- Author:		Frank Estaban Payares Ríos
-- Create date: 05/12/2011
-- Description:	Guarda en la tabla 'SubReglasTemp' las subreglas simples en orden de agrupación a través de llamados recursivos y las subreglas agrupadas para liquidar sus resultados
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_ConstruirQueryAgrupado]
	@regla_id int
AS
BEGIN
	--DECLARE @regla_id int=94    EXEC dbo.LiquidarRegla_GestionarExistentes 1, NULL
	DECLARE @idSubregla int=@regla_id, @SubRegla1 int, @SubRegla2 int, @CA_ID1 int, @CA_ID2 int, @CondicionAId as int, @ID1 int, @ID2 int, @id_subregla int, @inicial bit, @Id1Existe bit, @Id2Existe bit
	
	--**************************************************************************************************
	-- ASIGNA AL CURSOR INDICADO LA LISTA DE SUBREGLAS (AGRUPADAS Y SIMPLES) CON SUS AGRUPACIONES
	--**************************************************************************************************
	DECLARE @SubReglaList CURSOR SET @SubReglaList = CURSOR FAST_FORWARD FOR
		SELECT CA.subregla_id1, CA.subregla_id2, s.id, s.principal
			,(CASE WHEN CA.subregla_id1 IN (SELECT SubRegla.id FROM SubRegla) THEN 1 ELSE 0 END) AS V1
			,(CASE WHEN CA.subregla_id2 IN (SELECT SubRegla.id FROM SubRegla) THEN 1 ELSE 0 END) AS V2
		FROM SubRegla S LEFT JOIN CondicionAgrupada CA on CA.id = S.condicionAgrupada_id 
		WHERE S.regla_id=@idSubregla ORDER BY principal DESC, S.id DESC
	
	-- Recorre la lista de subreglas
	OPEN @SubReglaList FETCH NEXT FROM @SubReglaList INTO @ID1, @ID2, @id_subregla, @inicial, @Id1Existe, @Id2Existe
	WHILE @@FETCH_STATUS = 0 BEGIN
		IF @Id1Existe = 1 BEGIN
			-- Obtener el id de la agrupación de la primera subregla
			SET @CA_ID1 = dbo.LiquidarRegla_BusquedaAgrupada(@ID1)
			IF @CA_ID1 IS NOT NULL BEGIN
				-- Si la primera subregla contiene agrupación, se obtiene las subreglas asociadas a esta subregla agrupada
				EXEC dbo.LiquidarRegla_ConsultarCondicionAgrupada @idSubregla, @CA_ID1
			END ELSE BEGIN
				-- Si la primera subregla NO contiene agrupación, se almacena en la tabla 'SubReglasTemp'
				EXEC dbo.LiquidarRegla_GestionarExistentes 2, @ID1
			END
		END/**/
		IF @Id2Existe = 1 BEGIN
			-- Obtener el id de la agrupación de la primera subregla
			SET @CA_ID2 = dbo.LiquidarRegla_BusquedaAgrupada(@ID2)
			IF @CA_ID2 IS NOT NULL BEGIN
				-- Si la segunda subregla contiene agrupación, se obtiene las subreglas asociadas a esta subregla agrupada
				EXEC dbo.LiquidarRegla_ConsultarCondicionAgrupada @idSubregla, @CA_ID2
			END ELSE BEGIN
				-- Si la segunda subregla NO contiene agrupación, se almacena en la tabla 'SubReglasTemp'
				EXEC dbo.LiquidarRegla_GestionarExistentes 2, @ID2
			END
		END
		IF @Id1Existe = 1 AND @Id2Existe = 1 BEGIN
			-- SI LA 1ra Y 2da SUBREGLA CONTIENE AGRUPACIONES SE ALMACENA EN LA TABLA DE liquidacionReglasAgrupadas
			DECLARE @expresion varchar(3)=(SELECT O.expresion FROM CondicionAgrupada CA INNER JOIN Operador O ON CA.operador_id = O.id WHERE (CA.subregla_id1=@ID1 AND CA.subregla_id2=@ID2) OR (CA.subregla_id1=@ID2 AND CA.subregla_id2=@ID1))
			INSERT INTO liquidacionReglasAgrupadas VALUES (@id_subregla, @ID1, NULL, @ID2, NULL, @expresion, NULL)
		END
	FETCH NEXT FROM @SubReglaList INTO @ID1, @ID2, @id_subregla, @inicial, @Id1Existe, @Id2Existe
	END CLOSE @SubReglaList DEALLOCATE @SubReglaList
	
	--SELECT * FROM SubReglasTemp    select * from liquidacionReglasAgrupadas    EXEC dbo.LiquidarRegla_GestionarExistentes 0, NULL
	--INSERT INTO SubReglasTemp VALUES (96),(97),(93),(92),(94),(95)  DECLARE @idSubregla int=76
	--DECLARE @ID int=0, @SubReglaTemp CURSOR SET @SubReglaTemp = CURSOR FAST_FORWARD FOR  SELECT * FROM SubReglasTemp
END