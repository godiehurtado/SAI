ALTER TABLE [dbo].[CondicionAgrupada]
    ADD CONSTRAINT [FK_condicionagrupada_operador] FOREIGN KEY ([operador_id]) REFERENCES [dbo].[Operador] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

