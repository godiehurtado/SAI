ALTER TABLE [dbo].[PersistenciaEsperada]
    ADD CONSTRAINT [FK_Plazo_PersistenciaEsperada] FOREIGN KEY ([plazo_id]) REFERENCES [dbo].[Plazo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

