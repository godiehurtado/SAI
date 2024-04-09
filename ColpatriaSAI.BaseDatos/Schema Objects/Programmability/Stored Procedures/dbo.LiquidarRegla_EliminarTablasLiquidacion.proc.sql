
-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 10/01/2012
-- Description:	Elimina todas las tablas de liquidación temporales creadas durante el proceso de liquidación
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_EliminarTablasLiquidacion]
AS
BEGIN
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResultadosLiquidacionSimple]') AND type in (N'U'))	DROP TABLE ResultadosLiquidacionSimple
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[liquidacionReglasAgrupadas]') AND type in (N'U'))		DROP TABLE liquidacionReglasAgrupadas
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tablaPpantes]') AND type in (N'U'))					DROP TABLE tablaPpantes
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TiposTablas]') AND type in (N'U'))					DROP TABLE TiposTablas
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LiquiRegla]') AND type in (N'U'))						DROP TABLE LiquiRegla
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LiquiReglaxPpante]') AND type in (N'U'))				DROP TABLE LiquiReglaxPpante
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetalleLiquiRegla]') AND type in (N'U'))				DROP TABLE DetalleLiquiRegla
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetalleLiquiSubRegla]') AND type in (N'U'))			DROP TABLE DetalleLiquiSubRegla
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TablaMaestra_TEMP]') AND type in (N'U'))				DROP TABLE TablaMaestra_TEMP
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes_TEMP]') AND type in (N'U'))			DROP TABLE ConsolidadoMes_TEMP
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMesEjecutivo_TEMP]') AND type in (N'U'))	DROP TABLE ConsolidadoMesEjecutivo_TEMP
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PresupuestoEjecutadoxMetaTemp]') AND type in (N'U'))	DELETE FROM PresupuestoEjecutadoxMetaTemp
END