ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_localidad_ConsolidadoMes] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

