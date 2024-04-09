ALTER TABLE [dbo].[Localidad]
    ADD CONSTRAINT [FK_Localidad_TipoLocalidad] FOREIGN KEY ([tipo_localidad_id]) REFERENCES [dbo].[TipoLocalidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

