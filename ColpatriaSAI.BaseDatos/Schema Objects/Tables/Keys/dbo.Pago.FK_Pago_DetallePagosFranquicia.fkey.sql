ALTER TABLE [dbo].[Pago]
    ADD CONSTRAINT [FK_Pago_DetallePagosFranquicia] FOREIGN KEY ([detallePagosFranquicia_id]) REFERENCES [dbo].[DetallePagosFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

