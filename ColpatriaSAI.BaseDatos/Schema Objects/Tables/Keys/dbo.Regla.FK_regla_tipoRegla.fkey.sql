ALTER TABLE [dbo].[Regla]
    ADD CONSTRAINT [FK_regla_tipoRegla] FOREIGN KEY ([tipoRegla_id]) REFERENCES [dbo].[TipoRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

