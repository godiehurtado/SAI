ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Participante] FOREIGN KEY ([participante_id]) REFERENCES [integracion].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

