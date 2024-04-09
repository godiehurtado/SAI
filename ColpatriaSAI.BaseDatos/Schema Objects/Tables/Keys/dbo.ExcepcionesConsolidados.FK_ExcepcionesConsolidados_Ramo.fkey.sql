ALTER TABLE [dbo].[ExcepcionesConsolidados]
    ADD CONSTRAINT [FK_ExcepcionesConsolidados_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

