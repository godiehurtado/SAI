ALTER TABLE [dbo].[CategoriaxRegla]
    ADD CONSTRAINT [FK_CategoriaxRegla_Categoria] FOREIGN KEY ([categoria_id]) REFERENCES [dbo].[Categoria] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

