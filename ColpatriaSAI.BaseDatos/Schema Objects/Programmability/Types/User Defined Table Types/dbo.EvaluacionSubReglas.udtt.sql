CREATE TYPE [dbo].[EvaluacionSubReglas] AS  TABLE (
    [subregla_id]  INT          NULL,
    [subregla_id1] INT          NULL,
    [resultado1]   BIT          NULL,
    [subregla_id2] INT          NULL,
    [resultado2]   BIT          NULL,
    [operador]     VARCHAR (50) NULL,
    [resultado]    BIT          NULL);

