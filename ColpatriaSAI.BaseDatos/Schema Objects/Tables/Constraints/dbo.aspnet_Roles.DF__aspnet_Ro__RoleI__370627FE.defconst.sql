ALTER TABLE [dbo].[aspnet_Roles]
    ADD CONSTRAINT [DF__aspnet_Ro__RoleI__370627FE] DEFAULT (newid()) FOR [RoleId];

