ALTER TABLE [dbo].[CanalDetalle]
    ADD CONSTRAINT [FK_CanalDetalle_Canal] FOREIGN KEY ([canal_id]) REFERENCES [dbo].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

