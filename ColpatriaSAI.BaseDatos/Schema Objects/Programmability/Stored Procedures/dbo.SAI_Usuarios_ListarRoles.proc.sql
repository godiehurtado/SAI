CREATE PROCEDURE [dbo].[SAI_Usuarios_ListarRoles]
  
AS
BEGIN

	SELECT
	
	aspnet_Roles.RoleId,
	aspnet_Roles.RoleName,
	aspnet_Roles.Description as Descripcion
	
	FROM aspnet_Roles 



END
