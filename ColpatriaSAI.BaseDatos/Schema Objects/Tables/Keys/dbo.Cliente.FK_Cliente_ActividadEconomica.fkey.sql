ALTER TABLE [dbo].[Cliente]
    ADD CONSTRAINT [FK_Cliente_ActividadEconomica] FOREIGN KEY ([actividadEconomica_id]) REFERENCES [dbo].[ActividadEconomica] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

