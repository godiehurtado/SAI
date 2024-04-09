
       CREATE PROCEDURE InsertCategoryLog
             @CategoryID INT,
             @LogID INT
       AS
       BEGIN
             SET NOCOUNT ON;

             DECLARE @CatLogID INT
             SELECT @CatLogID FROM log.CategoriaLog WHERE CategoryID=@CategoryID and LogID = @LogID
             IF @CatLogID IS NULL
             BEGIN
                    INSERT INTO log.CategoriaLog (CategoryID, LogID) VALUES(@CategoryID, @LogID)
                    RETURN @@IDENTITY
             END
             ELSE RETURN @CatLogID
       END
       