ALTER TABLE [dbo].[SubRegla]
    ADD CONSTRAINT [FK_subregla_regla] FOREIGN KEY ([regla_id]) REFERENCES [dbo].[Regla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

