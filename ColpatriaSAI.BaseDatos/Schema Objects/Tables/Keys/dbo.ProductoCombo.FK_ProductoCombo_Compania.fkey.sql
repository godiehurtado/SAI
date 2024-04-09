ALTER TABLE [dbo].[ProductoCombo]
    ADD CONSTRAINT [FK_ProductoCombo_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

