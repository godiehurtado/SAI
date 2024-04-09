ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_Meta] FOREIGN KEY ([meta_id]) REFERENCES [dbo].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

