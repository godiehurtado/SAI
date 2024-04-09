-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcularMetasCompuestasPresupuesto]
	-- Add the parameters for the stored procedure here
	@presupuestoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @mes int = 0, @valor float = 0, @presupuesto_id int = @presupuestoId
	DECLARE @Sentencia nvarchar(350), @param nvarchar(20), @fechaIni date, @fechaFin date
	DECLARE @meta_id int = 0, @jerarquiaDetalle_id int = 0, @metasSimples varchar(50) = ''

	DECLARE @anio int = (SELECT YEAR(fechaInicio) FROM presupuesto WHERE id = @presupuesto_id)

	INSERT INTO ProcesoLiquidacion VALUES (4, @presupuesto_id, GETDATE(), 7)

	-- BORRAMOS TABLAS NECESARIAS
	DELETE FROM dp FROM DetallePresupuesto as dp INNER JOIN Meta as m ON dp.meta_id = m.id WHERE dp.presupuesto_id = @presupuesto_id AND m.tipoMetaCalculo_id = 2

	-- BORRAMOS TODAS LAS METAS DE LOS NODOS CORRESPONDIENTES AL AÑO DEL PRESUPUESTO
	DELETE FROM mn 
	FROM Metaxnodo as mn
	-- SE ACTUALIZA EL PROCESO PARA QUE SE GUARDEN TODAS LAS METAS A LOS NODOS DEL PRESUPUESTO
	--INNER JOIN Meta as m ON mn.meta_id = m.id
	--INNER JOIN MetaCompuesta as mc ON mn.meta_id = mc.metaOrigen_Id
	WHERE
		mn.anio = @anio --AND m.tipoMetaCalculo_id = 2
	
	-- INSERTAMOS TODAS LAS METAS POR NODO DE LOS NODOS QUE TIENEN PRESUPUESTO	
	INSERT INTO MetaxNodo(meta_id,jerarquiaDetalle_id,anio)
	-- METAS SIMPLES
	SELECT
		sub1.meta_id,
		sub2.jerarquiaDetalle_id,
		@anio	
	FROM	
		(SELECT m.id as meta_id  
		FROM Meta as m INNER JOIN DetallePresupuesto as dp ON m.id = dp.meta_id
		WHERE dp.presupuesto_id = @presupuesto_id
		GROUP BY m.id
		) as sub1
		,
		(
		SELECT jerarquiaDetalle_id
		FROM detallepresupuesto
		WHERE presupuesto_id = @presupuesto_id
		GROUP BY jerarquiaDetalle_id
		) as sub2		
	UNION
	-- METAS COMPUESTAS
	SELECT
		sub1.meta_id,
		sub2.jerarquiaDetalle_id,
		@anio	
	FROM	
		(SELECT m.id as meta_id  
		FROM Meta as m 
		INNER JOIN MetaCompuesta as mc ON m.id = mc.metaOrigen_Id
		WHERE m.tipoMetaCalculo_id = 2	
		GROUP BY m.id
		) as sub1
		,
		(
		SELECT jerarquiaDetalle_id
		FROM detallepresupuesto
		WHERE presupuesto_id = @presupuesto_id
		GROUP BY jerarquiaDetalle_id
		) as sub2		
	UNION
	-- METAS ACUMULADAS
	SELECT
		sub1.meta_id,
		sub2.jerarquiaDetalle_id,
		@anio	
	FROM	
		(SELECT m.id as meta_id  
		FROM Meta as m 
		WHERE m.tipoMetaCalculo_id = 2 and m.meta_id is not null	
		GROUP BY m.id
		) as sub1
		,
		(
		SELECT jerarquiaDetalle_id
		FROM detallepresupuesto
		WHERE presupuesto_id = @presupuesto_id
		GROUP BY jerarquiaDetalle_id
		) as sub2
			
	UPDATE ProcesoLiquidacion SET estadoProceso_id = 8 WHERE tipo=4 AND liquidacion_id=@presupuesto_id	

	-- ***************************************************
	-- CALCULAMOS LAS METAS COMPUESTAS PARA EL PRESUPUESTO
	-- ***************************************************
	
	INSERT INTO DetallePresupuesto(fechaIni, fechaFin, valor, meta_id, presupuesto_id, jerarquiaDetalle_id)
	SELECT
		CAST(@anio as varchar) + '-' + CAST(sub1.mes as varchar) + '-01' as fechaIni,
		CAST(@anio as varchar) + '-' + CAST(sub1.mes as varchar) + '-28' as fechaFin,
		sub1.valor,
		sub1.metaOrigen_id,
		@presupuesto_id as presupuesto_id,
		sub1.jerarquiaDetalle_id
	FROM
	(	
		SELECT  dp.jerarquiaDetalle_id, mc.metaOrigen_id, MONTH(dp.fechaIni) as mes,sum(dp.valor) as valor
		FROM detallepresupuesto as dp
		INNER JOIN metaCompuesta as mc ON dp.meta_id = mc.metaDestino_Id		
		WHERE dp.presupuesto_id = @presupuesto_id
		GROUP BY dp.jerarquiaDetalle_id, mc.metaOrigen_id, YEAR(dp.fechaIni), MONTH(dp.fechaIni)
	) as sub1
		
	RETURN 1
END
