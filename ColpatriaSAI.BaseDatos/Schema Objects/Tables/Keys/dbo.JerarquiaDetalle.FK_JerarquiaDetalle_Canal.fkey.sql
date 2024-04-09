ALTER TABLE [dbo].[JerarquiaDetalle]
    ADD CONSTRAINT [FK_JerarquiaDetalle_Canal] FOREIGN KEY ([canal_id]) REFERENCES [dbo].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

