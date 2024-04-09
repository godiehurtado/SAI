ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_PlanDetalle] FOREIGN KEY ([planDetalle_id]) REFERENCES [dbo].[PlanDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

