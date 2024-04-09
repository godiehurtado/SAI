ALTER TABLE [dbo].[DetalleLiquidacionRegla]
    ADD CONSTRAINT [FK_DetalleLiquidacionRegla_SubRegla] FOREIGN KEY ([subregla_id]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

