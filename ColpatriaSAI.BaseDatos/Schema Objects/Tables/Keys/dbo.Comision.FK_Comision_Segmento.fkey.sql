ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_Comision_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

