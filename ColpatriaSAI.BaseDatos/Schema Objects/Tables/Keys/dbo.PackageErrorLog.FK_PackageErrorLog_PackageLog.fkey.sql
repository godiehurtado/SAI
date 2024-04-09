ALTER TABLE [dbo].[PackageErrorLog]
    ADD CONSTRAINT [FK_PackageErrorLog_PackageLog] FOREIGN KEY ([PackageLogID]) REFERENCES [dbo].[PackageLog] ([PackageLogID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

