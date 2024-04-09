ALTER TABLE [dbo].[Premio]
    ADD CONSTRAINT [FK_variable_premio] FOREIGN KEY ([variable_id]) REFERENCES [dbo].[Variable] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

