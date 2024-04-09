ALTER TABLE [dbo].[aspnet_Paths]
    ADD CONSTRAINT [DF__aspnet_Pa__PathI__361203C5] DEFAULT (newid()) FOR [PathId];

