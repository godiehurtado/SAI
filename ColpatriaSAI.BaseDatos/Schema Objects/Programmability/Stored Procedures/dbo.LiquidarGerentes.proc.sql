-- =============================================
-- Author:		Frank Payares
-- Create date: 16/09/2011
-- Description:	Liquida un modelo de contratación por vigencia
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarGerentes]
	@idLiqui int = 0,
	@Fecha datetime
AS
BEGIN
	--DECLARE @idLiqui int SET @idLiqui = 1		DECLARE @Fecha datetime SET @Fecha = 1
	DECLARE @LiquiContrat TABLE (id int IDENTITY(1,1), liqui_contrat_id int, participante_id int, meta_id int, presupuesto float, ejecutado float,
									cumplimiento float, nota float, pesoNota float, notaPonderada float, salario float, nivel_id int)
	--DECLARE @tempTabla TABLE (id int, liqui_contrat_id int, participante_id int, meta_id int, presupuesto float, ejecutado float,
	--								cumplimiento float, nota float, pesoNota float, notaPonderada float, salario float, nivel_id int)
	--LiquiContratMeta
	INSERT INTO @LiquiContrat (liqui_contrat_id, participante_id, meta_id, presupuesto, ejecutado, cumplimiento, nota, pesoNota, notaPonderada, salario, nivel_id)
	--OUTPUT INSERTED.* INTO @LiquiContrat
	SELECT	@idLiqui, Participante.id as Participante_id, Meta.id AS Meta_id, /*Participante.nombre as nombrePpante, Meta.nombre AS nombreMeta,*/ 
			valor AS Ppto, TablaMaestra.cantidadColquines AS Ejec, TablaMaestra.cantidadColquines/DetallePresupuesto.valor AS Cumpli, 
			dbo.getNotaMeta(TablaMaestra.cantidadColquines/DetallePresupuesto.valor, Meta.id, MONTH(ModeloxParticipante.fechaIni)) AS Nota,
			ModeloxMeta.peso as Peso, 
			ModeloxMeta.peso * dbo.getNotaMeta(TablaMaestra.cantidadColquines/DetallePresupuesto.valor, Meta.id, MONTH(ModeloxParticipante.fechaIni)) AS NotaPonderada,
			salario, Participante.nivel_id
	FROM	Participante INNER JOIN
			  ModeloxParticipante ON Participante.id = ModeloxParticipante.participante_id INNER JOIN
			  DetallePresupuesto ON Participante.documento = DetallePresupuesto.documento INNER JOIN
			  Meta ON DetallePresupuesto.meta_id = Meta.id INNER JOIN
			  Modelo ON ModeloxParticipante.modelo_id = Modelo.id INNER JOIN
			  ModeloxMeta ON Meta.id = ModeloxMeta.meta_id AND Modelo.id = ModeloxMeta.modelo_id LEFT OUTER JOIN
			  TablaMaestra ON Participante.id = TablaMaestra.participante_id
	WHERE     MONTH(DetallePresupuesto.fechaIni) = month(@Fecha)
	GROUP BY Participante.id, Meta.id, Participante.nombre, Meta.nombre, DetallePresupuesto.valor, 
			TablaMaestra.cantidadColquines, ModeloxParticipante.fechaIni, ModeloxMeta.peso, salario, Participante.nivel_id
	ORDER BY Participante.nombre, Meta.nombre
	
	INSERT INTO LiquiContratMeta (liqui_contrat_id, participante_id, meta_id, presupuesto, ejecutado, cumplimiento, nota, pesoNota, notaPonderada)
		SELECT liqui_contrat_id, participante_id, meta_id, presupuesto, ejecutado, cumplimiento, nota, pesoNota, notaPonderada
		FROM @LiquiContrat WHERE nivel_id > 2

	SELECT *--SUM(notaPonderada)
	FROM @LiquiContrat
END