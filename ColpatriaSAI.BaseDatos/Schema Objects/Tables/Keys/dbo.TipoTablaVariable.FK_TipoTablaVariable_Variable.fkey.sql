ALTER TABLE [dbo].[TipoTablaVariable]
    ADD CONSTRAINT [FK_TipoTablaVariable_Variable] FOREIGN KEY ([variable_id]) REFERENCES [dbo].[Variable] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

