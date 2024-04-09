
             CREATE PROCEDURE ClearLogs
             AS
             BEGIN
                    SET NOCOUNT ON;

                    DELETE FROM log.CategoriaLog
                    DELETE FROM log.Log
                    DELETE FROM log.Categoria
             END
             