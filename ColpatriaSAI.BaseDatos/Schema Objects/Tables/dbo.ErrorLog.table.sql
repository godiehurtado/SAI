CREATE TABLE [dbo].[ErrorLog] (
    [UserName]       VARCHAR (100)  NULL,
    [ErrorNumber]    VARCHAR (100)  NULL,
    [ErrorSeverity]  VARCHAR (100)  NULL,
    [ErrorState]     VARCHAR (100)  NULL,
    [ErrorProcedure] VARCHAR (100)  NULL,
    [ErrorLine]      VARCHAR (100)  NULL,
    [Date]           DATETIME       NULL,
    [ErrorMessage]   NVARCHAR (100) NULL
);



