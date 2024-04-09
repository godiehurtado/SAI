ALTER TABLE [dbo].[ProcesoLiquidacion]
    ADD CONSTRAINT [FK_ProcesoLiquidacion_EstadoProceso] FOREIGN KEY ([estadoProceso_id]) REFERENCES [dbo].[EstadoProceso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

