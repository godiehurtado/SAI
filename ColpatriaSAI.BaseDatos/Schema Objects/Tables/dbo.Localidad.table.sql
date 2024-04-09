CREATE TABLE [dbo].[Localidad] (
    [id]                INT            IDENTITY (0, 1) NOT NULL,
    [nombre]            NVARCHAR (100) NULL,
    [zona_id]           INT            NULL,
    [tipo_localidad_id] INT            NULL,
    [codigo SISE]       NVARCHAR (50)  NULL,
    [codigo CAPI]       INT            NULL,
    [codigo BH]         NVARCHAR (50)  NULL,
    [codigo EMERMEDICA] NVARCHAR (50)  NULL,
    [codigo ARP]        NVARCHAR (50)  NULL,
    [clavePago]         NVARCHAR (20)  NULL
);



