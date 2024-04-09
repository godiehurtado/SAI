ALTER TABLE [dbo].[Variable]
    ADD CONSTRAINT [FK_operacionAgregacion_Variable] FOREIGN KEY ([operacionAgregacion_id]) REFERENCES [dbo].[OperacionAgregacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

