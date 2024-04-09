ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_zona_ConsolidadoMes] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

