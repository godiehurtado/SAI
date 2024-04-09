
CREATE PROCEDURE [dbo].[LogTaskPreExecute]
(    @PackageLogID int
    ,@SourceName varchar(64)
    ,@SourceID uniqueidentifier
    ,@PackageID uniqueidentifier
)

AS
BEGIN
    SET NOCOUNT ON
    IF @PackageID <> @SourceID
        AND @SourceName <> 'SQL LogPackageStart'
        AND @SourceName <> 'SQL LogPackageEnd'
        INSERT INTO dbo.PackageTaskLog (PackageLogID, SourceName, SourceID, StartDateTime)
        VALUES (@PackageLogID, @SourceName, @SourceID, getdate())
END