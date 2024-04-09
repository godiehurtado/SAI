ALTER TABLE [dbo].[PagoFranquicia]
    ADD CONSTRAINT [FK_PagoFranquicia_LiquidacionFranquicia] FOREIGN KEY ([liquidacionFranquicia_id]) REFERENCES [dbo].[LiquidacionFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

