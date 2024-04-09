ALTER TABLE [dbo].[Regla]
    ADD CONSTRAINT [FK_regla_periodoRegla] FOREIGN KEY ([periodoRegla_id]) REFERENCES [dbo].[PeriodoRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

