ALTER TABLE [dbo].[PersistenciadeCAPIDetalle]
    ADD CONSTRAINT [FK_PersistenciadeCAPIDetalle_PlanDetalle] FOREIGN KEY ([planDetalle_id]) REFERENCES [dbo].[PlanDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

