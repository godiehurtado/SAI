ALTER TABLE [dbo].[DetallePagosFranquicia]
    ADD CONSTRAINT [DF_dbo_DetallePagosFranquicia_pagoFranquicia_id] DEFAULT ((7)) FOR [pagoFranquicia_id];

