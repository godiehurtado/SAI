ALTER TABLE [dbo].[PeriodoAnterior]
    ADD CONSTRAINT [FK_periodoAnterior_condicion] FOREIGN KEY ([condicion_id]) REFERENCES [dbo].[Condicion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

