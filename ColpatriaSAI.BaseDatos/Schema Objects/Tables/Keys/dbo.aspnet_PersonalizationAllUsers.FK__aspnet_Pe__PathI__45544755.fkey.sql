ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]
    ADD CONSTRAINT [FK__aspnet_Pe__PathI__45544755] FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

