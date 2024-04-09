CREATE TABLE [dbo].[ExcepcionesxGrupoTipoEndoso] (
    [id]             INT          IDENTITY (0, 1) NOT NULL,
    [grupoEndoso_id] INT          NULL,
    [tipoEndoso_id]  INT          NULL,
    [compania_id]    INT          NULL,
    [estado]         NVARCHAR (5) NULL
);

