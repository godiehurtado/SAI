ALTER TABLE [dbo].[PackageTaskLog]
    ADD CONSTRAINT [FK_PackageTaskLog_PackageLog] FOREIGN KEY ([PackageLogID]) REFERENCES [dbo].[PackageLog] ([PackageLogID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

