ALTER TABLE [dbo].[Participaciones]
    ADD CONSTRAINT [FK_Participaciones_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

