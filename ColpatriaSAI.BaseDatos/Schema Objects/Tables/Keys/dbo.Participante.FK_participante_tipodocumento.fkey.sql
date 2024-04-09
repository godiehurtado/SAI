ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_tipodocumento] FOREIGN KEY ([tipoDocumento_id]) REFERENCES [dbo].[TipoDocumento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

