ALTER TABLE [dbo].[CondicionAgrupada]
    ADD CONSTRAINT [FK_Regla_condicionAgrupada] FOREIGN KEY ([regla_id]) REFERENCES [dbo].[Regla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

