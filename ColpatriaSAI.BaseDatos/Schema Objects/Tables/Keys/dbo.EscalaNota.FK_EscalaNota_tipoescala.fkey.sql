ALTER TABLE [dbo].[EscalaNota]
    ADD CONSTRAINT [FK_EscalaNota_tipoescala] FOREIGN KEY ([tipoEscala_id]) REFERENCES [dbo].[TipoEscala] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

