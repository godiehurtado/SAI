ALTER TABLE [dbo].[ModeloxNodo]
    ADD CONSTRAINT [FK_ModeloxNodo_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

