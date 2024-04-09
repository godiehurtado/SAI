ALTER TABLE [dbo].[ExcepcionesConsolidados]
    ADD CONSTRAINT [FK_ExcepcionesConsolidados_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

