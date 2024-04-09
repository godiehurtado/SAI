ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_participante_localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

