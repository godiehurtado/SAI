ALTER TABLE [dbo].[LiquiContratFactorParticipante]
    ADD CONSTRAINT [FK_LiquiContratFactorParticipante_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

