ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
    ADD CONSTRAINT [DF__aspnet_Perso__Id__3BCADD1B] DEFAULT (newid()) FOR [Id];

