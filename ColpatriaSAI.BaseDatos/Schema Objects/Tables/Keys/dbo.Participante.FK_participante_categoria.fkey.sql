ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_categoria] FOREIGN KEY ([categoria_id]) REFERENCES [dbo].[Categoria] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

