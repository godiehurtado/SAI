-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Permite abrir un mes cerrado inmediatamente anterior al mes abierto, en términos de información de recaudos y negocios --
--              El estado del negocio y/o recaudo que se encontraba en cerrado (2), se pasa a abierto (1)				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_AbrirMesCerrado]

@compania AS INT,
@mesCierre AS INT,
@anioCierre AS INT

AS
BEGIN

-- *********************************************************************************************************
-- Se actualiza a estado abierto (1) el (los) negocio (s) diferentes de EMERMEDICA que tengan como atributo
-- la compañía, mes de cierre y año de cierre que entra por parámetro desde la aplicación
-- *********************************************************************************************************--
			UPDATE Negocio
			SET estadoCierre = 1
			WHERE compania_id = @compania
			AND mesCierre = @mesCierre
			AND anioCierre = @anioCierre
			AND sistema <> 'EMERMEDICA'
			
-- *********************************************************************************************************
-- Se actualiza a estado abierto (1) el (los) recaudo (s) diferentes de EMERMEDICA que tengan como atributo
-- la compañía, mes de cierre y año de cierre que entra por parámetro desde la aplicación
-- *********************************************************************************************************--
			UPDATE Recaudo
			SET estadoCierre = 1
			WHERE compania_id = @compania
			AND mesCierre = @mesCierre
			AND anioCierre = @anioCierre
			AND sistema <> 'EMERMEDICA'
			
END