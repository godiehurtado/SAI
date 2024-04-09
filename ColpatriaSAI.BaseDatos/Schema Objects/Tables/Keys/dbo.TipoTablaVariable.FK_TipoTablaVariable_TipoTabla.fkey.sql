ALTER TABLE [dbo].[TipoTablaVariable]
    ADD CONSTRAINT [FK_TipoTablaVariable_TipoTabla] FOREIGN KEY ([tipotabla_id]) REFERENCES [dbo].[TipoTabla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

