ALTER TABLE [integracion].[Multijerarquia]
    ADD CONSTRAINT [FK_Multijerarquia_Participante] FOREIGN KEY ([director_id]) REFERENCES [integracion].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

