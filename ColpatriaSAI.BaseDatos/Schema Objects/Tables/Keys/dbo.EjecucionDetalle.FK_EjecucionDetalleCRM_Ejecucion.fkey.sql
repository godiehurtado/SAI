ALTER TABLE [dbo].[EjecucionDetalleCRM]
    ADD CONSTRAINT [FK_EjecucionDetalleCRM_Ejecucion] FOREIGN KEY ([ejecucion_id]) REFERENCES [dbo].[Ejecucion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

