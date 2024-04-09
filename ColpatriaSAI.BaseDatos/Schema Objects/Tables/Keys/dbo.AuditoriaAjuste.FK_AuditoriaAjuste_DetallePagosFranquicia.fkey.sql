ALTER TABLE [dbo].[AuditoriaAjuste]
    ADD CONSTRAINT [FK_AuditoriaAjuste_DetallePagosFranquicia] FOREIGN KEY ([detallePagosFranquicia_id]) REFERENCES [dbo].[DetallePagosFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

