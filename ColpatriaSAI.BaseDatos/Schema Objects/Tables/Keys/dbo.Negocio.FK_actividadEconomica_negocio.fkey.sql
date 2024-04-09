ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_actividadEconomica_negocio] FOREIGN KEY ([actividadEconomica_id]) REFERENCES [dbo].[ActividadEconomica] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

