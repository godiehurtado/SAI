CREATE TABLE [dbo].[SubRegla] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [regla_id]             INT           NULL,
    [descripcion]          VARCHAR (100) NULL,
    [principal]            BIT           NULL,
    [tipoSubregla]         INT           NULL,
    [condicionAgrupada_id] INT           NULL
);



