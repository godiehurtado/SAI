ALTER TABLE [dbo].[ConceptoPago]
    ADD CONSTRAINT [FK_ConceptoPago_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

