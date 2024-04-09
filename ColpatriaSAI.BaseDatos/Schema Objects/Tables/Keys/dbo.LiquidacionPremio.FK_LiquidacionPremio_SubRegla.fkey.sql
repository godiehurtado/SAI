ALTER TABLE [dbo].[LiquidacionPremio]
    ADD CONSTRAINT [FK_LiquidacionPremio_SubRegla] FOREIGN KEY ([subregla_id]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

