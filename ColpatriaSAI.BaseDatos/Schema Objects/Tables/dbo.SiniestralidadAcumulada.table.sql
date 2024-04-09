CREATE TABLE [dbo].[SiniestralidadAcumulada] (
    [id]                   INT        IDENTITY (1, 1) NOT NULL,
    [clave]                NCHAR (10) NULL,
    [participante_id]      INT        NULL,
    [compania_id]          INT        NULL,
    [ramoDetalle_id]       INT        NULL,
    [siniestrosIncurridos] FLOAT      NULL,
    [primasEmitidas]       FLOAT      NULL,
    [reservaTecnica]       FLOAT      NULL,
    [indSiniestralidad]    FLOAT      NULL,
    [colquinesDescontar]   FLOAT      NULL,
    [ultimoMes]            INT        NULL,
    [anio]                 INT        NULL,
    [fechaCalculo]         DATETIME   NULL,
    [jerarquiaDetalle_id]  INT        NULL,
    [recaudosDescontar]    FLOAT      NULL
);



