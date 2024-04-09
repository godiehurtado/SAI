ALTER TABLE [dbo].[PackageVersion]
    ADD CONSTRAINT [FK_PackageVersion_Package] FOREIGN KEY ([PackageID]) REFERENCES [dbo].[Package] ([PackageID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

