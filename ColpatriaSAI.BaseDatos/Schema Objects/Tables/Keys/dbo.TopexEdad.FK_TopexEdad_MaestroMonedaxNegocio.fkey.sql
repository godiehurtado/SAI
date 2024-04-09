ALTER TABLE [dbo].[TopexEdad]
    ADD CONSTRAINT [FK_TopexEdad_MaestroMonedaxNegocio] FOREIGN KEY ([maestromoneda_id]) REFERENCES [dbo].[MaestroMonedaxNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

