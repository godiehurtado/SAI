ALTER TABLE [dbo].[LiquiContratPpacionPpante]
    ADD CONSTRAINT [FK_LiquiContratPpacionPpante_LiquidacionContratacion] FOREIGN KEY ([liqui_contrat_id]) REFERENCES [dbo].[LiquidacionContratacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

