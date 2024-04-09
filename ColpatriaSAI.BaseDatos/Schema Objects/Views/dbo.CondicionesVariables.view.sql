

CREATE VIEW [dbo].[CondicionesVariables]
AS
SELECT     dbo.Condicion.id AS condicion_id, dbo.Condicion.variable_id, dbo.Condicion.operador_id, dbo.Condicion.valor, dbo.Condicion.subregla_id, dbo.Condicion.seleccion, 
                      dbo.Condicion.textoSeleccion, dbo.Condicion.fecha, dbo.Variable.descripcion, dbo.Variable.nombre, dbo.Variable.tipoVariable_id, dbo.Variable.tabla_id, 
                      dbo.Variable.agregacion, dbo.Variable.columnaTablaMaestra, dbo.Variable.tipoDato, dbo.Variable.operacionAgregacion_id, dbo.Operador.nombre AS nombreExpresion,
                       dbo.Operador.expresion, dbo.Operador.logico, dbo.OperacionAgregacion.simboloSQL
FROM         dbo.Condicion INNER JOIN
                      dbo.Variable ON dbo.Variable.id = dbo.Condicion.variable_id INNER JOIN
                      dbo.Operador ON dbo.Condicion.operador_id = dbo.Operador.id LEFT OUTER JOIN
                      dbo.OperacionAgregacion ON dbo.Variable.operacionAgregacion_id = dbo.OperacionAgregacion.id



