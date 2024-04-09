ALTER TABLE [dbo].[SiniestralidadAcumulada]
    ADD CONSTRAINT [FK_SiniestralidadAcumulada_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

