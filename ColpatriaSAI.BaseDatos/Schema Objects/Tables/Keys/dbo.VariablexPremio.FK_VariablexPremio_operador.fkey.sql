ALTER TABLE [dbo].[VariablexPremio]
    ADD CONSTRAINT [FK_VariablexPremio_operador] FOREIGN KEY ([operador_id]) REFERENCES [dbo].[Operador] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

