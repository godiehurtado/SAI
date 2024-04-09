CREATE TABLE [dbo].[InformeProductividad] (
    [id]                     INT   IDENTITY (1, 1) NOT NULL,
    [mes]                    INT   NULL,
    [jerarquiaDetalle_id]    INT   NULL,
    [compania_id]            INT   NULL,
    [ramo_id]                INT   NULL,
    [producto_id]            INT   NULL,
    [cantidadNegociosAA]     INT   NULL,
    [asesoresAA]             INT   NULL,
    [productividadMensualAA] FLOAT NULL,
    [primasAA]               FLOAT NULL,
    [cantidadNegociosAV]     INT   NULL,
    [asesoresAV]             INT   NULL,
    [productividadMensualAV] FLOAT NULL,
    [primasAV]               FLOAT NULL,
    [asesoresVAA]            INT   NULL,
    [asesoresVAV]            INT   NULL,
    [primaPromedioAA]        FLOAT NULL,
    [primaPromedioAV]        FLOAT NULL
);

