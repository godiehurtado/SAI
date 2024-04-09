ALTER TABLE [dbo].[aspnet_Applications]
    ADD CONSTRAINT [DF__aspnet_Ap__Appli__351DDF8C] DEFAULT (newid()) FOR [ApplicationId];

