
CREATE PROCEDURE [dbo].[LogPackageStart]
(    @BatchLogID int
    ,@PackageName varchar(255) 
    ,@ExecutionInstanceID uniqueidentifier 
    ,@MachineName varchar(64) 
    ,@UserName varchar(64) 
    ,@StartDatetime datetime 
    ,@PackageVersionGUID uniqueidentifier 
    ,@VersionMajor int 
    ,@VersionMinor int 
    ,@VersionBuild int 
    ,@VersionComment varchar(1000) 
    ,@PackageGUID uniqueidentifier 
    ,@CreationDate datetime 
    ,@CreatedBy varchar(255) 
)

AS
BEGIN
SET NOCOUNT ON

DECLARE @PackageID int
,@PackageVersionID int 
,@PackageLogID int
,@EndBatchAudit bit

/* Initialize Variables */
SELECT @EndBatchAudit = 0

/* Get Package Metadata ID */
IF NOT EXISTS (SELECT 1 FROM dbo.Package WHERE PackageGUID = @PackageGUID AND PackageName = @PackageName)
Begin
    INSERT INTO dbo.Package (PackageGUID, PackageName, CreationDate, CreatedBy)
        VALUES (@PackageGUID, @PackageName, @CreationDate, @CreatedBy)
End

SELECT @PackageID = PackageID
    FROM dbo.Package 
    WHERE PackageGUID = @PackageGUID
    AND PackageName = @PackageName

/* Get Package Version MetaData ID */
IF NOT EXISTS (SELECT 1 FROM dbo.PackageVersion WHERE PackageVersionGUID = @PackageVersionGUID)
Begin
    INSERT INTO dbo.PackageVersion (PackageID, PackageVersionGUID, VersionMajor, VersionMinor, VersionBuild, VersionComment)
        VALUES (@PackageID, @PackageVersionGUID, @VersionMajor, @VersionMinor, @VersionBuild, @VersionComment)
End
SELECT @PackageVersionID = PackageVersionID
    FROM dbo.PackageVersion 
    WHERE PackageVersionGUID = @PackageVersionGUID

/* Get BatchLogID */
IF ISNULL(@BatchLogID,0) = 0
Begin
    INSERT INTO dbo.BatchLog (StartDatetime, [Status])
        VALUES (@StartDatetime, 'R')
    SELECT @BatchLogID = SCOPE_IDENTITY()
    SELECT @EndBatchAudit = 1
End

/* Create PackageLog Record */
INSERT INTO dbo.PackageLog (BatchLogID, PackageVersionID, ExecutionInstanceID, MachineName, UserName, StartDatetime, [Status])
    VALUES(@BatchLogID, @PackageVersionID, @ExecutionInstanceID, @MachineName, @UserName, @StartDatetime, 'R')

SELECT @PackageLogID = SCOPE_IDENTITY()

SELECT @BatchLogID as BatchLogID, @PackageLogID as PackageLogID, @EndBatchAudit as EndBatchAudit

END