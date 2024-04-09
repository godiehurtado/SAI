CREATE TABLE [dbo].[Package] (
    [PackageID]       INT              IDENTITY (1, 1) NOT NULL,
    [PackageGUID]     UNIQUEIDENTIFIER NOT NULL,
    [PackageName]     VARCHAR (255)    NOT NULL,
    [CreationDate]    DATETIME         NOT NULL,
    [CreatedBy]       VARCHAR (255)    NOT NULL,
    [EnteredDateTime] DATETIME         DEFAULT (getdate()) NOT NULL
);

