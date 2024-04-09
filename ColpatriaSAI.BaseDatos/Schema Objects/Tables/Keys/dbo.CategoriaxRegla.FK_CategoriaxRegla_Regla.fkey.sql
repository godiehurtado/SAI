ALTER TABLE [dbo].[CategoriaxRegla]
    ADD CONSTRAINT [FK_CategoriaxRegla_Regla] FOREIGN KEY ([regla_id]) REFERENCES [dbo].[Regla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

