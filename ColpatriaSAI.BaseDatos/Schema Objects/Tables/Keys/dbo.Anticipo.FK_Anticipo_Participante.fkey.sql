ALTER TABLE [dbo].[Anticipo]
    ADD CONSTRAINT [FK_Anticipo_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

