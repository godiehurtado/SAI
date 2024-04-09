ALTER TABLE [dbo].[DetalleLiquiContratPpacionPpante]
    ADD CONSTRAINT [FK_DetalleLiquiContratPpacionPpante_LiquidacionContratacion] FOREIGN KEY ([liqui_contrat_id]) REFERENCES [dbo].[LiquidacionContratacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

