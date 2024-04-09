ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_Amparo] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

