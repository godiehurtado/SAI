using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ColpatriaSAI.Datos;
using System.Threading;
using System.Data;
using Entidades = ColpatriaSAI.Negocio.Entidades;
using Componentes = ColpatriaSAI.Negocio.Componentes;
using System.Data.EntityClient;
using System.Data.SqlClient;
using ColpatriaSAI.Negocio.Entidades;

namespace ColpatriaSAI.Negocio.Componentes.Comision.Calculos
{
    public class CalculosRepository
    {

        private SAI_Entities _dbcontext = new SAI_Entities();

        #region Calculos e Insercion Talentos
        public List<ResultadosCalculos> CalculoTalentos(int pAnio, int pMes, int pIdModelo, int pAsesor = default(int), string Username = default(string))
        {
            return new CalculosTalentos().CalculoTalentos(pAnio, pMes, pIdModelo, pAsesor, Username);
        }

        #endregion

        #region Calculos e Insercion Netos

        public List<ResultadosCalculos> CalculosNetos(int pAnio, int pMes, int pIdModelo, int pAsesor = default(int), string Username = default(string))
        {
            return new CalculosNetos().CalculoNetos(pAnio, pMes, pIdModelo, pAsesor, Username);
        }

        #endregion

        #region Calculos de Comision

        #region Comision Variable
        internal List<Entidades.ComisionVariableAsesor> ObtenerComisionVariablePorLiquidacion(int liquidacionComisionId)
        {
            return _dbcontext.ComisionVariableAsesors
                .Include("Participante")
                .Where(cva => cva.liquidacioncomision_id == liquidacionComisionId).ToList();
            //.Join(_dbcontext.Participantes,
            //        x => x.participante_id,
            //        y => y.id,
            //        (x, y) => new Entidades.ComisionVariableAsesor()
            //        {
            //            id = x.id,
            //            liquidacioncomision_id = x.liquidacioncomision_id,
            //            Participante = y,
            //            rangoXInferior = x.rangoXInferior,
            //            rangoXSuperior = x.rangoXSuperior,
            //            rangoYInferior = x.rangoYInferior,
            //            rangoYsuperior = x.rangoYsuperior,
            //            talentosnetos = x.talentosnetos,
            //            talentosnuevos = x.talentosnuevos,
            //            participante_id = x.participante_id,
            //            comisionvariable = x.comisionvariable
            //        }).ToList();
        }
        #endregion

        #region Comision Fija
        internal List<Entidades.ResultadoProcedimientos.ComisionFijaFacturacion> ObtenerComisionFijaFacturacionPorLiquidacion(int liquidacionComisionId)
        {
            List<Entidades.ResultadoProcedimientos.ComisionFijaFacturacion> resultados = new List<Entidades.ResultadoProcedimientos.ComisionFijaFacturacion>();
            String cmdtxt = "dbo.ObtenerComisionFijaFacturacionPorLiquidacion";
            DataSet retVal = new DataSet();
            SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
            SqlCommand cmdReport = new SqlCommand(cmdtxt, sqlConn);
            cmdReport.CommandType = CommandType.StoredProcedure;
            cmdReport.Parameters.Add("liquidacioncomision_id", SqlDbType.Int);
            cmdReport.Parameters["liquidacioncomision_id"].Value = liquidacionComisionId;
            SqlDataAdapter daReport = new SqlDataAdapter(cmdReport);
            using (cmdReport)
            {
                daReport.Fill(retVal);
            }

            DataTable lResults = retVal.Tables[0];

            foreach (DataRow lrow in lResults.Rows)
            {
                Entidades.ResultadoProcedimientos.ComisionFijaFacturacion tmp = new Entidades.ResultadoProcedimientos.ComisionFijaFacturacion();
                tmp.Compania = lrow["Compania"].ToString();
                tmp.Contrato = lrow["numeronegociopadre"].ToString();
                tmp.SubContrato = lrow["numeronegocio"].ToString();
                tmp.Documento = lrow["documento"].ToString();
                tmp.edad = Convert.ToInt32(lrow["edad"]);
                tmp.EstadoBeneficiario = lrow["EstadoBeneficiario"].ToString();
                tmp.Factura = lrow["numerofactura"].ToString();
                tmp.PlanDetalle = lrow["PlanDetalle"].ToString();
                tmp.ProductoDetalle = lrow["ProductoDetalle"].ToString();
                tmp.Clave = Convert.ToInt32(lrow["clave"]);
                tmp.TipoContrato = lrow["TipoContrato"].ToString();
                tmp.FechaFactura = Convert.ToDateTime(lrow["fechaexpedicionfactura"]);
                #region C44102 EHBV SE INCLUYE EL CAMPO PERIODO
                /// <summary>
                /// Determina el periodo de facturacion
                /// </summary>
                tmp.Periodo = Convert.ToDateTime(lrow["Periodo"]);
                #endregion C44102 EHBV SE INCLUYE EL CAMPO PERIODO
                tmp.Canal = lrow["Canal"].ToString();
                tmp.SubCanal = lrow["SubCanal"].ToString();
                tmp.TalentosNetos = Convert.ToInt32(lrow["talentosnetos"]);
                tmp.TalentosNuevos = Convert.ToInt32(lrow["talentosnuevos"]);
                tmp.IdNovedad = lrow["id_Novedad_BH"].ToString();
                tmp.Novedad = lrow["descripcionNovedad"].ToString();
                tmp.PorcentajeComisionFijaSinExcepcion = !DBNull.Value.Equals(lrow["porcentajeComisionFijaSinExcepcion"]) ? Convert.ToDecimal(lrow["porcentajeComisionFijaSinExcepcion"]) : 0;
                tmp.PorcentajeComisionFijaConExcepcion = !DBNull.Value.Equals(lrow["factor"]) ? Convert.ToDecimal(lrow["factor"]) : 0;
                tmp.ValorComisionExcepcion = !DBNull.Value.Equals(lrow["ValorComisionFijaConExcepcion"]) ? Convert.ToDecimal(lrow["ValorComisionFijaConExcepcion"]) : 0;
                tmp.PorcentajeComisionVariable = !DBNull.Value.Equals(lrow["comisionvariable"]) ? Convert.ToDecimal(lrow["comisionvariable"]) : 0;
                tmp.PorcentajeComisionTotal = Convert.ToDecimal(lrow["PorcentajeComisionTotal"]);
                tmp.PorcentajeParticipacion = !DBNull.Value.Equals(lrow["porcentajeparticipacion"]) ? Convert.ToDecimal(lrow["porcentajeparticipacion"]) : 0;tmp.ValorComisionFija = Convert.ToDecimal(lrow["ValorComisionFijaSinExcepcion"]);
                tmp.ValorComisionVariable = Convert.ToDecimal(lrow["valorcomisionvariable"]);
                tmp.TipoDocumento = lrow["tipoDocumento"].ToString().Trim();
                tmp.ValorFactura = Convert.ToDecimal(lrow["ValorFactura"]);
                tmp.ValorComisionTotal = Convert.ToDecimal(lrow["ValorComisionTotal"]);
                tmp.TipoExcepcion = lrow["TipoExcepcion"].ToString();
                
                resultados.Add(tmp);
            }
            return resultados;
        }

        internal List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion(int liquidacionComisionId)
        {
            List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> resultados = new List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos>();
            String cmdtxt = "dbo.ObtenerComisionFijaRecaudosPorLiquidacion";
            DataSet retVal = new DataSet();
            SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
            SqlCommand cmdReport = new SqlCommand(cmdtxt, sqlConn);
            cmdReport.CommandType = CommandType.StoredProcedure;
            cmdReport.CommandTimeout = 0;
            cmdReport.Parameters.Add("liquidacioncomision_id", SqlDbType.Int);
            cmdReport.Parameters["liquidacioncomision_id"].Value = liquidacionComisionId;
            SqlDataAdapter daReport = new SqlDataAdapter(cmdReport);
            using (cmdReport)
            {
                daReport.Fill(retVal);
            }

            DataTable lResults = retVal.Tables[0];

            foreach (DataRow lrow in lResults.Rows)
            {
                Entidades.ResultadoProcedimientos.ComisionFijaRecaudos tmp = new Entidades.ResultadoProcedimientos.ComisionFijaRecaudos();

                tmp.Compania = lrow["Compania"].ToString();
                tmp.Contrato = lrow["numeronegociopadre"].ToString();
                tmp.SubContrato = lrow["numeronegocio"].ToString();
                tmp.Documento = lrow["documento"].ToString();
                tmp.edad = Convert.ToInt32(lrow["edad"]);
                tmp.EstadoBeneficiario = lrow["EstadoBeneficiario"].ToString();
                tmp.Factura = lrow["numerofactura"].ToString();
                tmp.PlanDetalle = lrow["PlanDetalle"].ToString();
                tmp.ProductoDetalle = lrow["ProductoDetalle"].ToString();
                tmp.Clave = Convert.ToInt32(lrow["clave"]);
                tmp.TipoContrato = lrow["TipoContrato"].ToString();
                tmp.FechaRecaudo = Convert.ToDateTime(lrow["fecharecaudo"]);
                tmp.Canal = lrow["Canal"].ToString();
                tmp.SubCanal = lrow["SubCanal"].ToString();
                tmp.TalentosNetos = Convert.ToInt32(lrow["talentosnetos"]);
                tmp.TalentosNuevos = Convert.ToInt32(lrow["talentosnuevos"]);
                tmp.PorcentajeComisionFijaSinExcepcion = !DBNull.Value.Equals(lrow["porcentajeComisionFijaSinExcepcion"]) ? Convert.ToDecimal(lrow["porcentajeComisionFijaSinExcepcion"]) : 0;
                tmp.PorcentajeComisionFijaConExcepcion = !DBNull.Value.Equals(lrow["porcentajeComisionFijaConExcepcion"]) ? Convert.ToDecimal(lrow["porcentajeComisionFijaConExcepcion"]) : 0;
                tmp.ValorComisionVariable = Convert.ToDecimal(lrow["valorcomisionvariable"]);
                tmp.ValorComisionExcepcion = !DBNull.Value.Equals(lrow["ValorComisionFijaConExcepcion"]) ? Convert.ToDecimal(lrow["ValorComisionFijaConExcepcion"]) : 0;
                tmp.ValorComisionFija = !DBNull.Value.Equals(lrow["ValorComisionFijaSinExcepcion"]) ? Convert.ToDecimal(lrow["ValorComisionFijaSinExcepcion"]) : 0;
                tmp.PorcentajeComisionVariable = !DBNull.Value.Equals(lrow["comisionvariable"]) ? Convert.ToDecimal(lrow["comisionvariable"]) : 0;
                tmp.PorcentajeComisionTotal = Convert.ToDecimal(lrow["PorcentajeComisionTotal"]);
                tmp.PorcentajeParticipacion = !DBNull.Value.Equals(lrow["porcentajeparticipacion"]) ? Convert.ToDecimal(lrow["porcentajeparticipacion"]) : 0;
                tmp.TipoExcepcion = lrow["TipoExcepcion"].ToString().Trim();
                tmp.TipoDocumento = lrow["tipoDocumento"].ToString().Trim();
                tmp.ValorFactura = Convert.ToDecimal(lrow["distribucionrecaudoasesor"]);
                tmp.ValorComisionTotal = Convert.ToDecimal(lrow["ValorComisionTotal"]);
                tmp.FechaFactura = lrow["FechaFactura"].ToString().Trim();//C44102 EHBV 
                tmp.Periodo = lrow["Periodo"] != null ? lrow["Periodo"].ToString().Trim() : string.Empty;//C44102 EHBV 
                tmp.Concepto = lrow["TIPO_COMISION"].ToString().Trim();
                tmp.Recibo = lrow["Recibo"].ToString().Trim();
                tmp.ParticipacionUsurio = !DBNull.Value.Equals(lrow["participacionusuario"]) ? Convert.ToDecimal(lrow["participacionusuario"]) : 0;
                resultados.Add(tmp);
            }
            return resultados;
        }

        internal List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> ObtenerComisionFijaRecaudosPorLiquidacion604(int liquidacionComisionId)
        {
            List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos> resultados = new List<Entidades.ResultadoProcedimientos.ComisionFijaRecaudos>();
            String cmdtxt = "dbo.ObtenerComisionFijaRecaudosPorLiquidacionSinMarcaDePago";
            DataSet retVal = new DataSet();
            SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
            SqlCommand cmdReport = new SqlCommand(cmdtxt, sqlConn);
            cmdReport.CommandType = CommandType.StoredProcedure;
            cmdReport.CommandTimeout = 0;
            cmdReport.Parameters.Add("liquidacioncomision_id", SqlDbType.Int);
            cmdReport.Parameters["liquidacioncomision_id"].Value = liquidacionComisionId;
            SqlDataAdapter daReport = new SqlDataAdapter(cmdReport);
            using (cmdReport)
            {
                daReport.Fill(retVal);
            }

            DataTable lResults = retVal.Tables[0];

            foreach (DataRow lrow in lResults.Rows)
            {
                Entidades.ResultadoProcedimientos.ComisionFijaRecaudos tmp = new Entidades.ResultadoProcedimientos.ComisionFijaRecaudos();

                tmp.Compania = lrow["Compania"].ToString();
                tmp.Contrato = lrow["numeronegociopadre"].ToString();
                tmp.SubContrato = lrow["numeronegocio"].ToString();
                tmp.Documento = lrow["documento"].ToString();
                tmp.edad = Convert.ToInt32(lrow["edad"]);
                tmp.EstadoBeneficiario = lrow["EstadoBeneficiario"].ToString();
                tmp.Factura = lrow["numerofactura"].ToString();
                tmp.PlanDetalle = lrow["PlanDetalle"].ToString();
                tmp.ProductoDetalle = lrow["ProductoDetalle"].ToString();
                tmp.Clave = Convert.ToInt32(lrow["clave"]);
                tmp.TipoContrato = lrow["TipoContrato"].ToString();
                tmp.FechaRecaudo = Convert.ToDateTime(lrow["fecharecaudo"]);
                tmp.Canal = lrow["Canal"].ToString();
                tmp.SubCanal = lrow["SubCanal"].ToString();
                tmp.TalentosNetos = Convert.ToInt32(lrow["talentosnetos"]);
                tmp.TalentosNuevos = Convert.ToInt32(lrow["talentosnuevos"]);
                tmp.PorcentajeComisionFijaSinExcepcion = !DBNull.Value.Equals(lrow["porcentajeComisionFijaSinExcepcion"]) ? Convert.ToDecimal(lrow["porcentajeComisionFijaSinExcepcion"]) : 0;
                tmp.PorcentajeComisionFijaConExcepcion = !DBNull.Value.Equals(lrow["porcentajeComisionFijaConExcepcion"]) ? Convert.ToDecimal(lrow["porcentajeComisionFijaConExcepcion"]) : 0;
                tmp.ValorComisionVariable = Convert.ToDecimal(lrow["valorcomisionvariable"]);
                tmp.ValorComisionExcepcion = !DBNull.Value.Equals(lrow["ValorComisionFijaConExcepcion"]) ? Convert.ToDecimal(lrow["ValorComisionFijaConExcepcion"]) : 0;
                tmp.ValorComisionFija = !DBNull.Value.Equals(lrow["ValorComisionFijaSinExcepcion"]) ? Convert.ToDecimal(lrow["ValorComisionFijaSinExcepcion"]) : 0;
                tmp.PorcentajeComisionVariable = !DBNull.Value.Equals(lrow["comisionvariable"]) ? Convert.ToDecimal(lrow["comisionvariable"]) : 0;
                tmp.PorcentajeComisionTotal = Convert.ToDecimal(lrow["PorcentajeComisionTotal"]);
                tmp.PorcentajeParticipacion = !DBNull.Value.Equals(lrow["porcentajeparticipacion"]) ? Convert.ToDecimal(lrow["porcentajeparticipacion"]) : 0;
                tmp.TipoExcepcion = lrow["TipoExcepcion"].ToString().Trim();
                tmp.TipoDocumento = lrow["tipoDocumento"].ToString().Trim();
                tmp.ValorFactura = Convert.ToDecimal(lrow["distribucionrecaudoasesor"]);
                tmp.ValorComisionTotal = Convert.ToDecimal(lrow["ValorComisionTotal"]);
                tmp.FechaFactura = lrow["FechaFactura"].ToString().Trim();//C44102 EHBV 
                tmp.Periodo = lrow["Periodo"] != null ? lrow["Periodo"].ToString().Trim() : string.Empty;//C44102 EHBV 
                tmp.Concepto = lrow["TIPO_COMISION"].ToString().Trim();
                tmp.Recibo = lrow["Recibo"].ToString().Trim();
                tmp.ParticipacionUsurio = !DBNull.Value.Equals(lrow["participacionusuario"]) ? Convert.ToDecimal(lrow["participacionusuario"]) : 0;
                resultados.Add(tmp);
            }
            return resultados;
        }

        internal ResultadoOperacionBD PreCalcularComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId, byte tipoLiquidacionId)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();
            try
            {
                String cmdtxt = "dbo.PreCalcularComisionSegunModelo";
                SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
                SqlCommand cmdReport = new SqlCommand(cmdtxt, sqlConn);
                cmdReport.CommandType = CommandType.StoredProcedure;
                cmdReport.Parameters.Add("modelo_id", SqlDbType.Int);
                cmdReport.Parameters["modelo_id"].Value = modeloId;
                cmdReport.Parameters.Add("anio", SqlDbType.SmallInt);
                cmdReport.Parameters["anio"].Value = anio;
                cmdReport.Parameters.Add("mes", SqlDbType.TinyInt);
                cmdReport.Parameters["mes"].Value = mes;
                cmdReport.Parameters.Add("liquidacioncomision_id", SqlDbType.Int);
                cmdReport.Parameters["liquidacioncomision_id"].Value = liquidacionComisionId;
                cmdReport.Parameters.Add("tipoliquidacion_id", SqlDbType.TinyInt);
                cmdReport.Parameters["tipoliquidacion_id"].Value = tipoLiquidacionId;
                using (sqlConn)
                {
                    cmdReport.Connection.Open();
                    res.RegistrosAfectados = cmdReport.ExecuteNonQuery();
                    cmdReport.Connection.Close();
                }
                res.Resultado = ResultadoOperacion.Exito;
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            return res;
        }
        #endregion

        #region Liquidacion Comision
        internal ResultadoOperacionBD LiquidarComisionSegunModelo(int modeloId, short anio, byte mes, int liquidacionComisionId)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();
            try
            {
                String cmdtxt = "dbo.LiquidarComision";
                SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
                SqlCommand cmdReport = new SqlCommand(cmdtxt, sqlConn);
                cmdReport.CommandType = CommandType.StoredProcedure;
                cmdReport.Parameters.Add("modelo_id", SqlDbType.Int);
                cmdReport.Parameters["modelo_id"].Value = modeloId;
                cmdReport.Parameters.Add("anio", SqlDbType.SmallInt);
                cmdReport.Parameters["anio"].Value = anio;
                cmdReport.Parameters.Add("mes", SqlDbType.TinyInt);
                cmdReport.Parameters["mes"].Value = mes;
                cmdReport.Parameters.Add("liquidacioncomision_id", SqlDbType.Int);
                cmdReport.Parameters["liquidacioncomision_id"].Value = liquidacionComisionId;
                using (sqlConn)
                {
                    cmdReport.Connection.Open();
                    res.RegistrosAfectados = cmdReport.ExecuteNonQuery();
                    cmdReport.Connection.Close();
                }
                res.Resultado = ResultadoOperacion.Exito;
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            return res;
        }

        internal List<LiquidacionComision> ObtenerHistoricoLiquidaciones()
        {
            //int paginaActual = 2; // Cambia esto al número de página que desees
            //int elementosPorPagina = 10; // Cambia esto al número de elementos por página que desees

            return _dbcontext.LiquidacionComisions.Include("ModeloComision")
                .Include("EstadoLiquidacion")
                .Where(x=>x.estadoliquidacion_id != 3)
                //.OrderByDescending(x => x.fecha)
                //.Skip((paginaActual - 1) * elementosPorPagina)
                //.Take(elementosPorPagina)
                .ToList();
        }
        #endregion

        #endregion

        #region levantamiento ETL CF y CV
        /// <summary>
        /// Este metodo ejecuta la ETL de Extraccion CF para tipo ejec 1 y si el tipo de ejec es 2
        /// ejecuta etl de extraccion CV y despeus de levantar las ETL ejecuta SP PreCalcularComisionSegunModelo
        /// </summary>
        /// <param name="parmEtl">Parametros para levantar la ETL</param>
        /// <param name="modeloId"></param>
        /// <param name="anio"></param>
        /// <param name="mes"></param>
        /// <param name="liquidacionComisionId"></param>
        /// <param name="tipoLiquidacionId"></param>
        /// <param name="usuario"></param>
        /// <param name="tipoEjec">1- Ejecuta ETL CF. 2- Ejecuta ETL CF y ETL CV </param>
        /// <returns></returns>
        internal ResultadoOperacionBD ExtractCf_CV(string parmEtlCF, string parmEtlCV, int modeloId, short anio, byte mes,
            int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();
            string rta01 = String.Empty;
            int idliquidacion = 0;
            int rta02 = 0;
            string rta03 = String.Empty;
            int rta04 = 0;
            #region PASO 01 - Parametros Comsión Fija
            try
            {
                String cmdtxt = "dbo.SAI_ExtraccionCFyCV_Paso01";
                SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
                SqlConnection sqlConn2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["IntegrationServer"].ConnectionString);
                SqlCommand cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                cmdReport1.CommandType = CommandType.StoredProcedure;

                cmdReport1.Parameters.Add("parametrosEtlCF", SqlDbType.VarChar);
                cmdReport1.Parameters["parametrosEtlCF"].Value = parmEtlCF;

                cmdReport1.Parameters.Add("emodelo_id", SqlDbType.Int);
                cmdReport1.Parameters["emodelo_id"].Value = modeloId;

                cmdReport1.Parameters.Add("eanio", SqlDbType.SmallInt);
                cmdReport1.Parameters["eanio"].Value = anio;

                cmdReport1.Parameters.Add("emes", SqlDbType.TinyInt);
                cmdReport1.Parameters["emes"].Value = mes;

                cmdReport1.Parameters.Add("etipoliquidacion_id", SqlDbType.TinyInt);
                cmdReport1.Parameters["etipoliquidacion_id"].Value = tipoLiquidacionId;

                cmdReport1.Parameters.Add("eusuario", SqlDbType.VarChar);
                cmdReport1.Parameters["eusuario"].Value = usuario;

                cmdReport1.Parameters.Add("ComandoSO", SqlDbType.NVarChar, 1000);
                cmdReport1.Parameters["ComandoSO"].Direction = ParameterDirection.Output;

                cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                cmdReport1.Parameters["idLiquidacion"].Direction = ParameterDirection.Output;

                using (sqlConn)
                using (sqlConn2)
                {
                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    cmdReport1.Connection.Open();
                    var rta = cmdReport1.ExecuteNonQuery();
                    rta01 = cmdReport1.Parameters["ComandoSO"].Value.ToString();
                    idliquidacion = int.Parse(cmdReport1.Parameters["idLiquidacion"].Value.ToString());
                    res.Resultado = ResultadoOperacion.Exito;
            
            #endregion
            #region PASO 02 - Ejecución ETL Comisión Fija
            
                cmdtxt = "dbo.EjecutarInstruccionSO";                
                SqlCommand cmdReport2 = new SqlCommand(cmdtxt, sqlConn2);
                cmdReport2.CommandType = CommandType.StoredProcedure;

                cmdReport2.Parameters.Add("ejec", SqlDbType.VarChar);
                cmdReport2.Parameters["ejec"].Value = rta01;

                cmdReport2.Parameters.Add("respuesta", SqlDbType.Int);
                cmdReport2.Parameters["respuesta"].Direction = ParameterDirection.Output;
               
                    cmdReport2.CommandTimeout = 0;//Timeout infinito
                    cmdReport2.Connection.Open();
                    rta = cmdReport2.ExecuteNonQuery();
                    rta02 = int.Parse(cmdReport2.Parameters["respuesta"].Value.ToString());
                
                res.Resultado = ResultadoOperacion.Exito;
            
            #endregion 
            #region PASO 03 - Parametros Comsión Variable
            
                cmdtxt = "dbo.SAI_ExtraccionCFyCV_Paso02";
                cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                cmdReport1.CommandType = CommandType.StoredProcedure;

                cmdReport1.Parameters.Add("respuesta", SqlDbType.Int);
                cmdReport1.Parameters["respuesta"].Value = rta02;

                cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                cmdReport1.Parameters["idLiquidacion"].Value = idliquidacion;

                cmdReport1.Parameters.Add("tipoEjec", SqlDbType.TinyInt);
                cmdReport1.Parameters["tipoEjec"].Value = tipoEjec;

                cmdReport1.Parameters.Add("parametrosEtlCV", SqlDbType.VarChar);
                cmdReport1.Parameters["parametrosEtlCV"].Value = parmEtlCV;

                cmdReport1.Parameters.Add("ComandoSO", SqlDbType.NVarChar, 1000);
                cmdReport1.Parameters["ComandoSO"].Direction = ParameterDirection.Output;

                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    rta = cmdReport1.ExecuteNonQuery();
                    rta03 = cmdReport1.Parameters["ComandoSO"].Value.ToString();
                
                res.Resultado = ResultadoOperacion.Exito;
            
            #endregion
            #region PASO 04 - Ejecución ETL Comisión Variable
            if (!String.IsNullOrWhiteSpace(rta03))
            {                
                    cmdtxt = "dbo.EjecutarInstruccionSO";
                    cmdReport2 = new SqlCommand(cmdtxt, sqlConn2);
                    cmdReport2.CommandType = CommandType.StoredProcedure;

                    cmdReport2.Parameters.Add("ejec", SqlDbType.VarChar);
                    cmdReport2.Parameters["ejec"].Value = rta03;

                    cmdReport2.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport2.Parameters["respuesta"].Direction = ParameterDirection.Output;

                        cmdReport2.CommandTimeout = 0;//Timeout infinito
                        rta = cmdReport2.ExecuteNonQuery();
                        rta04 = int.Parse(cmdReport2.Parameters["respuesta"].Value.ToString());
                        cmdReport2.Connection.Close();
                    
                    res.Resultado = ResultadoOperacion.Exito;
                
            }
            #endregion
            #region PASO 05 - Calculo Comisión
            
                cmdtxt = "dbo.SAI_ExtraccionCFyCV_Paso03";
                cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                cmdReport1.CommandType = CommandType.StoredProcedure;

                cmdReport1.Parameters.Add("respuesta", SqlDbType.Int);
                cmdReport1.Parameters["respuesta"].Value = rta04;

                cmdReport1.Parameters.Add("emodelo_id", SqlDbType.Int);
                cmdReport1.Parameters["emodelo_id"].Value = modeloId;

                cmdReport1.Parameters.Add("eanio", SqlDbType.SmallInt);
                cmdReport1.Parameters["eanio"].Value = anio;

                cmdReport1.Parameters.Add("emes", SqlDbType.TinyInt);
                cmdReport1.Parameters["emes"].Value = mes;

                cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                cmdReport1.Parameters["idLiquidacion"].Value = idliquidacion;

                cmdReport1.Parameters.Add("etipoliquidacion_id", SqlDbType.TinyInt);
                cmdReport1.Parameters["etipoliquidacion_id"].Value = tipoLiquidacionId;

                cmdReport1.Parameters.Add("tipoEjec", SqlDbType.TinyInt);
                cmdReport1.Parameters["tipoEjec"].Value = tipoEjec;

                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    rta = cmdReport1.ExecuteNonQuery();
                    cmdReport1.Connection.Close();
                }
                res.Resultado = ResultadoOperacion.Exito;
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            #endregion
            return res;
        }

        internal List<int> ValLiqPendientes()
        {
            List<int> filtEnProceso = new List<int>();
            try
            {
                filtEnProceso = (from dd in _dbcontext.LiquidacionComisions
                                 where dd.estadoliquidacion_id == 4 //Generando a través de ETL
                                 select dd.id).ToList();
            }
            catch (Exception)
            {
                return null;
            }
            LiquidacionComision abc = new LiquidacionComision();


            return filtEnProceso;
        }

        /// <summary>
        /// Obtiene un periodo  de calculo de comisiòn basado en un año y me epsecifico
        /// </summary>
        /// <param name="anio"></param>
        /// <param name="mes"></param>
        /// <returns></returns>
        internal List<string[]> obtenerPeriodoCalcComision(int anio, int mes)
        {
            List<string[]> filtPeriodos = new List<string[]>();
            try
            {
                StringBuilder lSentencia = new StringBuilder();
                lSentencia.Append(" SELECT TOP 1 [id],[fechainicio],[fechafin]");
                lSentencia.Append(" FROM [SAI].[dbo].[PeriodoCalculoComision]");
                lSentencia.Append(" where fechafin >= CAST('" + anio + "-" + mes + "-01' as datetime) and fechafin< DATEADD(MONTH,1,CAST('" + anio + "-" + mes + "-01' as datetime))");
                
                DataSet retVal = new DataSet();
                EntityConnection entityConn = (EntityConnection)_dbcontext.Connection;
                SqlConnection sqlConn = (SqlConnection)entityConn.StoreConnection;
                SqlCommand cmdReport = new SqlCommand(lSentencia.ToString(), sqlConn);
                SqlDataAdapter daReport = new SqlDataAdapter(cmdReport);
                using (cmdReport)
                {
                    daReport.Fill(retVal);
                }

                filtPeriodos = (from item in retVal.Tables[0].AsEnumerable()
                                    select new string[] { item["id"].ToString(), item["fechainicio"].ToString(), item["fechafin"].ToString() }).ToList();


            }
            catch (Exception)
            {
                return null;
            }



            return filtPeriodos;
        }
        #endregion

        #region Pago - Levantamiento ETL GP y BH
        /// <summary>
        /// Ejecuta el sp LiquidacionComision, levanta la etl de envío a GP y  BH
        /// </summary>
        /// <param name="liquidacionComisionId"></param>
        /// <returns></returns>
        internal ResultadoOperacionBD LiquidarComisiones(int liquidacionComisionId)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();
            string rta01 = String.Empty;
            int idliquidacion = liquidacionComisionId;
            int rta02 = 0;
            string rta03 = String.Empty;
            int rta04 = 0;

            try
            {
                SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
                SqlConnection sqlConn2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["IntegrationServer"].ConnectionString);

                using (sqlConn)
                using (sqlConn2)
                {
                    #region PASO 01 - Cálculo Liquidación y Parámetros ETL GP
                    String cmdtxt = "dbo.SAI_LevantarEtlGpyBH_Paso001";
                    SqlCommand cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                    cmdReport1.CommandType = CommandType.StoredProcedure;

                    cmdReport1.Parameters.Add("@idLiquidacion", SqlDbType.Int);
                    cmdReport1.Parameters["@idLiquidacion"].Value = liquidacionComisionId;

                    cmdReport1.Parameters.Add("ComandoSO", SqlDbType.NVarChar, 1000);
                    cmdReport1.Parameters["ComandoSO"].Direction = ParameterDirection.Output;
                    
                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    cmdReport1.Connection.Open();
                    var rta = cmdReport1.ExecuteNonQuery();
                    rta01 = cmdReport1.Parameters["ComandoSO"].Value.ToString();
                    res.Resultado = ResultadoOperacion.Exito;
                    #endregion

                    #region PASO 02 - Ejecución ETL GP
                    cmdtxt = "dbo.EjecutarInstruccionSO";
                    SqlCommand cmdReport2 = new SqlCommand(cmdtxt, sqlConn2);
                    cmdReport2.CommandType = CommandType.StoredProcedure;

                    cmdReport2.Parameters.Add("ejec", SqlDbType.VarChar);
                    cmdReport2.Parameters["ejec"].Value = rta01;

                    cmdReport2.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport2.Parameters["respuesta"].Direction = ParameterDirection.Output;

                    cmdReport2.CommandTimeout = 0;//Timeout infinito
                    cmdReport2.Connection.Open();
                    rta = cmdReport2.ExecuteNonQuery();
                    rta02 = int.Parse(cmdReport2.Parameters["respuesta"].Value.ToString());

                    res.Resultado = ResultadoOperacion.Exito;
                    #endregion

                    #region PASO 03 - Parámetros ETL BH
                    cmdtxt = "dbo.SAI_LevantarEtlGpyBH_Paso002";
                    cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                    cmdReport1.CommandType = CommandType.StoredProcedure;

                    cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                    cmdReport1.Parameters["idLiquidacion"].Value = liquidacionComisionId;

                    cmdReport1.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport1.Parameters["respuesta"].Value = rta02;
                    
                    cmdReport1.Parameters.Add("ComandoSO", SqlDbType.NVarChar, 1000);
                    cmdReport1.Parameters["ComandoSO"].Direction = ParameterDirection.Output;

                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    rta = cmdReport1.ExecuteNonQuery();
                    rta03 = cmdReport1.Parameters["ComandoSO"].Value.ToString();

                    res.Resultado = ResultadoOperacion.Exito;
                    #endregion

                    #region PASO 04 - Ejecución ETL BH
                    cmdtxt = "dbo.EjecutarInstruccionSO";
                    cmdReport2 = new SqlCommand(cmdtxt, sqlConn2);
                    cmdReport2.CommandType = CommandType.StoredProcedure;

                    cmdReport2.Parameters.Add("ejec", SqlDbType.VarChar);
                    cmdReport2.Parameters["ejec"].Value = rta03;

                    cmdReport2.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport2.Parameters["respuesta"].Direction = ParameterDirection.Output;

                    cmdReport2.CommandTimeout = 0;//Timeout infinito
                    rta = cmdReport2.ExecuteNonQuery();
                    rta04 = int.Parse(cmdReport2.Parameters["respuesta"].Value.ToString());
                    cmdReport2.Connection.Close();

                    res.Resultado = ResultadoOperacion.Exito;
                    #endregion

                    #region PASO 05 - Finalización del proceso de Pago
                    cmdtxt = "dbo.SAI_LevantarEtlGpyBH_Paso003";
                    cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                    cmdReport1.CommandType = CommandType.StoredProcedure;

                    cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                    cmdReport1.Parameters["idLiquidacion"].Value = liquidacionComisionId;

                    cmdReport1.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport1.Parameters["respuesta"].Value = rta04;                    

                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    rta = cmdReport1.ExecuteNonQuery();
                    cmdReport1.Connection.Close();
                    res.Resultado = ResultadoOperacion.Exito;
                    #endregion
                }
                res.Resultado = ResultadoOperacion.Exito;                    
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            return res;
        }

        #endregion


        #region Anular y Reprocesar Liquidacion

        public bool ValidaAnularLiquidacion(int idLiquidacion)
        {

            string sentencia = "select estadoliquidacion_id from LiquidacionComision where id=" + idLiquidacion;

            EntityConnection entityConn = (EntityConnection)_dbcontext.Connection;
            SqlConnection sqlConn = (SqlConnection)entityConn.StoreConnection;
            SqlCommand cmdReport = new SqlCommand(sentencia.ToString(), sqlConn);
            cmdReport.CommandType = CommandType.Text;

            SqlDataAdapter dacons = new SqlDataAdapter(cmdReport);
            DataSet dtconsulta = new DataSet();

            dacons.Fill(dtconsulta);
            sqlConn.Close();
            int estado_liq;
            bool resp = true;

            if (dtconsulta.Tables[0].Rows.Count > 0)
            {

                DataRow lRowLiquidacionComision = dtconsulta.Tables[0].Rows[0];
                estado_liq = Convert.ToInt32(lRowLiquidacionComision["estadoliquidacion_id"].ToString());

                if (estado_liq != 1)
                {
                    resp = false;
                }
                else
                {
                    resp = true;
                }
            }


            return resp;

        }

        internal ResultadoOperacionBD ExtractAnulacion(string ParametrosEtl, int idLiquidacion)
        {
            string rta01 = String.Empty;
            int rta02 = 0;
            ResultadoOperacionBD res = new ResultadoOperacionBD();
          
            try
            {
                #region PASO 01 - Parametros Etl Anular
                String cmdtxt = "dbo.SAI_Anular";
                SqlConnection sqlConn = (SqlConnection)((EntityConnection)_dbcontext.Connection).StoreConnection;
                SqlConnection sqlConn2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["IntegrationServer"].ConnectionString);
                SqlCommand cmdReport1 = new SqlCommand(cmdtxt, sqlConn);
                cmdReport1.CommandType = CommandType.StoredProcedure;

                cmdReport1.Parameters.Add("parametrosEtlAnular", SqlDbType.VarChar);
                cmdReport1.Parameters["parametrosEtlAnular"].Value = ParametrosEtl;

                cmdReport1.Parameters.Add("idLiquidacion", SqlDbType.Int);
                cmdReport1.Parameters["idLiquidacion"].Value = idLiquidacion;
                                
                cmdReport1.Parameters.Add("ComandoSO", SqlDbType.NVarChar, 1000);
                cmdReport1.Parameters["ComandoSO"].Direction = ParameterDirection.Output;

            
                using (sqlConn)
                using (sqlConn2)
                {

                    cmdReport1.CommandTimeout = 0;//Timeout infinito
                    cmdReport1.Connection.Open();
                    var rta = cmdReport1.ExecuteNonQuery();
                    rta01 = cmdReport1.Parameters["ComandoSO"].Value.ToString();
                    res.Resultado = ResultadoOperacion.Exito;

                #endregion
               #region PASO 02 - Ejecución ETL Anular

                    cmdtxt = "dbo.EjecutarInstruccionSO";
                    SqlCommand cmdReport2 = new SqlCommand(cmdtxt, sqlConn2);
                    cmdReport2.CommandType = CommandType.StoredProcedure;

                    cmdReport2.Parameters.Add("ejec", SqlDbType.VarChar);
                    cmdReport2.Parameters["ejec"].Value = rta01;

                    cmdReport2.Parameters.Add("respuesta", SqlDbType.Int);
                    cmdReport2.Parameters["respuesta"].Direction = ParameterDirection.Output;

                    cmdReport2.CommandTimeout = 0;//Timeout infinito
                    cmdReport2.Connection.Open();
                    rta = cmdReport2.ExecuteNonQuery();
                    rta02 = int.Parse(cmdReport2.Parameters["respuesta"].Value.ToString());

                    res.Resultado = ResultadoOperacion.Exito;

               #endregion
                }
                res.Resultado = ResultadoOperacion.Exito;
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            return res;

        }

        #endregion

        # region reprocesar liquidacion

        internal ResultadoOperacionBD ReprocesarLiquidacion(string parmEtlCF, string parmEtlCV,string paramEtlAnulacion, int modeloId, short anio, byte mes,
            int liquidacionComisionId, byte tipoLiquidacionId, string usuario, int tipoEjec)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();

            try
            {
                res = ExtractAnulacion(paramEtlAnulacion, liquidacionComisionId);
                res = ExtractCf_CV(parmEtlCF, parmEtlCV, modeloId, anio, mes, liquidacionComisionId, tipoLiquidacionId, usuario, tipoEjec);
            }
            catch (Exception ex)
            {
                res.RegistrosAfectados = 0;
                res.MensajeError = "Error: " + ex.Message;
                res.Resultado = ResultadoOperacion.Error;
            }
            


            return res;
        
        }

        internal ResultadoOperacionBD ActualizaEstadoReprocesar(int idLiquidacion)
        {
            ResultadoOperacionBD res = new ResultadoOperacionBD();
          
            string sentencia = "update LiquidacionComision set estadoliquidacion_id=5 where id=" + idLiquidacion+"";
            EntityConnection entityConn = (EntityConnection)_dbcontext.Connection;
            SqlConnection sqlConn = (SqlConnection)entityConn.StoreConnection;
            SqlCommand cmdReport = new SqlCommand(sentencia.ToString(), sqlConn);
            cmdReport.CommandType = CommandType.Text;

            cmdReport.CommandTimeout = 0;

            cmdReport.Connection.Open();
            var rta = cmdReport.ExecuteNonQuery();
            cmdReport.Connection.Close();

            res.Resultado = ResultadoOperacion.Exito;
            return res;
        }

        //public  ResultadoOperacionBD ReprocesarLiquidacionMAC(int idLiquidacion)
        //{
        //    ResultadoOperacionBD res = new ResultadoOperacionBD();

        //    string sentencia = "EXEC ReprocesarLiquidacionMAC_LOG '" + idLiquidacion + "'," + 0 + "";
        //    EntityConnection entityConn = (EntityConnection)_dbcontext.Connection;
        //    SqlConnection sqlConn = (SqlConnection)entityConn.StoreConnection;
        //    SqlCommand cmdReport = new SqlCommand(sentencia.ToString(), sqlConn);
        //    cmdReport.CommandType = CommandType.Text;

        //    cmdReport.CommandTimeout = 0;

        //    cmdReport.Connection.Open();
        //    var rta = cmdReport.ExecuteNonQuery();

        //    cmdReport.Connection.Close();

        //    res.Resultado = ResultadoOperacion.Exito;
        //    return res;
        //}

        internal List<int> ValReprocesoLiq()
        {
            List<int> filtEnProceso = new List<int>();
            try
            {
                filtEnProceso = (from dd in _dbcontext.LiquidacionComisions
                                 where dd.estadoliquidacion_id == 5 //Reprocesando a través de ETL
                                 select dd.id).ToList();
            }
            catch (Exception)
            {
                return null;
            }
            LiquidacionComision abc = new LiquidacionComision();


            return filtEnProceso;
        }
       
        #endregion

    }
}
