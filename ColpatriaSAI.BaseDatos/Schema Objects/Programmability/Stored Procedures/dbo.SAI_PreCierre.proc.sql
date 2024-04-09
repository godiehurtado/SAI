/*CREATE PROCEDURE [dbo].[SAI_PreCierre]

@compania_id AS INT,
@sistema AS NVARCHAR (20)

AS
BEGIN

	DECLARE @fechaDia AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 103),103))
	DECLARE @fechaCierre AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), fechaCierre, 103),103) FROM PeriodoCierre WHERE compania_id = @compania_id AND estado = 1)

--  Valida si hay información en Negociostemp, es decir, que el archivo plano haya sido generado con datos.
	IF EXISTS (SELECT * FROM Negociostemp WHERE compania_id = @compania_id AND sistema = @sistema)
	BEGIN
			
	--  Si existen registros en Negociostemp, se borran los registros de la tabla Negocio donde el estado sea abierto (1)
		DELETE
		FROM Negocio
		WHERE estadoCierre = 1
		AND compania_id = @compania_id
		AND sistema = @sistema
	
		IF (@fechaDia = @fechaCierre)
		BEGIN
		
		--  Si existen registros en Negociostemp éstos se actualizan a estado cerrado (2)
			UPDATE Negociostemp
			SET estadoCierre = 2
			WHERE compania_id = @compania_id
			AND sistema = @sistema
			
		END		
			
	--  Toma el máximo id del log de inserción en Negociostemp. 
	DECLARE @regisActSiseVida AS INT = (SELECT MAX(id) FROM LogIntegracion WHERE tablaDestino = 'Negociostemp' AND proceso = 'Negocios SISE VIDA' AND estado = 1)

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
	VALUES (GETDATE(), 'Negocios SISE VIDA', 1, 'SISE', 'SAI', 'Negocio')
	
	END
			
--  Si no existe información en Negociostemp
	IF NOT EXISTS (SELECT * FROM Negociostemp WHERE compania_id = '2' AND sistema = 'SISE VIDA')
	BEGIN
		
		--  Se actualiza la fecha de cierre al día siguiente, donde el estado sea abierto (1)
			UPDATE PeriodoCierre
			SET fechaCierre = DATEADD(DAY, 1, fechaCierre)
			WHERE compania_id = 2
			AND estado = 1
	
	END

END*/