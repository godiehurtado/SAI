ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_Localidad] FOREIGN KEY ([Localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

