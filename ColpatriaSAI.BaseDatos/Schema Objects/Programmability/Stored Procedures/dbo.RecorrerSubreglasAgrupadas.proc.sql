CREATE PROCEDURE [dbo].[RecorrerSubreglasAgrupadas]

@subreglaActual AS INT,
@subreglaNueva AS INT,
@reglaActual AS INT,
@reglaNueva AS INT

AS
BEGIN
	
	INSERT INTO DuplicarSubreglas 
	(subreglaActual
	, subreglaNueva
	, reglaActual
	, reglaNueva
	)
	VALUES (@subreglaActual,
	@subreglaNueva ,
	@reglaActual,
	@reglaNueva
	)	

END