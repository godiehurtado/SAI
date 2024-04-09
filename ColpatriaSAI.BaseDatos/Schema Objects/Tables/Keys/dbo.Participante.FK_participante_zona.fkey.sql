ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_zona] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

