ALTER TABLE [dbo].[Moneda]
    ADD CONSTRAINT [FK_Segmento_Moneda] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

