ALTER TABLE [dbo].[PeriodoFactorxNota]
    ADD CONSTRAINT [FK_PeriodoFactorxNota_FactorxNota] FOREIGN KEY ([factorxnota_id]) REFERENCES [dbo].[FactorxNota] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

