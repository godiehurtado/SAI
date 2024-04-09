ALTER TABLE [dbo].[EjecucionDetalle]
    ADD CONSTRAINT [DF_EjecucionDetalle_tipo] DEFAULT ((0)) FOR [tipo];

