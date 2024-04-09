ALTER TABLE [dbo].[AnticipoFranquicia]
    ADD CONSTRAINT [FK_AnticipoFranquicia_localidad_id] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

