ALTER TABLE [dbo].[DetallePartFranquicia]
    ADD CONSTRAINT [FK_DetallePartFranquicia_ramo_id] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

