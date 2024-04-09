ALTER TABLE [dbo].[PremiosxComboCRM]
    ADD CONSTRAINT [FK_PremiosxComboCRM_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

