ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_Categoria] FOREIGN KEY ([categoria_id]) REFERENCES [integracion].[Categoria] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

