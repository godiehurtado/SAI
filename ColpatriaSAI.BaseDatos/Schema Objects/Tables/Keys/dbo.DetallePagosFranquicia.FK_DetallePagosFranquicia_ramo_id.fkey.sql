ALTER TABLE [dbo].[DetallePagosFranquicia]
    ADD CONSTRAINT [FK_DetallePagosFranquicia_ramo_id] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

