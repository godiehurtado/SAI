ALTER TABLE [dbo].[aspnet_Profile]
    ADD CONSTRAINT [FK__aspnet_Pr__UserI__4830B400] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

