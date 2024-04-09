ALTER TABLE [dbo].[Pago]
    ADD CONSTRAINT [FK_Pago_DetallePagosRegla] FOREIGN KEY ([detallePagosRegla_id]) REFERENCES [dbo].[DetallePagosRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

