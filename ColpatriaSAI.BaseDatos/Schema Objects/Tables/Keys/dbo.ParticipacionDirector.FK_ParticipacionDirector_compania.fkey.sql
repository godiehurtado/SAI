ALTER TABLE [dbo].[ParticipacionDirector]
    ADD CONSTRAINT [FK_ParticipacionDirector_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

