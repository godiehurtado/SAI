ALTER TABLE [dbo].[DetalleLiquidacionSubRegla]
    ADD CONSTRAINT [FK_DetalleLiquidacionSubRegla_DetalleLiquidacionRegla] FOREIGN KEY ([detalleLiquidacionRegla_id]) REFERENCES [dbo].[DetalleLiquidacionRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

