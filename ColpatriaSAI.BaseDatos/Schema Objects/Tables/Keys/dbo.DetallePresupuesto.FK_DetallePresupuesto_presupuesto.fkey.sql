ALTER TABLE [dbo].[DetallePresupuesto]
    ADD CONSTRAINT [FK_DetallePresupuesto_presupuesto] FOREIGN KEY ([presupuesto_id]) REFERENCES [dbo].[Presupuesto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

