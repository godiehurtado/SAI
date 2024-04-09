ALTER TABLE [dbo].[Localidad]
    ADD CONSTRAINT [FK_Localidad_Zona] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

