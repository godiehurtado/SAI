ALTER TABLE [dbo].[VariablexPremio]
    ADD CONSTRAINT [FK_VariablexPremio_variable] FOREIGN KEY ([variable_id]) REFERENCES [dbo].[Variable] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

