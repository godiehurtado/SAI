ALTER TABLE [dbo].[JerarquiaDetalle]
    ADD CONSTRAINT [FK_JerarquiaDetalle_Nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

