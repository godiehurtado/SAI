ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_Cliente] FOREIGN KEY ([cliente_id]) REFERENCES [dbo].[Cliente] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

