ALTER TABLE [dbo].[DetalleLiquidacionFranquicia]
    ADD CONSTRAINT [FK_DetalleLiquidacionFranquicia_LiquidacionFranquicia] FOREIGN KEY ([liquidacionFranquicia_id]) REFERENCES [dbo].[LiquidacionFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

