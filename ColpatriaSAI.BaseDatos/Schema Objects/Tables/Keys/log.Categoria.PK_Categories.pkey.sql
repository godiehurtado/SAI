﻿ALTER TABLE [log].[Categoria]
    ADD CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

