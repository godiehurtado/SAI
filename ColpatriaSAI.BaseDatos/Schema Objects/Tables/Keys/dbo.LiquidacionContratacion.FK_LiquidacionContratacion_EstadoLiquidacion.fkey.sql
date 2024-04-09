ALTER TABLE [dbo].[LiquidacionContratacion]
    ADD CONSTRAINT [FK_LiquidacionContratacion_EstadoLiquidacion] FOREIGN KEY ([estado]) REFERENCES [dbo].[EstadoLiquidacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

