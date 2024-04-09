ALTER TABLE [dbo].[TopexEdad]
    ADD CONSTRAINT [FK_TopexEdad_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

