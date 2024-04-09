ALTER TABLE [dbo].[LiquiContratMeta]
    ADD CONSTRAINT [FK_LiquiContratMeta_LiquidacionContratacion] FOREIGN KEY ([liqui_contrat_id]) REFERENCES [dbo].[LiquidacionContratacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

