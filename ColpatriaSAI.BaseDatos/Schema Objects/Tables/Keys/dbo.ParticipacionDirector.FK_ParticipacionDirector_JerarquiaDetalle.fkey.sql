ALTER TABLE [dbo].[ParticipacionDirector]
    ADD CONSTRAINT [FK_ParticipacionDirector_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

