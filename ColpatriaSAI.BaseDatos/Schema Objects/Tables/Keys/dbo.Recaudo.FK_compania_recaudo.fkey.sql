ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_compania_recaudo] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

