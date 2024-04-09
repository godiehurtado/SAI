CREATE TABLE [dbo].[ProcesoLiquidacion] (
    [id]               INT  IDENTITY (1, 1) NOT NULL,
    [tipo]             INT  NULL,
    [liquidacion_id]   INT  NULL,
    [fechaInicio]      DATE NULL,
    [estadoProceso_id] INT  NULL
);



