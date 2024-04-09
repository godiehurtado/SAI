CREATE PROCEDURE [dbo].[SAI_Usuarios_ListarUsuarios]
  
AS
BEGIN

	SELECT
	
	aspnet_Users.UserId,
	aspnet_Users.UserName,
	aspnet_Profile.PropertyValuesString,
	aspnet_Membership.Email,
	aspnet_Users.LastActivityDate
	
	FROM aspnet_Users 
	inner join aspnet_Profile on aspnet_Profile.UserId = aspnet_Users.UserId 
	inner join aspnet_Membership on aspnet_Membership.UserId = aspnet_Users.UserId



END
