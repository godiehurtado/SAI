ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_plazo_ConsolidadoMes] FOREIGN KEY ([plazo_id]) REFERENCES [dbo].[Plazo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

