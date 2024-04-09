CREATE TABLE [dbo].[PlanDetalle] (
    [id]                 INT            IDENTITY (0, 1) NOT NULL,
    [nombre]             NVARCHAR (150) NULL,
    [productoDetalle_id] INT            NULL,
    [plan_id]            INT            NULL,
    [codigoCore]         NVARCHAR (20)  NULL
);





