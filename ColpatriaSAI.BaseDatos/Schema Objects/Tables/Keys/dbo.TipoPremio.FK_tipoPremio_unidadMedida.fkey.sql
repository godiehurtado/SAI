ALTER TABLE [dbo].[TipoPremio]
    ADD CONSTRAINT [FK_tipoPremio_unidadMedida] FOREIGN KEY ([unidadMedida_id]) REFERENCES [dbo].[UnidadMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

