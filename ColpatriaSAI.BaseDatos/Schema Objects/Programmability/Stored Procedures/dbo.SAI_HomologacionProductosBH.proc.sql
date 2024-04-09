-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Homologación del archivo de Productos de BH. Se toma la información por columnas (concepto) y se
--			    inserta en la tabla respectiva.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_HomologacionProductosBH]
AS
BEGIN

-- *********************************************************************************************************
-- HOMOLOGACIÓN X RAMODETALLE	
-- *********************************************************************************************************--	
	INSERT INTO RamoDetalle (
		codigoCore
		,nombre
		,compania_id
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_Ramo))
		,RTRIM(LTRIM(Ramo))
		,CAST(s.Cod_Compania AS INT)
	FROM Productotemp AS s
	INNER JOIN Compania ON RTRIM(LTRIM(Compania.codigoCore)) = RTRIM(LTRIM(s.Cod_Compania))
	WHERE s.Cod_Ramo <> ''
		AND Ramo <> ''
		AND s.Cod_Ramo IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM RamoDetalle AS v
			WHERE RTRIM(LTRIM(s.Cod_Ramo)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.Cod_Compania AS INT) = v.compania_id
				AND v.compania_id = 5
			)

	UPDATE RamoDetalle
	SET ramo_id = 0
	WHERE ramo_id IS NULL

-- *********************************************************************************************************
-- HOMOLOGACIÓN X AMPARODETALLE	
-- *********************************************************************************************************--	
	INSERT INTO AmparoDetalle (
		codigoCore
		,nombre
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_Amparo))
		,RTRIM(LTRIM(Amparo))
	FROM Productotemp AS s
	WHERE s.Cod_Amparo <> ''
		AND Amparo <> ''
		AND s.Cod_Amparo IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.Cod_Amparo)) = RTRIM(LTRIM(v.codigoCore))
			)

	UPDATE AmparoDetalle
	SET amparo_id = 1
	WHERE codigoCore = '51'

	UPDATE AmparoDetalle
	SET amparo_id = 1
	WHERE codigoCore = '52'

	UPDATE AmparoDetalle
	SET amparo_id = 1
	WHERE codigoCore = '60'

	UPDATE AmparoDetalle
	SET amparo_id = 1
	WHERE codigoCore = '79'

	UPDATE AmparoDetalle
	SET amparo_id = 2
	WHERE codigoCore = '42'

	UPDATE AmparoDetalle
	SET amparo_id = 2
	WHERE codigoCore = '82'

	UPDATE AmparoDetalle
	SET amparo_id = 2
	WHERE codigoCore = '83'

	UPDATE AmparoDetalle
	SET amparo_id = 2
	WHERE codigoCore = '84'

	UPDATE AmparoDetalle
	SET amparo_id = 0
	WHERE codigoCore NOT IN (
			'51'
			,'52'
			,'60'
			,'79'
			,'42'
			,'82'
			,'83'
			,'84'
			)

-- *********************************************************************************************************
-- HOMOLOGACIÓN X MODALIDADPAGODETALLE	
-- *********************************************************************************************************--	
	INSERT INTO ModalidadPagoDetalle (
		codigoCore
		,nombre
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_ModalidadPago))
		,RTRIM(LTRIM(ModalidadPago))
	FROM Productotemp AS s
	WHERE s.Cod_ModalidadPago <> ''
		AND ModalidadPago <> ''
		AND s.Cod_ModalidadPago IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM ModalidadPagoDetalle AS v
			WHERE RTRIM(LTRIM(s.Cod_ModalidadPago)) = RTRIM(LTRIM(v.codigoCore))
			)

	UPDATE ModalidadPagoDetalle
	SET modalidadPago_id = 1
	WHERE codigoCore = '2'
		AND modalidadPago_id IS NULL

	UPDATE ModalidadPagoDetalle
	SET modalidadPago_id = 2
	WHERE codigoCore IN (
			'3'
			,'4'
			,'5'
			,'6'
			,'7'
			,'8'
			,'9'
			,'10'
			,'11'
			,'12'
			,'13'
			,'14'
			,'15'
			,'16'
			,'17'
			,'18'
			,'19'
			,'20'
			,'99'
			)
		AND modalidadPago_id IS NULL

	UPDATE ModalidadPagoDetalle
	SET modalidadPago_id = 0
	WHERE codigoCore = '0'
		AND modalidadPago_id IS NULL

-- *********************************************************************************************************
-- HOMOLOGACIÓN X COBERTURA
-- *********************************************************************************************************--	
	INSERT INTO Cobertura (
		codigoCore
		,nombre
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_Cobertura))
		,RTRIM(LTRIM(Cobertura))
	FROM Productotemp AS s
	WHERE s.Cod_Cobertura <> ''
		AND Cobertura <> ''
		AND s.Cod_Cobertura IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM Cobertura AS v
			WHERE RTRIM(LTRIM(s.Cod_Cobertura)) = RTRIM(LTRIM(v.codigoCore))
			)

-- *********************************************************************************************************
-- HOMOLOGACIÓN X PRODUCTODETALLE
-- *********************************************************************************************************--	
	INSERT INTO ProductoDetalle (
		codigoCore
		,nombre
		,ramoDetalle_id
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_Producto))
		,RTRIM(LTRIM(Producto))
		,(
			SELECT RamoDetalle.id
			FROM RamoDetalle
			WHERE RTRIM(LTRIM(s.Cod_Ramo)) = RTRIM(LTRIM(RamoDetalle.codigoCore))
				AND RamoDetalle.compania_id = 5
			)
	FROM Productotemp AS s
	INNER JOIN RamoDetalle ON RTRIM(LTRIM(RamoDetalle.codigoCore)) = RTRIM(LTRIM(s.Cod_Ramo))
	INNER JOIN Compania ON RTRIM(LTRIM(Compania.codigoCore)) = RTRIM(LTRIM(s.Cod_Compania))
	WHERE s.Cod_Producto <> ''
		AND Producto <> ''
		AND s.Cod_Producto IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM ProductoDetalle AS v
			WHERE RTRIM(LTRIM(s.Cod_Producto)) = RTRIM(LTRIM(v.codigoCore))
				AND (
					SELECT RamoDetalle.id
					FROM RamoDetalle
					WHERE RTRIM(LTRIM(s.Cod_Ramo)) = RTRIM(LTRIM(RamoDetalle.codigoCore))
						AND RamoDetalle.compania_id = 5
					) = v.ramoDetalle_id
			)

	UPDATE ProductoDetalle
	SET producto_id = 0
	WHERE producto_id IS NULL

-- *********************************************************************************************************
-- HOMOLOGACIÓN X PLANDETALLE
-- *********************************************************************************************************--	
	INSERT INTO PlanDetalle (
		codigoCore
		,nombre
		,productoDetalle_id
		)
	SELECT DISTINCT RTRIM(LTRIM(Cod_Plan))
		,RTRIM(LTRIM([plan]))
		,(
			SELECT ProductoDetalle.id
			FROM ProductoDetalle
			INNER JOIN RamoDetalle ON RamoDetalle.id = ProductoDetalle.ramoDetalle_id
			WHERE RTRIM(LTRIM(s.Cod_Producto)) = RTRIM(LTRIM(ProductoDetalle.codigoCore))
				AND RTRIM(LTRIM(s.Cod_Ramo)) = RTRIM(LTRIM(RamoDetalle.codigoCore))
				AND RamoDetalle.compania_id = 5
			)
	FROM Productotemp AS s
	INNER JOIN ProductoDetalle ON RTRIM(LTRIM(ProductoDetalle.codigoCore)) = RTRIM(LTRIM(s.Cod_Producto))
	INNER JOIN RamoDetalle ON RTRIM(LTRIM(RamoDetalle.codigoCore)) = RTRIM(LTRIM(s.Cod_Ramo))
	INNER JOIN Compania ON RTRIM(LTRIM(Compania.codigoCore)) = RTRIM(LTRIM(s.Cod_Compania))
	WHERE s.Cod_Plan <> ''
		AND [Plan] <> ''
		AND s.Cod_Plan IS NOT NULL
		AND s.Cod_Compania = '5'
		AND s.Compania = 'BH'
		AND NOT EXISTS (
			SELECT *
			FROM PlanDetalle AS v
			WHERE RTRIM(LTRIM(s.Cod_Plan)) = RTRIM(LTRIM(v.codigoCore))
				AND (
					SELECT ProductoDetalle.id
					FROM ProductoDetalle
					INNER JOIN RamoDetalle ON RamoDetalle.id = ProductoDetalle.ramoDetalle_id
					WHERE RTRIM(LTRIM(s.Cod_Producto)) = RTRIM(LTRIM(ProductoDetalle.codigoCore))
						AND RTRIM(LTRIM(s.Cod_Ramo)) = RTRIM(LTRIM(RamoDetalle.codigoCore))
						AND RamoDetalle.compania_id = 5
					) = v.productoDetalle_id
			)

	UPDATE PlanDetalle
	SET plan_id = 0
	WHERE plan_id IS NULL
END
