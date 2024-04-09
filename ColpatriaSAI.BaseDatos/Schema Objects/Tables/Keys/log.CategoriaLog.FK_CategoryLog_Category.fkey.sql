ALTER TABLE [log].[CategoriaLog]
    ADD CONSTRAINT [FK_CategoryLog_Category] FOREIGN KEY ([CategoryID]) REFERENCES [log].[Categoria] ([CategoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

