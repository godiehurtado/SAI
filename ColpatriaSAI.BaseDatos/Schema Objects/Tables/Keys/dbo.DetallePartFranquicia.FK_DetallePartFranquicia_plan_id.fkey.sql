ALTER TABLE [dbo].[DetallePartFranquicia]
    ADD CONSTRAINT [FK_DetallePartFranquicia_plan_id] FOREIGN KEY ([plan_id]) REFERENCES [dbo].[Plan] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

