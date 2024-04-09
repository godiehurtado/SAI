CREATE TABLE [dbo].[PeriodoCierre] (
    [id]          INT  IDENTITY (1, 1) NOT NULL,
    [compania_id] INT  NULL,
    [mesCierre]   INT  NULL,
    [anioCierre]  INT  NULL,
    [fechaInicio] DATE NULL,
    [fechaFin]    DATE NULL,
    [fechaCierre] DATE NULL,
    [estado]      INT  NULL
);

