CREATE TABLE [dbo].[PackageErrorLog] (
    [PackageErrorLogID] INT              IDENTITY (1, 1) NOT NULL,
    [PackageLogID]      INT              NOT NULL,
    [SourceName]        VARCHAR (256)    NOT NULL,
    [SourceID]          UNIQUEIDENTIFIER NOT NULL,
    [ErrorCode]         INT              NULL,
    [ErrorDescription]  VARCHAR (2000)   NULL,
    [LogDateTime]       DATETIME         NOT NULL
);



