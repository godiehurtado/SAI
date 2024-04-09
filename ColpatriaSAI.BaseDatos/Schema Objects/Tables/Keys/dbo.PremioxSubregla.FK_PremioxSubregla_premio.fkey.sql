ALTER TABLE [dbo].[PremioxSubregla]
    ADD CONSTRAINT [FK_PremioxSubregla_premio] FOREIGN KEY ([premio_id]) REFERENCES [dbo].[Premio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

