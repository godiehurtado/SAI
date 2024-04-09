ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [DF_ConsolidadoMes_modalidadPago_id] DEFAULT ((0)) FOR [modalidadPago_id];

