ALTER TABLE [dbo].[MetaxNodo]
    ADD CONSTRAINT [FK_MetaxNodo_Meta] FOREIGN KEY ([meta_id]) REFERENCES [dbo].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

