ALTER TABLE [dbo].[PackageLog]
    ADD CONSTRAINT [FK_PackageLog_BatchLog] FOREIGN KEY ([BatchLogID]) REFERENCES [dbo].[BatchLog] ([BatchLogID]) ON DELETE NO ACTION ON UPDATE NO ACTION;



















