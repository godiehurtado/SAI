CREATE TABLE [dbo].[PackageVersion] (
    [PackageVersionID]   INT              IDENTITY (1, 1) NOT NULL,
    [PackageVersionGUID] UNIQUEIDENTIFIER NOT NULL,
    [PackageID]          INT              NOT NULL,
    [VersionMajor]       INT              NOT NULL,
    [VersionMinor]       INT              NOT NULL,
    [VersionBuild]       INT              NOT NULL,
    [VersionComment]     VARCHAR (1000)   NOT NULL,
    [EnteredDateTime]    DATETIME         DEFAULT (getdate()) NOT NULL
);

