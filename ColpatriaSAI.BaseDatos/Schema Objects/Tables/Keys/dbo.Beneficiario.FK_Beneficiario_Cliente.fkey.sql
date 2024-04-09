ALTER TABLE [dbo].[Beneficiario]
    ADD CONSTRAINT [FK_Beneficiario_Cliente] FOREIGN KEY ([cliente_id]) REFERENCES [dbo].[Cliente] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

