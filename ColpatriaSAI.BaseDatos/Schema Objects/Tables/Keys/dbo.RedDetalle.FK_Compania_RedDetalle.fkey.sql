ALTER TABLE [dbo].[RedDetalle]
    ADD CONSTRAINT [FK_Compania_RedDetalle] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

