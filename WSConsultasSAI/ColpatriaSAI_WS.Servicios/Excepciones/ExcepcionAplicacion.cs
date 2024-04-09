using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ColpatriaSAI_WS.Servicios.Excepciones
{
    public class ExcepcionAplicacion : System.Exception
    {
        /// <summary>
        /// Constructor que genera una nueva excepción de tipo ExcepcionAplicacion, con un mensaje de error particular
        /// </summary>
        /// <param name="mensaje">Mensaje principal de notificación de la excepción presentada</param>
        public ExcepcionAplicacion(string mensaje)
            : base(mensaje)
        {
        }

        /// <summary>
        /// Constructor que genera una nueva excepción de tipo ExcepcionAplicacion, con un mensaje de error particular y encapsula la excepción original en la propiedad InnerException
        /// </summary>
        /// <param name="mensaje">Mensaje principal de notificación de la excepción presentada</param>
        /// <param name="ex">Excepción original</param>
        public ExcepcionAplicacion(String mensaje, Exception ex)
            : base(mensaje, ex)
        {
        }
    }
}