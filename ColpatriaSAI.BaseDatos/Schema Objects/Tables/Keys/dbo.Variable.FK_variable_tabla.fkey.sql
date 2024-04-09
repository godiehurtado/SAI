ALTER TABLE [dbo].[Variable]
    ADD CONSTRAINT [FK_variable_tabla] FOREIGN KEY ([tabla_id]) REFERENCES [dbo].[tablas] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

