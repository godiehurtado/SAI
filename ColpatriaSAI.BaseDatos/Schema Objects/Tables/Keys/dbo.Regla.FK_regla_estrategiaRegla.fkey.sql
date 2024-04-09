ALTER TABLE [dbo].[Regla]
    ADD CONSTRAINT [FK_regla_estrategiaRegla] FOREIGN KEY ([estrategiaregla_id]) REFERENCES [dbo].[EstrategiaRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

