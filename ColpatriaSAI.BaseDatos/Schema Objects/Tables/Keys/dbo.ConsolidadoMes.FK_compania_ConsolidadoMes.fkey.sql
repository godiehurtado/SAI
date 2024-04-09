ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_compania_ConsolidadoMes] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

