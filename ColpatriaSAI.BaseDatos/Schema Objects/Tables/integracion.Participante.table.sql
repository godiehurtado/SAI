CREATE TABLE [integracion].[Participante] (
    [id]                    INT            NOT NULL,
    [clave]                 NVARCHAR (20)  NULL,
    [nombre]                NVARCHAR (100) NULL,
    [apellidos]             NVARCHAR (100) NULL,
    [tipoDocumento_id]      INT            NULL,
    [documento]             NVARCHAR (20)  NULL,
    [email]                 NVARCHAR (100) NULL,
    [telefono]              NVARCHAR (50)  NULL,
    [direccion]             NVARCHAR (200) NULL,
    [estadoParticipante_id] INT            NULL,
    [fechaIngreso]          DATETIME       NULL,
    [fechaRetiro]           DATETIME       NULL,
    [fechaNacimiento]       DATETIME       NULL,
    [nivel_id]              INT            NULL,
    [compania_id]           INT            NULL,
    [zona_id]               INT            NULL,
    [localidad_id]          INT            NULL,
    [canal_id]              INT            NULL,
    [categoria_id]          INT            NULL,
    [ingresosMinimos]       FLOAT          NULL,
    [tipoParticipante_id]   INT            NULL,
    [salario]               FLOAT          NULL,
    [segmento_id]           INT            NULL
);



