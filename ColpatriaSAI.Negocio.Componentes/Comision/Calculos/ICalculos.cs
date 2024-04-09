using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.ServiceModel;
using ColpatriaSAI.Negocio.Entidades;

namespace ColpatriaSAI.Negocio.Componentes.Comision.Calculos
{

    [ServiceContract]
    public interface ICalculos
    {

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pAnio"></param>
        /// <param name="pMes"></param>
        /// <param name="pAsesor"></param>
        /// <returns></returns>
        [OperationContract]
        List<ResultadosCalculos> CalculoTalentos(int pAnio, int pMes, int pAsesor, int pIdModelo, string Username);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pAnio"></param>
        /// <param name="pMes"></param>
        /// <param name="pAsesor"></param>
        /// <param name="pIdModelo"></param>
        /// <returns></returns>
        [OperationContract]
        List<ResultadosCalculos> CalculosNetos(int pAnio, int pMes, int pAsesor, int pIdModelo, string Username);
        
        [OperationContract]
        List<Entidades.ComisionVariableAsesor> ObtenerComisionVariablePorLiquidacion(int liquidacionComisionId);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="modeloId"></param>
        /// <param name="anio"></param>
        /// <param name="mes"></param>
        /// <returns></returns>
        [OperationContract]
        List<Entidades.ResultadoProcedimientos.ComisionFijaFacturacion> ObtenerComisionFijaFacturacionPorLiquidacion(int liquidacioncomisionId);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="modeloId"></param>
        /// <param name="anio"></param>
        /// <param name="mes"></param>
        /// <returns></returns>
        [OperationContract]
        List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion(int liquidacioncomisionId);


        [OperationContract]
        List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion604(int liquidacioncomisionId);

        [OperationContract]
        ResultadoOperacionBD PreCalcularComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId, byte tipoLiquidacionId);

        [OperationContract]
        ResultadoOperacionBD LiquidarComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId);

        [OperationContract]
        List<Entidades.LiquidacionComision> ObtenerHistoricoLiquidaciones();

        [OperationContract(AsyncPattern = true)]
        IAsyncResult BeginProcesoExtraccionBeneficiarioFacturacionRecaudos(string codigoExtraccion,short anio, byte mes, AsyncCallback callback, object asyncState);

        [OperationContract]
        ResultadoOperacionBD ExtractCf_CV(string parmEtlCF, string parmEtlCV, int modeloId, short anio, byte mes,
            int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec);

        [OperationContract]
        List<string[]> obtenerPeriodoCalcComision(int anio, int mes);


        string EndProcesoExtraccionBeneficiarioFacturacionRecaudos(IAsyncResult result);

        [OperationContract]
        List<int> ValLiqPendientes();

        [OperationContract]
        ResultadoOperacionBD LiquidarComisiones(int liquidacionComisionId);

        [OperationContract]
        bool ValidaAnularLiquidacion(int idLiquidacion);

        [OperationContract]
        ResultadoOperacionBD ExtractAnulacion(string parametrosEtl, int idLiquidacion);

        [OperationContract]
        ResultadoOperacionBD ReprocesarLiquidacion(string parmEtlCF, string parmEtlCV, string paramEtlAnulacion, int modeloId, short anio, byte mes,
            int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec);

        [OperationContract]
        ResultadoOperacionBD ActualizaEstadoReprocesar(int idLiquidacion);

        [OperationContract]
        List<int> ValReprocesoLiq();
    }
}
