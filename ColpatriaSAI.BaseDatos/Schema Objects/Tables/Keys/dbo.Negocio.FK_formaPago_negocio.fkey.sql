ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_formaPago_negocio] FOREIGN KEY ([formaPago_id]) REFERENCES [dbo].[FormaPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

