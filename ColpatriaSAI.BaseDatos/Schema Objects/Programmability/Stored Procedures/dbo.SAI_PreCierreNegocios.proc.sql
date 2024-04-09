/*CREATE PROCEDURE [dbo].[SAI_PreCierreNegocios]

@compania_id AS INT,
@sistema AS NVARCHAR (20),
@sistemaOrigen AS NVARCHAR (20)

AS
BEGIN

	DECLARE @fechaDia AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 103),103))
	DECLARE @fechaCierre AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), fechaCierre, 103),103) FROM PeriodoCierre WHERE compania_id = @compania_id AND estado = 1)
	DECLARE @mesCierre AS INT = (SELECT mesCierre FROM PeriodoCierre WHERE compania_id = @compania_id AND estado = 1)
	DECLARE @anioCierre AS INT = (SELECT anioCierre FROM PeriodoCierre WHERE compania_id = @compania_id AND estado = 1)

--  Valida si hay información en Negociostemp, es decir, que el archivo plano haya sido generado con datos.
	IF EXISTS (SELECT * FROM Negociostemp WHERE compania_id = @compania_id AND sistema = @sistema)
	BEGIN
			
	--  Si existen registros en Negociostemp, se borran los registros de la tabla Negocio donde el estado sea abierto (1)
		DELETE
		FROM Negocio
		WHERE estadoCierre = 1
		AND compania_id = @compania_id
		AND sistema = @sistema
		
	--  Actualiza los registros de la compania a estado abierto.
		UPDATE Negociostemp
		SET estadoCierre = 1
		, mesCierre = @mesCierre
		, anioCierre = @anioCierre
		WHERE compania_id = @compania_id
		AND sistema = @sistema
		AND (estadoCierre <> 2 OR estadoCierre IS NULL) --> Esto es por que el día del cierre ya quedan marcados en NegociostempVida (Registros de VIda que vienen en Generales)
											  --> registros cerrados y no se deben actualizar a estado abierto (1)
	
		IF (@fechaDia = @fechaCierre)
		BEGIN
		
		--  Si existen registros en Negociostemp éstos se actualizan a estado cerrado (2)
			UPDATE Negociostemp
			SET estadoCierre = 2
			, mesCierre = @mesCierre
			, anioCierre = @anioCierre
			WHERE compania_id = @compania_id
			AND sistema = @sistema
			AND (estadoCierre <> 2 OR estadoCierre IS NULL)
			
		END		
			
--  Toma el máximo id del log de inserción en Negociostemp. 
	DECLARE @regisActSiseVida AS INT = (SELECT MAX(id) FROM LogIntegracion WHERE tablaDestino = 'Negociostemp' AND proceso = 'Negocios' + ' ' + @sistema  AND estado = 1)

--  Cantidad de Registros insertados desde el archivo plano a la tabla Negociostemp
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM Negociostemp WHERE compania_id = @compania_id AND sistema = @sistema)

--  Actualiza el registro del log de inserción en Negociostemp cuando la carga a ésta tabla finalizó.
	UPDATE LogIntegracion 
	SET fechaFin = GETDATE()
	, estado = 2
	, cantidad = @cantidadRegistros 
	WHERE id = @regisActSiseVida

--  Inserta en el log de Inserción de datos el inicio del proceso de carga y homologación hacia dbo.Negocio
	INSERT INTO LogIntegracion (fechaInicio, proceso, estado, sistemaOrigen, sistemaDestino, tablaDestino) 
	VALUES (GETDATE(), 'Negocios' + ' ' + @sistema, 1, @sistemaOrigen, 'SAI', 'Negocio')
	
	END
			
--  Si no existe información en Negociostemp
	IF NOT EXISTS (SELECT * FROM Negociostemp WHERE compania_id = @compania_id AND sistema = @sistema)
	BEGIN
		
			IF (@fechaDia = @fechaCierre)
			BEGIN
			
		--  Se actualiza la fecha de cierre al día siguiente, donde el estado sea abierto (1)
			UPDATE PeriodoCierre
			SET fechaCierre = DATEADD(DAY, 1, fechaCierre)
			WHERE compania_id = @compania_id
			AND estado = 1
			
			END
	
	END
END*/