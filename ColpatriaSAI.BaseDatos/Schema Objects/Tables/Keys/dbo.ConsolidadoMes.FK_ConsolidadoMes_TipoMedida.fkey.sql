ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_ConsolidadoMes_TipoMedida] FOREIGN KEY ([tipoMedida_id]) REFERENCES [dbo].[TipoMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

