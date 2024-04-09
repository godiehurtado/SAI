
CREATE PROCEDURE [dbo].[LogPackageError]
(    @PackageLogID int
    ,@BatchLogID int
    ,@SourceName varchar(256)
    ,@SourceID uniqueidentifier
    ,@ErrorCode int
    ,@ErrorDescription varchar(2000)
    ,@EndBatchAudit bit
)

AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO dbo.PackageErrorLog (PackageLogID, SourceName, SourceID, ErrorCode, ErrorDescription, LogDateTime)
    VALUES (@PackageLogID, @SourceName, @SourceID, @ErrorCode, @ErrorDescription, getdate())

    UPDATE dbo.PackageLog
        SET Status = 'F'
            , EndDatetime = getdate()
        WHERE PackageLogID = @PackageLogID

    IF @EndBatchAudit = 1
    Begin
    UPDATE dbo.BatchLog
        SET Status = 'F'
        , EndDatetime = getdate()
        WHERE BatchLogID = @BatchLogID
    End
END