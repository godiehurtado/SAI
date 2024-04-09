ALTER TABLE [dbo].[IngresoLocalidad]
    ADD CONSTRAINT [FK_IngresoLocalidad_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

