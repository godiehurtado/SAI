ALTER TABLE [dbo].[FactorxNotaDetalle]
    ADD CONSTRAINT [FK_FactorxNotaDetalle_PeriodoFactorxNota] FOREIGN KEY ([periodofactorxnota_id]) REFERENCES [dbo].[PeriodoFactorxNota] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

