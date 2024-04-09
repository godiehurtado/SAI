CREATE NONCLUSTERED INDEX [AIX_tipoMedida_id_ConsolidadoMes]
    ON [dbo].[ConsolidadoMes]([tipoMedida_id] ASC)
    INCLUDE([compania_id], [ramo_id], [producto_id], [localidad_id], [clave], [lineaNegocio_id], [plazo_id], [amparo_id]) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];

