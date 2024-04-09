ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_PlanDetalle] FOREIGN KEY ([planDetalle_id]) REFERENCES [dbo].[PlanDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

