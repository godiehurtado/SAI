ALTER TABLE [dbo].[Presupuesto]
    ADD CONSTRAINT [DF_Presupuesto_calculado] DEFAULT ((0)) FOR [calculado];

