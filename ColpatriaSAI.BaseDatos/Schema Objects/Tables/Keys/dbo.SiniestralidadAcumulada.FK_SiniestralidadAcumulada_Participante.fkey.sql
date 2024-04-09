ALTER TABLE [dbo].[SiniestralidadAcumulada]
    ADD CONSTRAINT [FK_SiniestralidadAcumulada_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

