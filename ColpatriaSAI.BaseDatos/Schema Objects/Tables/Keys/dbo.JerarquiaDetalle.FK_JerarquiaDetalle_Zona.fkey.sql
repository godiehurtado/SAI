ALTER TABLE [dbo].[JerarquiaDetalle]
    ADD CONSTRAINT [FK_JerarquiaDetalle_Zona] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

