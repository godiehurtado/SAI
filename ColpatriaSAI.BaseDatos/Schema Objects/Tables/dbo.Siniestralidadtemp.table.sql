CREATE TABLE [dbo].[Siniestralidadtemp] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [compania_id]          NVARCHAR (50) NULL,
    [fechaCorte]           NVARCHAR (50) NULL,
    [ramodetalle_id]       NVARCHAR (50) NULL,
    [clave]                NVARCHAR (50) NULL,
    [siniestrosIncurridos] FLOAT         NULL,
    [primasEmitidas]       FLOAT         NULL,
    [reservaTecnica]       FLOAT         NULL
);



