
CREATE PROCEDURE [dbo].[LogTaskPostExecute]
(    @PackageLogID int
    ,@SourceID uniqueidentifier
    ,@PackageID uniqueidentifier
)

AS
BEGIN
    SET NOCOUNT ON
    IF @PackageID <> @SourceID
        UPDATE dbo.PackageTaskLog 
            SET EndDateTime = getdate()
            WHERE PackageLogID = @PackageLogID AND SourceID = @SourceID
                AND EndDateTime is null
END