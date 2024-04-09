ALTER TABLE [dbo].[JerarquiaDetalle]
    ADD CONSTRAINT [FK_JerarquiaDetalle_Jerarquia] FOREIGN KEY ([jerarquia_id]) REFERENCES [dbo].[Jerarquia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

