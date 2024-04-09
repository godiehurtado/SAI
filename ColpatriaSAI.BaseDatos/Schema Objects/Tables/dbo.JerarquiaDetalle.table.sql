CREATE TABLE [dbo].[JerarquiaDetalle] (
    [id]              INT            IDENTITY (0, 1) NOT NULL,
    [jerarquia_id]    INT            NOT NULL,
    [nombre]          NVARCHAR (100) NOT NULL,
    [descripcion]     NVARCHAR (500) NULL,
    [padre_id]        INT            NULL,
    [zona_id]         INT            NOT NULL,
    [localidad_id]    INT            NOT NULL,
    [canal_id]        INT            NOT NULL,
    [participante_id] INT            NOT NULL,
    [codigoNivel]     NVARCHAR (80)  NULL,
    [nivel_id]        INT            NULL,
    [codJerarquia]    NVARCHAR (50)  NULL
);



