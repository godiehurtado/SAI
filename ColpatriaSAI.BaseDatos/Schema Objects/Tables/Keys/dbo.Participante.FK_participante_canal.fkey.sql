ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_canal] FOREIGN KEY ([canal_id]) REFERENCES [dbo].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

