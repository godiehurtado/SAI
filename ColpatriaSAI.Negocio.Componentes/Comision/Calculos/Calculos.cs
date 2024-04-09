using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Talentos = ColpatriaSAI.Negocio.Componentes.Comision.Calculos;
using System.Threading;

namespace ColpatriaSAI.Negocio.Componentes.Comision.Calculos
{
    public class Calculos : ICalculos
    {
        public List<ResultadosCalculos> CalculoTalentos(int pAnio, int pMes, int pIdModelo, int pAsesor = default(int), string Username = default(string))
        {
            return new Talentos.CalculosRepository().CalculoTalentos(pAnio, pMes, pIdModelo, pAsesor, Username);
        }


        public List<ResultadosCalculos> CalculosNetos(int pAnio, int pMes, int pIdModelo, int pAsesor = default(int), string Username = default(string))
        {
            return new Talentos.CalculosRepository().CalculosNetos(pAnio, pMes, pIdModelo, pAsesor, Username);
        }

        public List<Entidades.ComisionVariableAsesor> ObtenerComisionVariablePorLiquidacion(int liquidacionComisionId)
        {
            var res = new Talentos.CalculosRepository().ObtenerComisionVariablePorLiquidacion(liquidacionComisionId);
            return res;
        }

        public List<Entidades.ResultadoProcedimientos.ComisionFijaFacturacion> ObtenerComisionFijaFacturacionPorLiquidacion(int liquidacionComisionId)
        {
            return new Talentos.CalculosRepository().ObtenerComisionFijaFacturacionPorLiquidacion(liquidacionComisionId);
        }

        public List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion(int liquidacionComisionId)
        {
            return new Talentos.CalculosRepository().ObtenerComisionFijaRecaudosPorLiquidacion(liquidacionComisionId);
        }

        public List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion604(int liquidacionComisionId)
        {
            return new Talentos.CalculosRepository().ObtenerComisionFijaRecaudosPorLiquidacion604(liquidacionComisionId);
        }

        public ResultadoOperacionBD PreCalcularComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId, byte tipoLiquidacionId)
        {
            return new Talentos.CalculosRepository().PreCalcularComisionSegunModelo(modeloId, anio, mes,liquidacionComisionId,tipoLiquidacionId);
        }

        public ResultadoOperacionBD LiquidarComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId)
        {
            return new Talentos.CalculosRepository().LiquidarComisionSegunModelo(modeloId, anio, mes, liquidacionComisionId);
        }

        public List<Entidades.LiquidacionComision> ObtenerHistoricoLiquidaciones()
        {
            return new Talentos.CalculosRepository().ObtenerHistoricoLiquidaciones();
        }

        public IAsyncResult BeginProcesoExtraccionBeneficiarioFacturacionRecaudos(string codigoExtraccion, short anio, byte mes, AsyncCallback callback, object asyncState)
        {
            string msg = String.Format("BeginProcesoExtraccionBeneficiarioFacturacionRecaudos called with: {0}{1}{2} ",
                codigoExtraccion,
                anio.ToString(),
                mes.ToString());
            Console.WriteLine(msg);
            return new CompletedAsyncResult<string>(msg);
        }

        public string EndProcesoExtraccionBeneficiarioFacturacionRecaudos(IAsyncResult r)
        {
            CompletedAsyncResult<string> result = r as CompletedAsyncResult<string>;
            Console.WriteLine("EndProcesoExtraccionBeneficiarioFacturacionRecaudos called with: " + result.Data);
            return result.Data;
        }

        public ResultadoOperacionBD ExtractCf_CV(string parmEtlCF, string parmEtlCV, int modeloId, short anio, byte mes,
            int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec)
        {
            return new Talentos.CalculosRepository().ExtractCf_CV(parmEtlCF,parmEtlCV, modeloId, anio, mes, liquidacionComisionId, tipoLiquidacionId, usuario, tipoEjec);
        }

        public List<int> ValLiqPendientes()
        {
            return new Talentos.CalculosRepository().ValLiqPendientes();
        }

        /// <summary>
        /// Obtiene un periodo  de calculo de comisiòn basado en un año y me epsecifico
        /// </summary>
        /// <param name="anio"></param>
        /// <param name="mes"></param>
        /// <returns></returns>
        public List<string[]> obtenerPeriodoCalcComision(int anio, int mes)
        {
            return new Talentos.CalculosRepository().obtenerPeriodoCalcComision(anio,mes);
        }

        public ResultadoOperacionBD LiquidarComisiones(int liquidacionComisionId)
        {
            return new Talentos.CalculosRepository().LiquidarComisiones(liquidacionComisionId);
        }

        
        public bool ValidaAnularLiquidacion(int idLiquidacion)
        {
            return new Talentos.CalculosRepository().ValidaAnularLiquidacion(idLiquidacion);
        }


        public ResultadoOperacionBD ExtractAnulacion(string parametrosEtl, int idLiquidacion)
        {
            return new Talentos.CalculosRepository().ExtractAnulacion(parametrosEtl, idLiquidacion);
        }


        public ResultadoOperacionBD ReprocesarLiquidacion(string parmEtlCF, string parmEtlCV, string paramEtlAnulacion, int modeloId, short anio, byte mes, int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec)
        {
            return new Talentos.CalculosRepository().ReprocesarLiquidacion(parmEtlCF,parmEtlCV,paramEtlAnulacion,
                modeloId,anio,mes,liquidacionComisionId,tipoLiquidacionId, usuario,tipoEjec);
         }


        public ResultadoOperacionBD ActualizaEstadoReprocesar(int idLiquidacion)
        {
            return new Talentos.CalculosRepository().ActualizaEstadoReprocesar(idLiquidacion);
        }


        public List<int> ValReprocesoLiq()
        {
            return new Talentos.CalculosRepository().ValReprocesoLiq();
        }
    }

    class CompletedAsyncResult<T> : IAsyncResult
    {
        T data;

        public CompletedAsyncResult(T data)
        { this.data = data; }

        public T Data
        { get { return data; } }

        #region IAsyncResult Members
        public object AsyncState
        { get { return (object)data; } }

        public WaitHandle AsyncWaitHandle
        { get { throw new Exception("The method or operation is not implemented."); } }

        public bool CompletedSynchronously
        { get { return true; } }

        public bool IsCompleted
        { get { return true; } }
        #endregion
    }
}
