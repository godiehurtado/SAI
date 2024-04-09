CREATE NONCLUSTERED INDEX [IX_compania_ramo_producto_localidad_nn_Recaudo]
    ON [dbo].[Recaudo]([compania_id] ASC, [ramoDetalle_id] ASC, [productoDetalle_id] ASC, [localidad_id] ASC, [numeroNegocio] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];

