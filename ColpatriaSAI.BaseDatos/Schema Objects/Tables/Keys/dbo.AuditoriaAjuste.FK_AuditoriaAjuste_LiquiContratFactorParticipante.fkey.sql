ALTER TABLE [dbo].[AuditoriaAjuste]
    ADD CONSTRAINT [FK_AuditoriaAjuste_LiquiContratFactorParticipante] FOREIGN KEY ([liquiContratFactorParticipante_id]) REFERENCES [dbo].[LiquiContratFactorParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

