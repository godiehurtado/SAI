-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 16/02/2012
-- Description:	Consolida los registros ingresados en la tabla DetallePagosFranquicia, en la tabla Pago
-- =============================================
CREATE TRIGGER [dbo].[ConsolidadoPagosFranquicia_TRG] ON [dbo].[DetallePagosFranquicia]
   AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT 1 FROM deleted) AND UPDATE(valorAjuste)--Se efectuó un ajuste
	BEGIN
		INSERT INTO Pago
			(detallePagosFranquicia_id
			,detallePagosRegla_id
			,anticipoFranquicia_id
			,compania_id
			,clave
			,tipoDocumento_id
			,documento
			,totalParticipacion
			,descripcion
			,fechaPago
			,estado)
		SELECT
			i.id					AS detallePagosFranquicia_id
			,NULL					AS detallePagosRegla_id
			,NULL					AS anticipoFranquicia_id
			,i.compania_id			AS compania_id
			,i.clave				AS clave
			,i.tipoDocumento_id		AS tipoDocumento_id
			,i.documento			AS documento
			,i.valorAjuste			AS totalParticipacion
			,i.descripcion			AS descripcion
			,GETDATE()				AS fechaPago
			,1						AS estado
		FROM inserted i
	END
	ELSE--Insert sobre la tabla
	BEGIN
		INSERT INTO Pago
			(detallePagosFranquicia_id
			,detallePagosRegla_id
			,anticipoFranquicia_id
			,compania_id
			,clave
			,tipoDocumento_id
			,documento
			,totalParticipacion
			,descripcion
			,fechaPago
			,estado)
		SELECT
			i.id					AS detallePagosFranquicia_id
			,NULL					AS detallePagosRegla_id
			,NULL					AS anticipoFranquicia_id
			,i.compania_id			AS compania_id
			,i.clave				AS clave
			,i.tipoDocumento_id		AS tipoDocumento_id
			,i.documento			AS documento
			,i.totalParticipacion	AS totalParticipacion
			,i.descripcion			AS descripcion
			,GETDATE()				AS fechaPago
			,1						AS estado
		FROM inserted i
	END
END