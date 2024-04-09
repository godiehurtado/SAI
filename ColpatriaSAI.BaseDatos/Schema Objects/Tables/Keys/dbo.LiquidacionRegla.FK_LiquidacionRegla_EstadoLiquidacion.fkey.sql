ALTER TABLE [dbo].[LiquidacionRegla]
    ADD CONSTRAINT [FK_LiquidacionRegla_EstadoLiquidacion] FOREIGN KEY ([estado]) REFERENCES [dbo].[EstadoLiquidacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

