ALTER TABLE [dbo].[EjecucionDetalle]
    ADD CONSTRAINT [FK_EjecucionDetalle_Ejecucion] FOREIGN KEY ([ejecucion_id]) REFERENCES [dbo].[Ejecucion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

