using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using ColpatriaSAI_WS.Entidades;

namespace ColpatriaSAI_WS.Servicios
{
    [ServiceContract]
    public interface IWSConsultasSAI
    {
        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'ExtractoAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<ExtractoAsesor> ObtenerExtractoAsesor(string clave, int anio);

        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto de premios del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'PremioAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<PremioAsesor> ObtenerExtractoPremiosAsesor(string clave, int anio);

        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto detallado de premios del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'DetallePremioAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<DetallePremioAsesor> ObtenerExtractoDetalladoPremiosAsesor(string clave, int anio);

        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto siniestralidad para el ramo autos del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'SiniestralidadAutosAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<SiniestralidadAutosAsesor> ObtenerExtractoSiniestralidadAutosAsesor(string clave, int anio);

        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto de persistencia para la compañia Capi del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'PersistenciaCapitalizacionAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<PersistenciaCapitalizacionAsesor> ObtenerExtractoPersistenciaCapitalizacionAsesor(string clave, int anio);

        /// <summary>
        /// Operación que a partir de una clave y año dados, obtiene la información del extracto de persistencia para la compañia Vida del asesor asociado a la clave, para el año especificado
        /// </summary>
        /// <param name="clave">Clave asociada al asesor a consultar</param>
        /// <param name="anio">Año de consulta</param>
        /// <returns>Listado de entidades de tipo 'PersistenciaVidaAsesor' obtenidos para la clave y año especificados</returns>
        [OperationContract]
        List<PersistenciaVidaAsesor> ObtenerExtractoPersistenciaVidaAsesor(string clave, int anio);
    }
}