ALTER TABLE [dbo].[ExcepcionesGenerales]
    ADD CONSTRAINT [FK_ExcepcionesGenerales_Moneda] FOREIGN KEY ([moneda_id]) REFERENCES [dbo].[Moneda] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

