CREATE TABLE [dbo].[PersistenciaEsperada] (
    [id]               INT   IDENTITY (1, 1) NOT NULL,
    [concurso_id]      INT   NULL,
    [valor]            FLOAT NULL,
    [tipoPersistencia] BIT   NULL,
    [plazo_id]         INT   NULL
);



