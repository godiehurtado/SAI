ALTER TABLE [dbo].[Condicion]
    ADD CONSTRAINT [FK_condicion_variable] FOREIGN KEY ([variable_id]) REFERENCES [dbo].[Variable] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

