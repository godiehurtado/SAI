ALTER TABLE [dbo].[PremiosxComboCRM]
    ADD CONSTRAINT [FK_PremiosxComboCRM_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

