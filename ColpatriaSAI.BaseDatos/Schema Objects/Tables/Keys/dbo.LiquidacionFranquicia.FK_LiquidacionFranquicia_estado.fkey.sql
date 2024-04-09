ALTER TABLE [dbo].[LiquidacionFranquicia]
    ADD CONSTRAINT [FK_LiquidacionFranquicia_estado] FOREIGN KEY ([estado]) REFERENCES [dbo].[EstadoLiquidacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

