CREATE TABLE [sig].[RecaudosColquinesSIG] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [clave]            NVARCHAR (50)  NULL,
    [documento]        NVARCHAR (50)  NULL,
    [compania_id]      INT            NULL,
    [lineaNegocio_id]  INT            NULL,
    [ramo_id]          NVARCHAR (20)  NULL,
    [producto_id]      NVARCHAR (50)  NULL,
    [amparo_id]        INT            NULL,
    [cobertura_id]     INT            NULL,
    [modalidadPago_id] INT            NULL,
    [numeroNegocio]    NVARCHAR (100) NULL,
    [numeroRecibo]     NVARCHAR (100) NULL,
    [altura]           INT            NULL,
    [valorRecaudo]     FLOAT          NULL,
    [colquines]        FLOAT          NULL,
    [fechaRecaudo]     DATE           NULL,
    [tipoVehiculo_id]  INT            NULL
);





