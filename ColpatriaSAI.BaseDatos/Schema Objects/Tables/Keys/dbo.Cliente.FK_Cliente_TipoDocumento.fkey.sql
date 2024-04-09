ALTER TABLE [dbo].[Cliente]
    ADD CONSTRAINT [FK_Cliente_TipoDocumento] FOREIGN KEY ([tipoDocumento_id]) REFERENCES [dbo].[TipoDocumento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

