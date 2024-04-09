
-- =============================================
-- Author:		Frank Payares
-- Create date: 03/10/2011
-- Description:	Obtiene los participantes de un concurso para liquidar el la regla actual. Los participantes se insertan en la tabla temporal 'LiquiReglaxPpante'
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_ObtenerParticipantes]
	@concurso_id int
AS
BEGIN
	--DECLARE @concurso_id int=238
	DECLARE @IdConcurso int=@concurso_id
	DECLARE @participante int, @segmento int, @canal int, @categoria int, @nivel int, @tipoConcurso int = (SELECT tipoConcurso_id FROM Concurso WHERE id = @IdConcurso),
		@idTabla int, @liquidacionRegla_id int, @participante_id int, @ParticipanteConcurso CURSOR, @SQL varchar(max)='SELECT 0, id, clave FROM Participante WHERE ', @zona int, @localidad int, @compania int, @nodo_id int
	DECLARE @LiquiReglaxPpante1 TABLE (liquidacionRegla_id int, participante_id int, jerarquiaDetalle_id int)
	
	-- OBTENER LISTA DE PARTICIPANTES DEL CONCURSO INDICADO
	SET @ParticipanteConcurso = CURSOR LOCAL FAST_FORWARD FOR
		SELECT PC.participante_id, PC.segmento_id, PC.canal_id, PC.categoria_id, PC.nivel_id, PC.zona_id, PC.localidad_id, PC.compania_id, PC.jerarquiaDetalle_id, C.tipoConcurso_id
		FROM ParticipanteConcurso PC INNER JOIN Concurso C ON C.id = PC.concurso_id
		WHERE concurso_id = @IdConcurso--
	
	-- RECORRE CADA PARAMETRIZACIÓN CONFIGURADA AL CONCURSO PARA OBTENER LOS PARTICIPANTES
	OPEN @ParticipanteConcurso FETCH NEXT FROM @ParticipanteConcurso INTO @participante, @segmento, @canal, @categoria, @nivel, @zona, @localidad, @compania, @nodo_id, @tipoConcurso
	WHILE @@FETCH_STATUS = 0 BEGIN -- RECORRE LA LISTA DE PARTICIPANTES
		IF @participante <> 0 BEGIN
			IF @tipoConcurso = 1 BEGIN
				-- Define el participante si el concurso es de Asesores
				INSERT INTO @LiquiReglaxPpante1 SELECT 0, id, NULL FROM Participante WHERE id = @participante
			END ELSE BEGIN
				-- Define el participante si el concurso es de Ejecutivos
				INSERT INTO @LiquiReglaxPpante1 SELECT 0, NULL, JD.id FROM JerarquiaDetalle JD WHERE JD.id = @participante
			END
		END
		ELSE BEGIN
			IF @tipoConcurso = 1 BEGIN -- Define el participante si el concurso es de Asesores
				SET @SQL = 'SELECT 0, id, NULL FROM Participante WHERE '
				SET @SQL = @SQL + CASE WHEN @segmento <> 0 THEN 'segmento_id='+ CAST(@segmento as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @canal <> 0 THEN 'canal_id='+ CAST(@canal as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @categoria <> 0 THEN 'categoria_id='+ CAST(@categoria as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @nivel <> 0 THEN 'nivel_id='+ CAST(@nivel as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @zona <> 0 THEN 'zona_id='+ CAST(@zona as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @localidad <> 0 THEN 'localidad_id='+ CAST(@localidad as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @compania <> 0 THEN 'compania_id='+ CAST(@compania as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + ' estadoParticipante_id NOT IN (2,5) GROUP BY id'
			END
			ELSE BEGIN -- Define el participante si el concurso es de Ejecutivos
				SET @SQL = 'SELECT 0, NULL, JD.id FROM Participante P INNER JOIN JerarquiaDetalle JD ON P.id=jd.participante_id INNER JOIN Jerarquia J ON J.id=JD.jerarquia_id WHERE '
				SET @SQL = @SQL + CASE WHEN @segmento <> 0 THEN 'J.segmento_id='+ CAST(@segmento as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @canal <> 0 THEN 'JD.canal_id='+ CAST(@canal as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @nivel <> 0 THEN 'JD.nivel_id='+ CAST(@nivel as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @zona <> 0 THEN 'JD.zona_id='+ CAST(@zona as varchar(10)) +' AND ' ELSE '' END
				SET @SQL = @SQL + CASE WHEN @localidad <> 0 THEN 'JD.localidad_id='+ CAST(@localidad as varchar(10)) +'' ELSE '' END
				SET @SQL = @SQL + ' JD.nivel_id <> 1 GROUP BY P.id, JD.id'
			END
			--IF right(@SQL, 4) = 'AND '  SET @SQL = LEFT(@SQL, LEN(@SQL)-4) --print @SQL
			INSERT INTO @LiquiReglaxPpante1  EXEC (@SQL)
			SET @SQL = ''
		END
		FETCH NEXT FROM @ParticipanteConcurso INTO @participante, @segmento, @canal, @categoria, @nivel, @zona, @localidad, @compania, @nodo_id, @tipoConcurso
	END CLOSE @ParticipanteConcurso DEALLOCATE @ParticipanteConcurso

	--SELECT DISTINCT participante_id, clave into frank FROM @LiquiReglaxPpante1 L inner join Participante P on P.id=L.participante_id --drop table frank
	--SELECT DISTINCT jerarquiaDetalle_id, clave into frank FROM @LiquiReglaxPpante1 L inner join JerarquiaDetalle J on J.id=L.jerarquiaDetalle_id inner join Participante P on P.id=J.participante_id
	INSERT INTO LiquiReglaxPpante
	SELECT DISTINCT * FROM @LiquiReglaxPpante1
END

/*
DECLARE @LiquiReglaxPpante1 TABLE (/*id int IDENTITY(1,1),*/ liquidacionRegla_id int, participante_id int, clave varchar(2048))
DECLARE @LiquiReglaxPpante2 TABLE (/*id int IDENTITY(1,1),*/ liquidacionRegla_id int, participante_id int, clave varchar(2048))
INSERT INTO @LiquiReglaxPpante1 VALUES (1, 10, 123), (1, 10, 123), (1, 20, 456), (1, 20, 456)

INSERT INTO @LiquiReglaxPpante2 (participante_id, liquidacionRegla_id, clave)
	SELECT participante_id, liquidacionRegla_id, clave
	FROM @LiquiReglaxPpante1
	GROUP BY participante_id, liquidacionRegla_id, clave
	HAVING COUNT(participante_id) = 1

;WITH numbered
	AS ( SELECT participante_id, row_number() OVER ( PARTITION BY participante_id ORDER BY participante_id ) AS nr
			FROM @LiquiReglaxPpante1 )
	DELETE  FROM numbered
	WHERE   nr > 1

/*WHILE 1 = 1
   BEGIN
      DELETE   FROM @table
      WHERE    id IN (SELECT   MAX(id)
                        FROM     @table
                        GROUP BY data
                        HAVING   COUNT(*) > 1)
      IF @@Rowcount = 0
         BREAK ;
   END

DELETE   FROM f
FROM     @table AS f INNER JOIN @table AS g
         ON g.data = f.data
              AND f.id < g.id*/

SELECT * FROM PARTICIPANTECONCURSO WHERE CONCURSO_ID=238

select * from @LiquiReglaxPpante1             select * from Participante where compania_id=1 and segmento_id = 1 and canal_id=4 and nivel_id = 1 and categoria_id=2*/