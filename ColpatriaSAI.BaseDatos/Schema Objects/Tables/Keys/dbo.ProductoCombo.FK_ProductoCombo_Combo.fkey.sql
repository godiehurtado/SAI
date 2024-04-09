ALTER TABLE [dbo].[ProductoCombo]
    ADD CONSTRAINT [FK_ProductoCombo_Combo] FOREIGN KEY ([combo_id]) REFERENCES [dbo].[Combo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

