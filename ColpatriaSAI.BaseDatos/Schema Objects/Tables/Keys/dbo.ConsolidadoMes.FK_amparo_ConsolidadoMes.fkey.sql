ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_amparo_ConsolidadoMes] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

