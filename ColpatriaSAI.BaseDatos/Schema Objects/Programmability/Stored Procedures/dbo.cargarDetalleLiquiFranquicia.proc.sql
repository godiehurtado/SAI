CREATE PROCEDURE cargarDetalleLiquiFranquicia
	-- Add the parameters for the stored procedure here
	
	
    @porcentajeParticipacion float , 
    @liquidacionFranquicia_id int , 
    @localidad_id int , 
    @compania_id int , 
    @ramo_id int , 
    @producto_id int , 
    @numeroNegocio nvarchar(50) , 
    @claveParticipante nvarchar(50), 
    @modalidadPagoId varchar(50) , 
    @numeroRecibo nvarchar(50) , 
    @fechaRecaudo datetime , 
    @amparo_Id varchar(50) 
   
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[DetalleLiquidacionFranquicia] 
	([porcentajeParticipacion],
	[liquidacionFranquicia_id],
	[localidad_id],
	[compania_id],
	[ramo_id],
	[producto_id],
	[numeroNegocio],
	[claveParticipante],
	[modalidadPagoId],
	[numeroRecibo],
	[fechaRecaudo],
	[amparo_Id]) VALUES (
	@porcentajeParticipacion,
    @liquidacionFranquicia_id , 
    @localidad_id , 
    @compania_id , 
    @ramo_id, 
    @producto_id , 
    @numeroNegocio , 
    @claveParticipante , 
    @modalidadPagoId , 
    @numeroRecibo , 
    @fechaRecaudo , 
    @amparo_Id)
    
	
	
	;  SELECT SCOPE_IDENTITY() AS [id]
END
