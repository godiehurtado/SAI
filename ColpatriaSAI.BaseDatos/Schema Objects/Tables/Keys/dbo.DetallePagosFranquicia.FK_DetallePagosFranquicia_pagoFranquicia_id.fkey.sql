ALTER TABLE [dbo].[DetallePagosFranquicia]
    ADD CONSTRAINT [FK_DetallePagosFranquicia_pagoFranquicia_id] FOREIGN KEY ([pagoFranquicia_id]) REFERENCES [dbo].[PagoFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

