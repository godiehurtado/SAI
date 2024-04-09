ALTER TABLE [dbo].[PesoxCompania]
    ADD CONSTRAINT [FK_Pesosxcompania_participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

