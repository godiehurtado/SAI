ALTER TABLE [dbo].[Condicion]
    ADD CONSTRAINT [FK_condicion_subregla] FOREIGN KEY ([subregla_id]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

