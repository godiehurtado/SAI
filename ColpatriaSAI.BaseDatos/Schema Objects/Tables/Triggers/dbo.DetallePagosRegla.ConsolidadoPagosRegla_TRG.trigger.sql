-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 16/02/2012
-- Description:	Consolida los registros ingresados en la tabla DetallePagosRegla, en la tabla Pago
-- =============================================
CREATE TRIGGER [dbo].[ConsolidadoPagosRegla_TRG] ON [dbo].[DetallePagosRegla]
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
			NULL					AS detallePagosFranquicia_id
			,i.id					AS detallePagosRegla_id
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
			NULL					AS detallePagosFranquicia_id
			,i.id					AS detallePagosRegla_id
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