ALTER TABLE [dbo].[aspnet_Users]
    ADD CONSTRAINT [DF__aspnet_Us__UserI__37FA4C37] DEFAULT (newid()) FOR [UserId];

