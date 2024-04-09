-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 29/03/2012
-- Description:	Consolida los registros ingresados en la tabla AnticipoFranquicia, en la tabla Pago
-- =============================================
CREATE TRIGGER [dbo].[ConsolidadoAnticipoFranquicia_TRG] ON [dbo].[AnticipoFranquicia]
   AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

    IF UPDATE(estado) AND EXISTS(SELECT 1 FROM inserted i WHERE i.estado = 2 )--Se efectuó un cambio a estado = 2 pagado
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
			NULL			AS detallePagosFranquicia_id
			,NULL			AS detallePagosRegla_id
			,i.Id			AS anticipoFranquicia_id
			,i.compania_id	AS compania_id
			,l.clavePago	AS clave
			,0				AS tipoDocumento_id
			,''				AS documento
			,i.valorAnti	AS totalParticipacion
			,af.descripcion	AS descripcion
			,GETDATE()		AS fechaPago
			,1				AS estado
		FROM inserted i INNER JOIN Localidad l ON l.id = i.localidad_id, AnticipoFranquicia af
		WHERE af.Id = i.Id
	END
END