ALTER TABLE [dbo].[PersistenciadeVIDA]
    ADD CONSTRAINT [FK_PersistenciadeVIDA_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

