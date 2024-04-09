ALTER TABLE [integracion].[PlanDetalle]
    ADD CONSTRAINT [FK_PlanDetalle_Plan] FOREIGN KEY ([plan_id]) REFERENCES [integracion].[Plan] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

