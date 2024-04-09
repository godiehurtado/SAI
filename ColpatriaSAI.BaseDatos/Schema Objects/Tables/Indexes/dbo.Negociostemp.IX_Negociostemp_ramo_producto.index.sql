/*CREATE NONCLUSTERED INDEX [IX_Negociostemp_ramo_producto]
    ON [dbo].[Negociostemp]([compania_id] ASC, [sistema] ASC)
    INCLUDE([ramo_id], [productoCodigo]) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];*/

