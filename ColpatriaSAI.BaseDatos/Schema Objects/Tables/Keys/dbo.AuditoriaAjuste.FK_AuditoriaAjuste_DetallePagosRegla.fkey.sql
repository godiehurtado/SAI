ALTER TABLE [dbo].[AuditoriaAjuste]
    ADD CONSTRAINT [FK_AuditoriaAjuste_DetallePagosRegla] FOREIGN KEY ([detallePagosRegla_id]) REFERENCES [dbo].[DetallePagosRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

