
CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_IsUserInRoles]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @RoleNames         nvarchar(256)
    
AS
BEGIN
DECLARE  @TEMPDIAG TABLE (ROL varchar (128), ESTADO INT)
DECLARE @RoleName nvarchar (128)
DECLARE @Delimiter nvarchar(5)
SET @Delimiter = '|'
Declare @Contador int
Set @Contador = 1
	
DECLARE Roles_Cursor CURSOR FOR
 select s from dbo.SplitString(@RoleNames, '|')    
	
	OPEN Roles_Cursor;
	      FETCH NEXT FROM Roles_Cursor
      INTO @RoleName 
      	
WHILE @@FETCH_STATUS = 0
   BEGIN	
   -- se verifica la existencia del usuario en el rol
	DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        --RETURN(2)
        INSERT INTO @TEMPDIAG VALUES(@RoleName,2) 
        
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    DECLARE @RoleId uniqueidentifier
    SELECT  @RoleId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        --RETURN(2)
INSERT INTO @TEMPDIAG VALUES(@RoleName,2) 



    SELECT  @RoleId = RoleId
    FROM    dbo.aspnet_Roles
    WHERE   LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
        --RETURN(3)
INSERT INTO @TEMPDIAG VALUES(@RoleName,3) 




    IF (EXISTS( SELECT * FROM dbo.aspnet_UsersInRoles WHERE  UserId = @UserId AND RoleId = @RoleId))
        --RETURN(1)
        INSERT INTO @TEMPDIAG VALUES(@RoleName,1) 
    ELSE
       --RETURN(0)
      INSERT INTO @TEMPDIAG VALUES(@RoleName,0)
       
 FETCH NEXT FROM Roles_Cursor
      INTO @RoleName 				

	
END




      
      
   END
CLOSE Roles_Cursor;
DEALLOCATE Roles_Cursor;
SELECT * FROM @TEMPDIAG
FOR XML RAW

