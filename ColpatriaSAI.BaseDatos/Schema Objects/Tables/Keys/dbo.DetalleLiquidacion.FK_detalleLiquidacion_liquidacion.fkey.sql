ALTER TABLE [dbo].[DetalleLiquidacion]
    ADD CONSTRAINT [FK_detalleLiquidacion_liquidacion] FOREIGN KEY ([liquidacion_id]) REFERENCES [dbo].[LiquidacionRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

