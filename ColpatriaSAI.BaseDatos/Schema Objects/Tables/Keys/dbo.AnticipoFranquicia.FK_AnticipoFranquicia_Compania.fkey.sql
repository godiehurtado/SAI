ALTER TABLE [dbo].[AnticipoFranquicia]
    ADD CONSTRAINT [FK_AnticipoFranquicia_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

