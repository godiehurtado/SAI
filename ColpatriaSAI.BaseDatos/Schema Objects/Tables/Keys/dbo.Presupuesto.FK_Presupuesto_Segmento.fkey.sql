ALTER TABLE [dbo].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

