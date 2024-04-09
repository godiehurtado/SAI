ALTER TABLE [dbo].[ETLRemota]
    ADD CONSTRAINT [DF_ETLRemota_tipo] DEFAULT ((1)) FOR [tipoETLRemota_id];

