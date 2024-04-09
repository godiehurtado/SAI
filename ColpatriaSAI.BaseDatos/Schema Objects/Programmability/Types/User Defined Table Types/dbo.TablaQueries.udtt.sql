CREATE TYPE [dbo].[TablaQueries] AS  TABLE (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [cSelect]        VARCHAR (8000) NULL,
    [cWhere]         VARCHAR (8000) NULL,
    [cHaving]        VARCHAR (8000) NULL,
    [cGroupBy]       VARCHAR (8000) NULL,
    [subRegla_id]    INT            NULL,
    [NoCampos]       INT            NULL,
    [Condiciones_id] VARCHAR (255)  NULL);

