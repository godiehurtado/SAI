ALTER TABLE [dbo].[PremioxSubregla]
    ADD CONSTRAINT [FK_PremioxSubregla_subregla] FOREIGN KEY ([subregla_id]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

