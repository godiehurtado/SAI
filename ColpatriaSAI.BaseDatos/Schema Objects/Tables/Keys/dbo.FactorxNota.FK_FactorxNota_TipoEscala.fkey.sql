ALTER TABLE [dbo].[FactorxNota]
    ADD CONSTRAINT [FK_FactorxNota_TipoEscala] FOREIGN KEY ([tipoescala_id]) REFERENCES [dbo].[TipoEscala] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

