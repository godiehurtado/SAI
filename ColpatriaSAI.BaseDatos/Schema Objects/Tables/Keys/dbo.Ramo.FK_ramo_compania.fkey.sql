ALTER TABLE [dbo].[Ramo]
    ADD CONSTRAINT [FK_ramo_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

