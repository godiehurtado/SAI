ALTER TABLE [dbo].[Jerarquia]
    ADD CONSTRAINT [FK_Jerarquia_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

