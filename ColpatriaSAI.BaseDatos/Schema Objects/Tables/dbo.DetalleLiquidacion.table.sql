CREATE TABLE [dbo].[DetalleLiquidacion] (
    [id]              INT   IDENTITY (0, 1) NOT NULL,
    [valor]           FLOAT NULL,
    [liquidacion_id]  INT   NULL,
    [concepto_id]     INT   NULL,
    [participante_id] INT   NULL
);



