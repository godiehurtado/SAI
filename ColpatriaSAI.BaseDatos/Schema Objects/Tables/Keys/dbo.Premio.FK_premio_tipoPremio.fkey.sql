ALTER TABLE [dbo].[Premio]
    ADD CONSTRAINT [FK_premio_tipoPremio] FOREIGN KEY ([tipoPremio_id]) REFERENCES [dbo].[TipoPremio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

