ALTER TABLE [dbo].[Condicion]
    ADD CONSTRAINT [FK_condicion_operador] FOREIGN KEY ([operador_id]) REFERENCES [dbo].[Operador] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

