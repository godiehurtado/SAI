ALTER TABLE [dbo].[Modelo]
    ADD CONSTRAINT [FK_Modelo_FactorxNota] FOREIGN KEY ([factorxnota_id]) REFERENCES [dbo].[FactorxNota] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

