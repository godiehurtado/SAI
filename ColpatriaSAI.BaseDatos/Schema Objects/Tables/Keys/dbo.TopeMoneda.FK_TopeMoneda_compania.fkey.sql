ALTER TABLE [dbo].[TopeMoneda]
    ADD CONSTRAINT [FK_TopeMoneda_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

