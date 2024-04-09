ALTER TABLE [dbo].[PlanDetalle]
    ADD CONSTRAINT [FK_Plan_PlanDetalle] FOREIGN KEY ([plan_id]) REFERENCES [dbo].[Plan] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

