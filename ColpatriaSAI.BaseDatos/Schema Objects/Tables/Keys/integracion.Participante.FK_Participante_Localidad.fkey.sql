ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [integracion].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

