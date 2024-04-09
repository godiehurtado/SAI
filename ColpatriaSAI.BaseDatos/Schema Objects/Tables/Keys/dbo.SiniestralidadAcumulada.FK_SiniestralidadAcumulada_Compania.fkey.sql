ALTER TABLE [dbo].[SiniestralidadAcumulada]
    ADD CONSTRAINT [FK_SiniestralidadAcumulada_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

