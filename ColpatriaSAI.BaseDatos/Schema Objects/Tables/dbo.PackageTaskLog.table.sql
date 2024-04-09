CREATE TABLE [dbo].[PackageTaskLog] (
    [PackageTaskLogID] INT              IDENTITY (1, 1) NOT NULL,
    [PackageLogID]     INT              NOT NULL,
    [SourceName]       VARCHAR (255)    NOT NULL,
    [SourceID]         UNIQUEIDENTIFIER NOT NULL,
    [StartDateTime]    DATETIME         NOT NULL,
    [EndDateTime]      DATETIME         NULL
);

