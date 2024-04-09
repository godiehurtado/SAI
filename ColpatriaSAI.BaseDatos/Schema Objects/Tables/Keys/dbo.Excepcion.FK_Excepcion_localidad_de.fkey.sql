ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_Localidad_de] FOREIGN KEY ([localidad_de_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

