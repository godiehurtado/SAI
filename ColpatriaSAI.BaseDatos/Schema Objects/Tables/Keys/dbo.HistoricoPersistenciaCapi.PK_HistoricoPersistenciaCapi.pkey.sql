﻿ALTER TABLE [dbo].[HistoricoPersistenciaCapi]
    ADD CONSTRAINT [PK_HistoricoPersistenciaCapi] PRIMARY KEY CLUSTERED ([id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

