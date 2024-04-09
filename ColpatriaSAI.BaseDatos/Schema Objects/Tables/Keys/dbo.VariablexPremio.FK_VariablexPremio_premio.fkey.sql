ALTER TABLE [dbo].[VariablexPremio]
    ADD CONSTRAINT [FK_VariablexPremio_premio] FOREIGN KEY ([premio_id]) REFERENCES [dbo].[Premio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

