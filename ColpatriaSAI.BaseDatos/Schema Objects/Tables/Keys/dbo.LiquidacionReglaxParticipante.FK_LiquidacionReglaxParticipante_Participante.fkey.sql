ALTER TABLE [dbo].[LiquidacionReglaxParticipante]
    ADD CONSTRAINT [FK_LiquidacionReglaxParticipante_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

