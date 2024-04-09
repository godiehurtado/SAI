ALTER TABLE [dbo].[Premio]
    ADD CONSTRAINT [FK_premio_operador] FOREIGN KEY ([operador_id]) REFERENCES [dbo].[Operador] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

