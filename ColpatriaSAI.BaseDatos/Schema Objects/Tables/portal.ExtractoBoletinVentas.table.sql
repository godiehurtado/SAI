CREATE TABLE [portal].[ExtractoBoletinVentas] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [Posicion]        INT            NULL,
    [Zona]            INT            NULL,
    [Localidad]       INT            NULL,
    [Clave]           NVARCHAR (100) NULL,
    [NombreAsesor]    NVARCHAR (250) NULL,
    [Categoría]       NVARCHAR (150) NULL,
    [Compania_id]     INT            NULL,
    [Ramo_id]         INT            NULL,
    [LíneaNegocio_id] INT            NULL,
    [UnidadMedida_id] INT            NULL,
    [Enero]           FLOAT          NULL,
    [Febrero]         FLOAT          NULL,
    [Marzo]           FLOAT          NULL,
    [Abril]           FLOAT          NULL,
    [Mayo]            FLOAT          NULL,
    [Junio]           FLOAT          NULL,
    [Julio]           FLOAT          NULL,
    [Agosto]          FLOAT          NULL,
    [Septiembre]      FLOAT          NULL,
    [Octubre]         FLOAT          NULL,
    [Noviembre]       FLOAT          NULL,
    [Diciembre]       FLOAT          NULL
);



