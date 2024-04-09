CREATE TABLE [dbo].[GrupoTipoEndoso] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [grupoEndoso_id] INT      NOT NULL,
    [tipoEndoso_id]  INT      NULL,
    [estado]         CHAR (1) NULL
);



