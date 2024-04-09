ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

