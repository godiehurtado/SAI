ALTER TABLE [dbo].[DetalleLiquidacionSubRegla]
    ADD CONSTRAINT [FK_DetalleLiquidacionSubRegla_Condicion] FOREIGN KEY ([condicion_id]) REFERENCES [dbo].[Condicion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

