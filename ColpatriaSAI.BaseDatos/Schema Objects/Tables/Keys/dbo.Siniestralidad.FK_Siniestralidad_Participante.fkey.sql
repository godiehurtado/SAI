ALTER TABLE [dbo].[Siniestralidad]
    ADD CONSTRAINT [FK_Siniestralidad_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

