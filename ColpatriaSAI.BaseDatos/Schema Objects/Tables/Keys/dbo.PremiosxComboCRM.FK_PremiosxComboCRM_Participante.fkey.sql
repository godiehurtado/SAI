ALTER TABLE [dbo].[PremiosxComboCRM]
    ADD CONSTRAINT [FK_PremiosxComboCRM_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

