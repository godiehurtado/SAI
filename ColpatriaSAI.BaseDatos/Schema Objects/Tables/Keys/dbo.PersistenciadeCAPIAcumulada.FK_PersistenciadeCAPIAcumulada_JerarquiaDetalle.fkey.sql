ALTER TABLE [dbo].[PersistenciadeCAPIAcumulada]
    ADD CONSTRAINT [FK_PersistenciadeCAPIAcumulada_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

