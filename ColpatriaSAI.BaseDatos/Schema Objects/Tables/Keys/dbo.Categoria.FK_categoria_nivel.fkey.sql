ALTER TABLE [dbo].[Categoria]
    ADD CONSTRAINT [FK_categoria_nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

