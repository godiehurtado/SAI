ALTER TABLE [dbo].[DetallePagosFranquicia]
    ADD CONSTRAINT [FK_DetallePagosFranquicia_compania_id] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

