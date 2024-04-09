ALTER TABLE [dbo].[ParticipacionDirector]
    ADD CONSTRAINT [FK_ParticipacionDirector_Canal] FOREIGN KEY ([canal_id]) REFERENCES [dbo].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

