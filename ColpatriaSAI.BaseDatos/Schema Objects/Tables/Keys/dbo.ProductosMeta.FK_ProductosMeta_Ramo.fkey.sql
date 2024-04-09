ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

