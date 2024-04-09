ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

