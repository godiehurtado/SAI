using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ColpatriaSAI_WS.Servicios.Excepciones
{
    public class ExcepcionNegocio : System.Exception
    {
        /// <summary>
        /// Constructor que genera una nueva excepción de tipo ExcepcionNegocio, con un mensaje de error particular
        /// </summary>
        /// <param name="mensaje">Mensaje principal de notificación de la excepción presentada</param>
        public ExcepcionNegocio(string mensaje)
            : base(mensaje)
        {
        }
    }
}