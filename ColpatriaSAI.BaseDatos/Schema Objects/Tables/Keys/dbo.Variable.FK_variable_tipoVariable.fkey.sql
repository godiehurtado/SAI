ALTER TABLE [dbo].[Variable]
    ADD CONSTRAINT [FK_variable_tipoVariable] FOREIGN KEY ([tipoVariable_id]) REFERENCES [dbo].[TipoVariable] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

