ALTER TABLE [dbo].[Siniestralidad]
    ADD CONSTRAINT [FK_Siniestralidad_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

