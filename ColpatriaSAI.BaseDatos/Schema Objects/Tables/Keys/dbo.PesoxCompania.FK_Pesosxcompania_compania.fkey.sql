ALTER TABLE [dbo].[PesoxCompania]
    ADD CONSTRAINT [FK_Pesosxcompania_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

