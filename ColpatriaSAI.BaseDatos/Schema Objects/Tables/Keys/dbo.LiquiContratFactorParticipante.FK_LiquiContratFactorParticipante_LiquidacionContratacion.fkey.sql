ALTER TABLE [dbo].[LiquiContratFactorParticipante]
    ADD CONSTRAINT [FK_LiquiContratFactorParticipante_LiquidacionContratacion] FOREIGN KEY ([liqui_contrat_id]) REFERENCES [dbo].[LiquidacionContratacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

