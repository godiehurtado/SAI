ALTER TABLE [dbo].[PersistenciadeCAPIPeriodo]
    ADD CONSTRAINT [FK_PersistenciadeCAPIPeriodo_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

