ALTER TABLE [integracion].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_Participante] FOREIGN KEY ([participante_id]) REFERENCES [integracion].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

