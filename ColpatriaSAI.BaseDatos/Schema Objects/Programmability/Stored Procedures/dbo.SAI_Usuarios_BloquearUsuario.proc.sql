CREATE PROCEDURE [dbo].[SAI_Usuarios_BloquearUsuario]
    @UserName                                nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationName nvarchar(256)
    SET     @ApplicationName = '/'    
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
        RETURN 1
        PRINT 'No es posible el bloqueo ya que el usuario no existe' + ' - ' + 'Codigo: 0001'

    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = 1,
        FailedPasswordAttemptCount = 0,
        FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        FailedPasswordAnswerAttemptCount = 0,
        FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        LastLockoutDate = CONVERT( datetime, '17540101', 112 )
    WHERE @UserId = UserId
     PRINT 'Bloqueo exitoso' + ' - ' +  'Codigo: 0004'

    RETURN 0
END
