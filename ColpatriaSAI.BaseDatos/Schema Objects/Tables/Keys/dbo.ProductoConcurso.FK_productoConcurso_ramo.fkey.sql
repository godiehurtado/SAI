ALTER TABLE [dbo].[ProductoConcurso]
    ADD CONSTRAINT [FK_productoConcurso_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

