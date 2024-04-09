ALTER TABLE [dbo].[LiquidacionMoneda]
    ADD CONSTRAINT [FK_LiquidacionMoneda_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

