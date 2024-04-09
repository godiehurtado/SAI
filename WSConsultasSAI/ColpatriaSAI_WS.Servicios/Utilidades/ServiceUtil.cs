using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel;
using System.ServiceModel.Channels;

namespace ColpatriaSAI_WS.Servicios.Utilidades
{
    public class ServiceUtil
    {
        /// <summary>
        /// Optiene la dirección IP del cliente que está invocando el servicio web
        /// </summary>
        /// <returns>La direscción IP del cliente</returns>
        public static string ObtenerIPCliente()
        {
            OperationContext context = OperationContext.Current;
            MessageProperties messageProperties = context.IncomingMessageProperties;
            RemoteEndpointMessageProperty endpointProperty = messageProperties[RemoteEndpointMessageProperty.Name] as RemoteEndpointMessageProperty;

            return endpointProperty.Address;
        }
    }
}