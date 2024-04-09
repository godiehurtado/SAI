ALTER TABLE [integracion].[Log]
    ADD CONSTRAINT [DF_Log_estado] DEFAULT ((0)) FOR [estado];

