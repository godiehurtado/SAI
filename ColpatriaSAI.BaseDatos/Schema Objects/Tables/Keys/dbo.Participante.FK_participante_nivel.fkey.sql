ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

