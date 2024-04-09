ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_compania_id] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

