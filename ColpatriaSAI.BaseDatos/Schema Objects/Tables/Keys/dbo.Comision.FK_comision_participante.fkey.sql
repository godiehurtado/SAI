ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_comision_participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

