ALTER TABLE [dbo].[PeriodoCierre]
    ADD CONSTRAINT [FK_PeriodoCierre_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

