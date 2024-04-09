ALTER TABLE [dbo].[PackageLog]
    ADD CONSTRAINT [FK_PackageLog_PackageVersion] FOREIGN KEY ([PackageVersionID]) REFERENCES [dbo].[PackageVersion] ([PackageVersionID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

