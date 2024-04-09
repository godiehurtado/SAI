ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

