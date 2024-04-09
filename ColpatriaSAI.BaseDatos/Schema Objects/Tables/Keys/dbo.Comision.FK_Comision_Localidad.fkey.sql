ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_Comision_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

