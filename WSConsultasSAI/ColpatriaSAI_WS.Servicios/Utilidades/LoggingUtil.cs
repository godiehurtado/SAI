using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using ColpatriaSAI_WS.Servicios.LoggingSvc;

namespace ColpatriaSAI_WS.Servicios.Utilidades
{
    /// <summary>
    /// Estructura para los tipos de eventos
    /// </summary>
    public static class TipoEvento
    {
        public static TraceEventType Error = TraceEventType.Error;
        public static TraceEventType Advertencia = TraceEventType.Warning;
        public static TraceEventType Critico = TraceEventType.Critical;
        public static TraceEventType Informacion = TraceEventType.Information;
        public static TraceEventType Inicio = TraceEventType.Start;
        public static TraceEventType Parada = TraceEventType.Stop;
    }

    /// <summary>
    /// Clase para registrar eventos de la aplicación en el Event Viewer de Windows
    /// </summary>
    public class LoggingUtil
    {
        /// <summary>
        /// Importancia del evento a registrar
        /// </summary>
        public enum Prioridad
        {
            MuyAlta = 4,
            Alta = 3,
            Media = 2,
            Baja = 1
        }

        /// <summary>
        /// Inserta un registro en el Event Viewer con categoria Información
        /// </summary>
        /// <param name="mensaje">Descripción del evento a registrar</param>
        /// <param name="prioridad">Importancia del evento</param>
        /// <param name="modulo">Origen del evento</param>
        /// <param name="InfoAplicacion">Usuario e IP de donde se originó el evento</param>
        public static void Auditoria(string mensaje, Prioridad prioridad, string direccionIP)
        {
            InfoAplicacion infoAplicacion = new InfoAplicacion();
            infoAplicacion.direccionIP = direccionIP;
            infoAplicacion.nombreUsuario = "WSConsultasSAI";

            LoggingSvc.LoggingClient log = new LoggingSvc.LoggingClient();
            log.Auditoria(mensaje, Convert.ToInt16(prioridad), "ConsultasSAI", infoAplicacion);
        }

        /// <summary>
        /// Inserta un registro en el Event Viewer de Windows con categoria Error y Advertencia
        /// </summary>
        /// <param name="mensaje">Descripcion del evento a registrar</param>
        /// <param name="prioridad">Frecuencia con que ocurre el evento</param>
        /// <param name="modulo">Origen del evento</param>
        /// <param name="tipoEvento">Tipo de evento generado</param>
        /// <param name="InfoAplicacion">Usuario e IP de donde se originó el evento</param>
        public static void Error(string mensaje, Prioridad prioridad, TraceEventType tipoEvento, string direccionIP)
        {
            InfoAplicacion infoAplicacion = new InfoAplicacion();
            infoAplicacion.direccionIP = direccionIP;
            infoAplicacion.nombreUsuario = "WSConsultasSAI";

            LoggingSvc.LoggingClient log = new LoggingSvc.LoggingClient();
            log.Error(mensaje, Convert.ToInt16(prioridad), "ConsultasSAI", tipoEvento, infoAplicacion);
        }

        /// <summary>
        /// Crea un mensaje de log personalizado de invocación de una operación, incluyendo el nombre de la operación y los parametros a reportar
        /// </summary>
        /// <param name="parametros">Contiene los pares nombre - valor para cada uno de los parámetros a incluir en el mensaje</param>
        /// <returns>Mensaje de log personalizado</returns>
        public static String crearMensajeAuditoriaOperacion(Dictionary<string, string> parametros)
        {
            String mensaje = "Invocación de la operación {0}, con parámetros {1}";

            StackTrace stackTrace = new StackTrace();
            StackFrame stackFrame = stackTrace.GetFrame(1);
            MethodBase methodBase = stackFrame.GetMethod();

            String strParametros = "";
            if (parametros.Count == 0)
                strParametros = "(Sin parámetros)";
            else
            {
                foreach (KeyValuePair<string, string> pair in parametros)
                {
                    strParametros += pair.Key + " = " + pair.Value + ", ";
                }
            }

            String[] parametro1 = { methodBase.Name, strParametros };
            return String.Format(mensaje, parametro1);
        }

        /// <summary>
        /// Crea un mensaje de log de error personalizado en la ejecución de una operación, incluyendo el nombre de la operación, los parametros a reportar y el detalle de la excepción generada
        /// </summary>
        /// <param name="parametros">Contiene los pares nombre - valor para cada uno de los parámetros a incluir en el mensaje</param>
        /// <param name="ex">Excepción a reportar dentro del mensaje</param>
        /// <returns>Mensaje de log de error personalizado</returns>
        public static String crearMensajeErrorOperacion(Dictionary<string, string> parametros, Exception ex)
        {
            String mensaje = "Error en la ejecución de la operación {0}, con parámetros {1}- Detalle Error: {2}";

            StackTrace stackTrace = new StackTrace();
            StackFrame stackFrame = stackTrace.GetFrame(1);
            MethodBase methodBase = stackFrame.GetMethod();
            
            String strParametros = "";
            if (parametros.Count == 0)
                strParametros = "(Sin parámetros)";
            else
            {
                foreach (KeyValuePair<string, string> pair in parametros)
                {
                    strParametros += pair.Key + " = " + pair.Value + ", " ;
                }
            }

            String strError = ex.Message;
            if (ex.InnerException != null)
                strError += " " + ex.InnerException.Message;
            else
                strError += " " + ex.StackTrace;

            String[] parametro1 = { methodBase.Name, strParametros, strError};
            return String.Format(mensaje, parametro1);
        }
    }
}