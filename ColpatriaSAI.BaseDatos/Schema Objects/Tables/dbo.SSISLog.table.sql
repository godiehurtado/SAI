CREATE TABLE [dbo].[SSISLog] (
    [EventID]           INT            IDENTITY (1, 1) NOT NULL,
    [EventType]         VARCHAR (20)   NOT NULL,
    [PackageName]       VARCHAR (50)   NOT NULL,
    [TaskName]          VARCHAR (50)   NOT NULL,
    [EventCode]         INT            NULL,
    [EventDescription]  VARCHAR (1000) NULL,
    [PackageDuration]   INT            NULL,
    [ContainerDuration] INT            NULL,
    [InsertCount]       INT            NULL,
    [UpdateCount]       INT            NULL,
    [DeleteCount]       INT            NULL,
    [Host]              VARCHAR (50)   NULL,
    [Date]              DATE           NULL
);

