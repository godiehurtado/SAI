
CREATE PROCEDURE [dbo].[LogPackageEnd]
(    @PackageLogID int
    ,@BatchLogID int
    ,@EndBatchAudit bit
)

AS
BEGIN
    SET NOCOUNT ON
    UPDATE dbo.PackageLog
        SET Status = 'S'
        , EndDatetime = getdate()
        WHERE PackageLogID = @PackageLogID

    IF @EndBatchAudit = 1
    Begin
        UPDATE dbo.BatchLog
        SET Status = 'S'
        , EndDatetime = getdate()
        WHERE BatchLogID = @BatchLogID
    End
END