ALTER TABLE [dbo].[ProductoCombo]
    ADD CONSTRAINT [FK_ProductoCombo_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

