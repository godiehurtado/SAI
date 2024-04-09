ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

