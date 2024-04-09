CREATE PROCEDURE [dbo].[SAI_EjecutarETL]

@nombreETL as nvarchar (2048) 

AS
BEGIN

	  DECLARE @fileSystem as nvarchar (2048) =  (SELECT pa.valor FROM ParametrosApp pa WHERE pa.id = 5)	  
	  DECLARE @servidorETL as nvarchar (2048) = (SELECT pa.valor FROM ParametrosApp pa WHERE pa.id = 10)
	  DECLARE @RutaConfigFile as nvarchar (2048) = (SELECT pa.valor FROM ParametrosApp pa WHERE pa.id = 4)

      DECLARE @Comando Varchar(4000)
      SET @Comando = 'Dtexec /DTS "'+ @fileSystem + @nombreETL +  '" /SERVER "' +  @servidorETL +  '" /CONFIGFILE "' + @RutaConfigFile + 'DataSource.dtsConfig"  /CHECKPOINTING OFF  /REPORTING V '
           
      EXEC Master..xp_cmdshell @Comando
      PRINT @Comando
      
END


 --DECLARE @Comando1 Varchar(4000)
 --     SET @Comando1 = 'Dtexec /DTS "\File System\SAI\CAPI_Productos" /SERVER "PRU-ETLRPTUI01" /CONFIGFILE "F:\Archivos SAI\Paquetes de Integracion\SAI_Integration\SAI_Integration\bin\Deployment\DataSource.dtsConfig"  /CHECKPOINTING OFF  /REPORTING V '
           
 --     --EXEC Master..xp_cmdshell @Comando1
 --     PRINT @Comando1