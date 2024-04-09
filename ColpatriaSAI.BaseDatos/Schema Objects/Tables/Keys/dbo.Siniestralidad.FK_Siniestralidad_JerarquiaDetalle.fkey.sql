ALTER TABLE [dbo].[Siniestralidad]
    ADD CONSTRAINT [FK_Siniestralidad_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

