-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Éste procedimiento borra las tablas requeridas para la integración por ETL (Compañía) y proceso de carga (Negocio - Recaudo) -- 
--              Borra la información de las tablas que consolidan el log de Errores.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_BorrarTablasdeIntegracion]
AS
BEGIN

-- *********************************************************************************************************
-- RECAUDO: Borrado de tablas de Carga y Homologación por Compañía.
-- *********************************************************************************************************--

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempCAPI]') AND type in (N'U'))
	DROP TABLE RecaudostempCAPI
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempGENERALES]') AND type in (N'U'))
	DROP TABLE RecaudostempGENERALES
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempVIDA]') AND type in (N'U'))
	DROP TABLE RecaudostempVIDA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempBH]') AND type in (N'U'))
	DROP TABLE RecaudostempBH
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempEMERMEDICA]') AND type in (N'U'))
	DROP TABLE RecaudostempEMERMEDICA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempARP]') AND type in (N'U'))
	DROP TABLE RecaudostempARP

-- *********************************************************************************************************
-- RECAUDO: Borrado de tablas de Log de Errores y Split.
-- *********************************************************************************************************--

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorCAPI]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorCAPI
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorGENERALES]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorGENERALES
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorVIDA]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorVIDA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorBH]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorBH
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorEMERMEDICA]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorEMERMEDICA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecaudostempErrorARP]') AND type in (N'U'))
	DROP TABLE RecaudostempErrorARP
	
-- *********************************************************************************************************
-- NEGOCIO: Borrado de Carga y Homologación por Compañía.
-- *********************************************************************************************************--

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempCAPI]') AND type in (N'U'))
	DROP TABLE NegociostempCAPI
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempGENERALES]') AND type in (N'U'))
	DROP TABLE NegociostempGENERALES
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempVIDA]') AND type in (N'U'))
	DROP TABLE NegociostempVIDA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempBH]') AND type in (N'U'))
	DROP TABLE NegociostempBH
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempEMERMEDICA]') AND type in (N'U'))
	DROP TABLE NegociostempEMERMEDICA

-- *********************************************************************************************************
-- NEGOCIO: Borrado de Log de Errores y Split.
-- *********************************************************************************************************--

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempErrorCAPI]') AND type in (N'U'))
	DROP TABLE NegociostempErrorCAPI
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempErrorGENERALES]') AND type in (N'U'))
	DROP TABLE NegociostempErrorGENERALES
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempErrorVIDA]') AND type in (N'U'))
	DROP TABLE NegociostempErrorVIDA
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempErrorBH]') AND type in (N'U'))
	DROP TABLE NegociostempErrorBH
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NegociostempErrorEMERMEDICA]') AND type in (N'U'))
	DROP TABLE NegociostempErrorEMERMEDICA
	
-- *********************************************************************************************************
-- LOG DE ERRORES CONSOLIDADO: Borrado de la información del log de Errores Consolidado x Negocio y Recaudo.
-- *********************************************************************************************************--
	TRUNCATE TABLE NegociostempError
	TRUNCATE TABLE RecaudostempError

END