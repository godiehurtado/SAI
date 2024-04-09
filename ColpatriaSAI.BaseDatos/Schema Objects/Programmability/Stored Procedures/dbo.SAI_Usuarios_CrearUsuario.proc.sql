
CREATE PROCEDURE [dbo].[SAI_Usuarios_CrearUsuario] @UserName NVARCHAR(256)
OUTPUT
	,@TipoIdentificacion NVARCHAR(100)
	,@NumeroIdentificacion NVARCHAR(100)
	,@Email NVARCHAR(256)
OUTPUT
	,@RoleNames NVARCHAR(4000)
OUTPUT
	,@Segmento INT AS

BEGIN
	DECLARE @ApplicationName VARCHAR(100)

	SET @ApplicationName = '/'

	DECLARE @PropertyNames VARCHAR(100)

	SET @PropertyNames = 'TipoIde:S:0:' + cast(LEN(@TipoIdentificacion) AS VARCHAR) + ':NumeroIde:S:' + cast(LEN(@NumeroIdentificacion) AS VARCHAR)

	DECLARE @PropertyValuesString VARCHAR(100)

	SET @PropertyValuesString = cast(@TipoIdentificacion AS VARCHAR) + cast(@NumeroIdentificacion AS VARCHAR)

	DECLARE @PropertyValuesBinary VARCHAR(100)

	SET @PropertyValuesBinary = '<Binary data>'

	DECLARE @IsUserAnonymous BIT

	SET @IsUserAnonymous = 0

	DECLARE @CurrentTimeUtc DATETIME

	SET @CurrentTimeUtc = GETDATE()

	DECLARE @TranStarted BIT

	SET @TranStarted = 0

	DECLARE @ErrorCode INT

	SET @ErrorCode = 0

	BEGIN TRANSACTION

	SELECT @@trancount

	EXEC dbo.aspnet_Profile_SetProperties @ApplicationName
		,@PropertyNames
		,@PropertyValuesString
		,@PropertyValuesBinary
		,@UserName
		,@IsUserAnonymous
		,@CurrentTimeUtc

	COMMIT TRANSACTION

	--  VARIABLES DE LA TABLA MEMBERSHIP
	DECLARE @Delimiter NVARCHAR(5)

	SET @Delimiter = '|'

	DECLARE @IsApproved BIT

	SET @IsApproved = 1

	DECLARE @PasswordFormat INT

	SET @PasswordFormat = 0

	DECLARE @UserId UNIQUEIDENTIFIER

	SET @UserId = NEWID()

	PRINT 'Value of @UserId is: ' + CONVERT(VARCHAR(255), @UserId)

	DECLARE @RoleId UNIQUEIDENTIFIER

	SET @RoleId = NEWID()

	PRINT 'Value of @RoleId is: ' + CONVERT(VARCHAR(255), @RoleId)

	DECLARE @ApplicationId UNIQUEIDENTIFIER

	SET @ApplicationId = NEWID()

	PRINT 'Value of @ApplicationId is: ' + CONVERT(VARCHAR(255), @ApplicationId)

	DECLARE @Password NVARCHAR(128)

	SET @Password = @UserName

	DECLARE @PasswordSalt NVARCHAR(128)

	SET @PasswordSalt = @UserName

	DECLARE @MobilePIN NVARCHAR(16)

	SET @MobilePIN = ''

	DECLARE @LoweredEmail NVARCHAR(256)

	SET @LoweredEmail = LOWER(@Email)

	DECLARE @PasswordQuestion NVARCHAR(256)

	SET @PasswordQuestion = NULL

	DECLARE @PasswordAnswer NVARCHAR(128)

	SET @PasswordAnswer = NULL

	DECLARE @IsLockedOut BIT

	SET @IsLockedOut = 0

	DECLARE @Contador INT

	SET @Contador = 1

	IF (
			EXISTS (
				SELECT aspnet_Users.UserId
				FROM dbo.aspnet_Users
				WHERE Username = @UserName
					AND aspnet_Users.UserId NOT IN (
						SELECT aspnet_Membership.UserId
						FROM aspnet_Membership
						)
				)
			)
	BEGIN
		DECLARE @idUser VARCHAR(2048) = (SELECT aspnet_Users.UserId FROM dbo.aspnet_Users WHERE Username = @UserName)

		INSERT INTO aspnet_Membership (
			ApplicationId
			,UserId
			,Password
			,PasswordFormat
			,PasswordSalt
			,MobilePIN
			,Email
			,LoweredEmail
			,PasswordQuestion
			,PasswordAnswer
			,IsApproved
			,IsLockedOut
			,CreateDate
			,LastLoginDate
			,LastPasswordChangedDate
			,LastLockoutDate
			,FailedPasswordAttemptCount
			,FailedPasswordAttemptWindowStart
			,FailedPasswordanswerAttemptCount
			,FailedPasswordAnswerAttemptWindowStart
			,Comment
			)
		VALUES (
			'015C56E3-BD5D-489D-8699-A6583FA304DF'
			,@idUser
			,LOWER(@UserName)
			,0
			,LOWER(@UserName)
			,NULL
			,@Email
			,LOWER(@Email)
			,NULL
			,NULL
			,1
			,0
			,getdate()
			,getdate()
			,getdate()
			,'1754-01-01 00:00:00.000'
			,1
			,'1754-01-01 00:00:00.000'
			,0
			,'1754-01-01 00:00:00.000'
			,NULL
			)
	END

	-- INSERTAR EN USERINROLES
	DECLARE @pos INT
		,@curruntLocation CHAR(20)
		,@RoleNamesS VARCHAR(2048)
		,@UserNameS VARCHAR(2048)

	SELECT @pos = 0

	SELECT @RoleNamesS = @RoleNames

	SELECT @UserNameS = @UserName

	SELECT @RoleNamesS = @RoleNamesS + '|'

	CREATE TABLE #tempTable (
		id INT IDENTITY(0, 1) NOT NULL
		,TEMP VARCHAR(100) collate Modern_Spanish_CI_AS
		,NAME VARCHAR(100) collate Modern_Spanish_CI_AS
		)

	WHILE CHARINDEX('|', @RoleNamesS) > 0
	BEGIN
		SELECT @pos = CHARINDEX('|', @RoleNamesS)

		SELECT @curruntLocation = RTRIM(SUBSTRING(@RoleNamesS, 1, @pos - 1))

		INSERT INTO #tempTable (
			TEMP
			,NAME
			)
		VALUES (
			@curruntLocation
			,@UserNameS
			)

		SELECT @RoleNamesS = SUBSTRING(@RoleNamesS, @pos + 1, 2048)
	END

	SELECT *
	FROM #tempTable

	-- SI EXISTE EL ROL EN LA TABLA MAESTRA DE ROLES
	IF (
			EXISTS (
				SELECT aspnet_Roles.RoleId
				FROM dbo.aspnet_Roles
				INNER JOIN #tempTable ON aspnet_Roles.RoleName = #tempTable.TEMP
				)
			)
		DECLARE @total INT = (SELECT MAX(#tempTable.id) FROM #tempTable)
	DECLARE @inicio INT = (SELECT MIN(#tempTable.id) FROM #tempTable)
	DECLARE @ErrorLogID INT

	WHILE (@inicio) <= @total
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION

			DECLARE @idRol VARCHAR(2048)
			DECLARE @idUsers VARCHAR(2048)

			SELECT @idRol = (
					SELECT RoleId
					FROM aspnet_Roles
					INNER JOIN #tempTable ON #tempTable.TEMP = aspnet_Roles.RoleName
					WHERE #tempTable.id = @inicio
					)

			SELECT @idUsers = (
					SELECT UserId
					FROM aspnet_Users
					INNER JOIN #tempTable ON #tempTable.NAME = aspnet_Users.UserName
					WHERE #tempTable.id = @inicio
					)

			INSERT INTO aspnet_UsersInRoles (
				UserId
				,RoleId
				)
			VALUES (
				@idUsers
				,@idRol
				)

			SET @inicio = @inicio + 1

			COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			-- Call procedure to print error information.
			EXECUTE dbo.uspPrintError;

			-- Roll back any active or uncommittable transactions before
			-- inserting information in the ErrorLog.
			IF XACT_STATE() <> 0
			BEGIN
				ROLLBACK TRANSACTION;
			END

			EXECUTE dbo.uspLogError @ErrorLogID = @ErrorLogID OUTPUT;
		END CATCH;
	END

	DROP TABLE #tempTable

	--	-- Insertar en la Tabla UsuarioxSegmento
	INSERT INTO UsuarioxSegmento (
		segmento_id
		,userName
		)
	VALUES (
		@Segmento
		,@UserName
		)

	PRINT 'El Usuario se inserto en la Tabla UsuarioxSegmento'
END