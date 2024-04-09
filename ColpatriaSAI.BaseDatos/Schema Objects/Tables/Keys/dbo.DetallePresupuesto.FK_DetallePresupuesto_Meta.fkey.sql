ALTER TABLE [dbo].[DetallePresupuesto]
    ADD CONSTRAINT [FK_DetallePresupuesto_Meta] FOREIGN KEY ([meta_id]) REFERENCES [dbo].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

