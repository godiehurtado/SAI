using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using ColpatriaSAI_WS.Entidades;
using ColpatriaSAI_WS.Datos;
using ColpatriaSAI_WS.Servicios.Excepciones;
using ColpatriaSAI_WS.Servicios.LoggingSvc;
using ColpatriaSAI_WS.Servicios.Utilidades;

namespace ColpatriaSAI_WS.Servicios
{
    public class WSConsultasSAI : IWSConsultasSAI
    {
        public List<ExtractoAsesor> ObtenerExtractoAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());

            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    List<ExtractoAsesor> listaExtractoAsesor = contexto.ObtenerExtractoAsesor(clave, anio).ToList();
                    return listaExtractoAsesor;
                }
            }
            catch(ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }

        public List<PremioAsesor> ObtenerExtractoPremiosAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());

            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    List<PremioAsesor> listaPremioAsesor = contexto.ObtenerExtractoPremiosAsesor(clave, anio).ToList();
                    return listaPremioAsesor;
                }
            }
            catch (ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }

        public List<DetallePremioAsesor> ObtenerExtractoDetalladoPremiosAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());

            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    // Se realiza la consulta del estracto por clave y año
                    List<ExtractoDetallePremioAsesor> listaExtractoDetallePremioAsesor = contexto.ObtenerExtractoDetalladoPremiosAsesor(clave, anio).ToList();
                    // Se obtiene la totalidad de los conjuntos (codigoPremio, gano, fechaCierrePremio) sin repeticiones
                    var listaPremios = listaExtractoDetallePremioAsesor.Select(e => new { e.codigoPremio, e.gano, e.fechaCierrePremio }).Distinct().ToArray();
                    List<DetallePremioAsesor> detallePremioAsesor = new List<DetallePremioAsesor>();

                    // Se itera la lista de conjuntos (codigoPremio, gano, fechaCierrePremio)
                    for (int i = 0; i < listaPremios.Length; i++ )
                    {
                        // Se filtran los resultados de la consulta por la combinación actual (codigoPremio, gano, fechaCierrePremio)
                        List<ExtractoDetallePremioAsesor> listaPorPremio = listaExtractoDetallePremioAsesor.Where(ldpa => ldpa.codigoPremio == listaPremios[i].codigoPremio && ldpa.gano == listaPremios[i].gano && ldpa.fechaCierrePremio == listaPremios[i].fechaCierrePremio).ToList();
                        // Se crea una lista para almacenar los detalles para la combinación actual
                        List<DetallePremio> detallesPremio = new List<DetallePremio>();

                        // Se itera cada uno de los registros de la combinación actual
                        foreach (ExtractoDetallePremioAsesor lpp in listaPorPremio)
                        {
                            //Se verifica que exista detalle del premio
                            if (lpp.condicion != null || lpp.meta != null || lpp.ejecutado != null || lpp.faltante != null)
                            {
                                // Se crea el detalle del premio
                                DetallePremio detallePremio = new DetallePremio(lpp.condicion, lpp.meta, lpp.ejecutado, lpp.faltante);
                                // Se adiciona el detalle del premio a la lista
                                detallesPremio.Add(detallePremio);
                            }
                        }

                        // Se crea el premio actual con la información del primer registro del filtro por código de premio y se adiciona la lista de detalles para el premio
                        detallePremioAsesor.Add(new DetallePremioAsesor(listaPorPremio[0].codigoPremio, listaPorPremio[0].premio, listaPorPremio[0].gano, listaPorPremio[0].descripcionPremioGanado, listaPorPremio[0].fechaCierrePremio, detallesPremio));
                    }

                    return detallePremioAsesor;
                }
            }
            catch (ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }

        public List<SiniestralidadAutosAsesor> ObtenerExtractoSiniestralidadAutosAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());
            
            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    List<SiniestralidadAutosAsesor> listaSiniestralidadAutosAsesor = contexto.ObtenerExtractoSiniestralidadAutosAsesor(clave, anio).ToList();
                    return listaSiniestralidadAutosAsesor;
                }
            }
            catch (ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }

        public List<PersistenciaCapitalizacionAsesor> ObtenerExtractoPersistenciaCapitalizacionAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());

            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    List<PersistenciaCapitalizacionAsesor> listaPersistenciaCapitalizacionAsesor = contexto.ObtenerExtractoPersistenciaCapitalizacionAsesor(clave, anio).ToList();
                    return listaPersistenciaCapitalizacionAsesor;
                }
            }
            catch (ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }

        public List<PersistenciaVidaAsesor> ObtenerExtractoPersistenciaVidaAsesor(string clave, int anio)
        {
            //Se crea un diccionario con los pares nombre parametro - valor parametro, incluyendo todos los parámetros recibidos en la operación
            Dictionary<string, string> parametros = new Dictionary<string, string>();
            parametros.Add("clave", clave.ToString());
            parametros.Add("anio", anio.ToString());

            String mensajeAuditoria = LoggingUtil.crearMensajeAuditoriaOperacion(parametros);
            LoggingUtil.Auditoria(mensajeAuditoria, LoggingUtil.Prioridad.Baja, ServiceUtil.ObtenerIPCliente());

            try
            {
                using (var contexto = new SAI_WSEntityConnection())
                {
                    List<PersistenciaVidaAsesor> listaPersistenciaVidaAsesor = contexto.ObtenerExtractoPersistenciaVidaAsesor(clave, anio).ToList();
                    return listaPersistenciaVidaAsesor;
                }
            }
            catch (ExcepcionNegocio ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Baja, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                throw;
            }
            catch (Exception ex)
            {
                String mensajeError = LoggingUtil.crearMensajeErrorOperacion(parametros, ex);
                LoggingUtil.Error(mensajeError, LoggingUtil.Prioridad.Alta, TipoEvento.Error, ServiceUtil.ObtenerIPCliente());

                ExcepcionAplicacion exception = new ExcepcionAplicacion("Ocurrió un error interno en la aplicación!");
                throw exception;
            }
        }
    }
}