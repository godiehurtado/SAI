ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_actividadEconomica_monedaxnegocio] FOREIGN KEY ([actividadeconomica_id]) REFERENCES [dbo].[ActividadEconomica] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

