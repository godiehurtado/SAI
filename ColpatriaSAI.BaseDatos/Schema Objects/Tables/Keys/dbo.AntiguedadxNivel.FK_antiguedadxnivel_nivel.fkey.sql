ALTER TABLE [dbo].[AntiguedadxNivel]
    ADD CONSTRAINT [FK_antiguedadxnivel_nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

