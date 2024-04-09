using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ColpatriaSAI.UI.MVC.Areas.Comisiones.Models.ViewModels;
using Entidades = ColpatriaSAI.Negocio.Entidades;
using System.IO;
using System.ComponentModel;
using ColpatriaSAI.Negocio.Entidades.ResultadoProcedimientos;
using System.Threading.Tasks;
using System.Web.Mvc.Async;
using System.Text;
using System.Threading;
using System.Globalization;
using admin = ColpatriaSAI.Negocio.Componentes.Comision.Administracion;

namespace ColpatriaSAI.UI.MVC.Areas.Comisiones.Controllers
{
    public class CalculoComisionController : ColpatriaSAI.UI.MVC.Controllers.ControladorBase
    {
        private ModeloComisionSVC.ModeloComisionClient _svcModelClient;
        private ComisionesSVC.ComisionesClient _svcComisionesClient;
        private CalculosTalentosComision.CalculosClient _svcCalculosClient;
        [Authorize]
        public ActionResult Historico()
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();


            List<int> factReproceso = _svcCalculosClient.ValReprocesoLiq().ToList();
            if (factReproceso != null && factReproceso.Count > 0)
                TempData["FACT_REP"] = "S";
            else
                TempData["FACT_REP"] = "N";

            return View(_svcCalculosClient.ObtenerHistoricoLiquidaciones());

            //Se valida que no hayan REPROCESO generandose en segudo plano
           
          
        }

        [Authorize]
        public ActionResult CalculoComision(int? IdLiquidacion)
        {
            CalculoComisionViewModel vmmodel = new CalculoComisionViewModel();
            _svcModelClient = new ModeloComisionSVC.ModeloComisionClient();
            if (IdLiquidacion.HasValue)
            {
                vmmodel.IdLiquidacion = IdLiquidacion;
            }
            vmmodel.Modelos.AddRange(_svcModelClient.ListarModeloComisionVigentes()
                .Select(x => new SelectListItem()
                {
                    Value = x.id.ToString(),
                    Text = x.nombre
                }));


            //Se valida que no hayan facutras generandose en segudo plano
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
            List<int> factGenerandose = _svcCalculosClient.ValLiqPendientes().ToList();
            if (factGenerandose != null && factGenerandose.Count > 0)
                TempData["FACT_PEND"] = "S";
            else
                TempData["FACT_PEND"] = "N";


        


           
            return View(vmmodel);
        }

        [Authorize, HttpPost]
        public ActionResult CalculoComision(CalculoComisionViewModel vmmodel)
        {

            if (ModelState.IsValid)
            {
                try
                {
                    _svcComisionesClient = new ComisionesSVC.ComisionesClient();

                    string username = string.Empty;
                    if (HttpContext.Session["userName"] != null)
                        username = HttpContext.Session["userName"].ToString();

                    _svcCalculosClient = new CalculosTalentosComision.CalculosClient();

                    var strres = _svcCalculosClient.ProcesoExtraccionBeneficiarioFacturacionRecaudos("20160923SEDTR", 2016, 9);

                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = "Error no controlado:" + ex.Message;
                    TempData["OperationSuccess"] = false;
                }
            }
            else
            {
                TempData["ErrorMessage"] = "Datos inválidos";
                TempData["OperationSuccess"] = false;
            }
            return RedirectToAction("Historico", new { area = "Comisiones", controller = "CalculoComision" });
        }


        [Authorize, HttpPost]
        public ActionResult LiquidarComision(FormCollection form)
        {
            int modeloId = Convert.ToInt32(form["ModeloId"]);
            short anio = Convert.ToInt16(form["Anio"]);
            byte mes = Convert.ToByte(form["Mes"]);
            int liquidacionComisionId = Convert.ToInt32(form["LiquidacionComisionId"]);
            try
            {
                _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
                var res = _svcCalculosClient.LiquidarComisionSegunModelo(modeloId, anio, mes, liquidacionComisionId);
                if (res.Resultado == Negocio.Componentes.Comision.ResultadoOperacion.Exito)
                {
                    TempData["OperationSuccess"] = true;
                    TempData["SuccessMessage"] = "Liquidación completada correctamente.";
                }
                else
                {
                    TempData["OperationSuccess"] = false;
                    TempData["ErrorMessage"] = res.MensajeError;
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error no controlado:" + ex.Message;
                TempData["OperationSuccess"] = false;
            }
            return RedirectToAction("CalculoComision");
        }

        [Authorize]
        public ActionResult PreVisualizarFacturacion(int idLiquidacion)
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
            ExportResultListFromTsv(_svcCalculosClient.ObtenerComisionFijaFacturacionPorLiquidacion(idLiquidacion), "Liquidacion Reserva");
            return RedirectToAction("CalculoComision", new { IdLiquidacion = idLiquidacion });
        }

        [Authorize]
        public ActionResult PreVisualizarRecaudos604(int idLiquidacion)
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
            ExportResultListFromTsv(_svcCalculosClient.ObtenerComisionFijaRecaudosPorLiquidacion604(idLiquidacion), "604");
            return RedirectToAction("CalculoComision", new { IdLiquidacion = idLiquidacion });
        }

        [Authorize]
        public ActionResult PreVisualizarRecaudos(int idLiquidacion)
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
            ExportResultListFromTsv(_svcCalculosClient.ObtenerComisionFijaRecaudosPorLiquidacion(idLiquidacion), "Liquidacion Comision");
            return RedirectToAction("CalculoComision", new { IdLiquidacion = idLiquidacion });
        }
        public void WriteTsv<T>(IEnumerable<T> data, TextWriter output)
        {
            PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));
            foreach (PropertyDescriptor prop in props)
            {
                output.Write(prop.DisplayName); // header
                output.Write("\t");
            }
            output.WriteLine();
            foreach (T item in data)
            {
                foreach (PropertyDescriptor prop in props)
                {
                    output.Write(prop.Converter.ConvertToString(
                         prop.GetValue(item)));
                    output.Write("\t");
                }
                output.WriteLine();
            }
        }
        public void ExportResultListFromTsv(ComisionFijaFacturacion[] data, string filename)
        {

            //var forzarcultura = CultureInfo.CurrentCulture.Clone();
            //forzarcultura = NumberFormatInfo.CurrentInfo.NumberDecimalSeparator = ".";
            //forzarcultura = NumberFormatInfo.CurrentInfo.NumberGroupSeparator = ",";


            //NumberFormatInfo localformat = (NumberFormatInfo)NumberFormatInfo.CurrentInfo.Clone();
            //localformat.CurrencyDecimalSeparator = ".";
            //localformat.CurrencyGroupSeparator = ",";

            //CultureInfo.CurrentCulture.NumberFormat = localformat;

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".csv");
            Response.AddHeader("Content-Type", "application/vnd.ms-excel");

            //CultureInfo culformat = new CultureInfo("es-ES");
            //
            //culformat.NumberFormat.CurrencyDecimalSeparator = ".";
            //culformat.NumberFormat.NumberDecimalSeparator = ".";
            //culformat.NumberFormat.CurrencyGroupSeparator = ",";
            //Thread.CurrentThread.CurrentCulture = culformat;

            WriteTsv(data, Response.Output);
            Response.End();
        }
        public void ExportResultListFromTsv(ComisionFijaRecaudos[] data, string filename)
        {

                 
                             
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".csv");
            //Response.ContentType = "application/ms-excel";
            Response.AddHeader("Content-Type", "application/vnd.ms-excel");

            //CultureInfo culformat = new CultureInfo("es-ES");
            ////Thread.CurrentThread.CurrentCulture = culformat;
            //
            //culformat.NumberFormat.NumberDecimalSeparator = ".";
            //culformat.NumberFormat.NumberGroupSeparator = ",";
            //culformat.NumberFormat.CurrencyDecimalSeparator = ".";
            //culformat.NumberFormat.CurrencyGroupSeparator = ",";
            //Thread.CurrentThread.CurrentCulture = culformat;

            WriteTsv(data, Response.Output);
            Response.End();
        }


  
        public  bool ValidaEliminacionLiquidacion(int idliquidacion)
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
             
            
            return _svcCalculosClient.ValidaAnularLiquidacion(idliquidacion);

        }
    }

    public class AsyncCalculoComisionController : AsyncController
    {

        private CalculosTalentosComision.CalculosClient _svcCalculosClient;


        public ActionResult levantarEtl(string anio, string mes, string dia, string tipoLiqId, string modeloId)
        {
            try
            {
              string miLog="1>Fecha Ejecucion "+ DateTime.Now.ToString();  
                AsyncManager.OutstandingOperations.Increment();
                miLog+=" 2>";
                string username = string.Empty;
                if (HttpContext.Session["userName"] != null)
                {    
                    miLog+=" 3>";
                    username = HttpContext.Session["userName"].ToString();
                    miLog+=" 4> Username: " + username;
                }
               
                miLog+=" 5>";
                var task1 = Task<int>.Factory.StartNew(() =>
                {

                  //  miLog+=" 6> " + anio +"-"+ mes +"-"+ tipoLiqId +"-"+ modeloId +"-"+ username ;
                  return calculoComision(anio,mes,dia, tipoLiqId, modeloId, username);
                   
                });
                miLog += " 7> ";

                task1.ContinueWith(t =>
                {
                    miLog += " 8> ";
                    AsyncManager.OutstandingOperations.Decrement();
                });

                miLog += " 9> ";

                //creo el log
                StreamWriter log;
               string ruta = @"E:\SAI\";
                
                if (System.IO.File.Exists(ruta + "logCalculoComision.txt"))
                {
                    log = new StreamWriter(ruta + "logCalculoComision.txt");
                }
                else
                {
                    log = System.IO.File.AppendText(ruta + "logCalculoComision.txt");
                }
             
                log.WriteLine(miLog);
                log.Close();

            }
            catch (Exception ex )
            {
                string ruta = @"E:\SAI\";
               // string ruta = @"C:\SAI\";
                StreamWriter log;

                if (System.IO.File.Exists(ruta + "logCalculoComision1.txt"))
                {
                    log = new StreamWriter(ruta + "logCalculoComision1.txt");
                }
                else {

                    log = System.IO.File.AppendText(ruta + "logCalculoComision1.txt");
                }
 
                log.WriteLine("Excepcion name: " + ex.Message.ToString());
                log.Close();

            }

            return null;
        }

        public int calculoComision(string anio,string mes, string dia, string tipoLiqId, string modeloId, string usuario)
        {
            string milog = "1> metodo calculo comision ";

            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();
           // milog += "2> call method obetnerPeriodoCalComision("+anio +"," + mes +")";
           // var fechaPeriodo = _svcCalculosClient.obtenerPeriodoCalcComision(Convert.ToInt32(anio), Convert.ToInt32(mes));
           // milog += "3> resultado metodo: " + fechaPeriodo.ToString();
           // int diaCalculoFin = 1;
           // string diaCalculoFins = "";
           // string diaAnioAnterior = "", mesAnioAnterior = "";
           // DateTime fechaCalculInicial = DateTime.Now;//Seinicializa la variable, la cual cambiara cuando se lea el registro de BD
           // milog += "5>c fechaCalculInicial: " + DateTime.Now.ToString();

            //DateTime Fechacorte = Convert.ToDateTime(FechaCorte);
            //string mes = Fechacorte.Month < 10 ? "0" + Fechacorte.Month.ToString() : Fechacorte.Month.ToString();
            //string dia = Fechacorte.Day.ToString();
            //string anio = Fechacorte.Year.ToString();

           // milog = "2> FechaCorte " + Fechacorte.ToString(); ;
            mes = Convert.ToInt32(mes) < 10 ? "0" + mes : mes;
            dia = Convert.ToInt32(dia) < 10 ? "0" + dia : dia;
            StringBuilder parametrosEtlCF = new StringBuilder();
            CultureInfo culture = new CultureInfo("es-ES");
           // milog += "9>mes:"+ mes;
            //DateTime fechaExtract = Convert.ToDateTime(DateTime.Now.ToString("dd") + "/" + mes + "/" + anio, culture);
            //milog += "10>fechaExtract:" + fechaExtract ;
            parametrosEtlCF.Append("/SET \\Package.Variables[User::FechaFinExtraBenef].Properties[Value];\"" + anio + "-" + mes + "-" + dia + "\"");
            //parametrosEtlCF.Append(" /SET \\Package.Variables[User::FechaIniExtraBenef].Properties[Value];\"" + fechaCalculInicial.Year + "-" + mesAnioAnterior + "-" + diaAnioAnterior + "\"");
            parametrosEtlCF.Append(" /SET \\Package.Variables[User::ExtInvoiceMAC].Properties[Value];\"MAC" + dia + mes + anio + "F\"");
            parametrosEtlCF.Append(" /SET \\Package.Variables[User::ExtractCollecctMAC].Properties[Value];\"MAC" + dia + mes+ anio + "R\"");
            parametrosEtlCF.Append(" /SET \\Package.Variables[User::Homologaciones].Properties[Value];\"EXT-" + anio.Substring(2) + mes + dia+ "\"");
            milog += "3> parametros EtlCF: " + parametrosEtlCF.ToString();
            //parametros de novedades - Actualización 02/12/2016
            ComisionesSVC.ComisionesClient _svcComisiones = new ComisionesSVC.ComisionesClient();

            string[] parametrosCOns = new string[4] { "17", "18", "19", "20" };//Novedades Usarios CF, CV, Usuarios Renovados, Beneficiarios Vigentes
            List<admin.ConfigParametros> Parametros = _svcComisiones.ObtenerParametros(parametrosCOns).ToList();
            milog += "4> ParametrosCons: "+ parametrosCOns[0]+","+parametrosCOns[1]+","+parametrosCOns[2]+","+parametrosCOns[3];
            //Se reemplaza cada valor leido por ; debido a que el SP_EXTRACT_USERS_MAC está configurado para leer los parámetros por ;
            string NOV_CUNCF = Parametros.Where(x => x.id == 17).FirstOrDefault().valor.Replace(',', ';');
            string NOV_CUNCV = Parametros.Where(x => x.id == 18).FirstOrDefault().valor.Replace(',', ';');
            string NOV_CUSRN = Parametros.Where(x => x.id == 19).FirstOrDefault().valor.Replace(',', ';');
            string BEN_NSTATE = Parametros.Where(x => x.id == 20).FirstOrDefault().valor.Replace(',', ';');
            milog += "5> " +"-"+ NOV_CUNCF +"-"+ NOV_CUNCV +"-"+ NOV_CUSRN +"-"+ BEN_NSTATE;
            
            if (!NOV_CUNCF.Contains(";"))
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUNCF].Properties[Value];\"" + NOV_CUNCF + "\"");
            else
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUNCF].Properties[Value];\\\"" + NOV_CUNCF + "\\\"");

            if (NOV_CUNCV.Contains(";"))
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUNCV].Properties[Value];\\\"" + NOV_CUNCV + "\\\"");
            else
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUNCV].Properties[Value];\"" + NOV_CUNCV + "\"");

            if (NOV_CUSRN.Contains(";"))
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUSRN].Properties[Value];\\\"" + NOV_CUSRN + "\\\"");
            else
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::NOV_CUSRN].Properties[Value];\"" + NOV_CUSRN + "\"");

            if (BEN_NSTATE == "N")
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::BEN_NSTATE].Properties[Value];1");
            else
                parametrosEtlCF.Append(" /SET \\Package.Variables[User::BEN_NSTATE].Properties[Value];0");

            milog += "6> Parametro EtlCF" + parametrosEtlCF.ToString();
            StringBuilder parametrosEtlCV = new StringBuilder();
            if (tipoLiqId == "2")
            {
                milog += "7>";
                //parametros EtlCv Cargue de beneficiarios
                parametrosEtlCV.Append(" /SET \\Package.Variables[User::FechaFinExtraBenef].Properties[Value];\"" + anio+ "-" + mes + "-" + dia + "\"");
                // parametrosEtlCV.Append(" /SET \\Package.Variables[User::FechaIniExtraBenef].Properties[Value];\"" + fechaCalculInicial.Year + "-" + mesAnioAnterior + "-" + diaAnioAnterior + "\"");
                milog += "8>";
                if (!NOV_CUNCF.Contains(";"))
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUNCF].Properties[Value];\"" + NOV_CUNCF + "\"");
                else
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUNCF].Properties[Value];\\\"" + NOV_CUNCF + "\\\"");

                if (NOV_CUNCV.Contains(";"))
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUNCV].Properties[Value];\\\"" + NOV_CUNCV + "\\\"");
                else
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUNCV].Properties[Value];\"" + NOV_CUNCV + "\"");

                if (NOV_CUSRN.Contains(";"))
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUSRN].Properties[Value];\\\"" + NOV_CUSRN + "\\\"");
                else
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::NOV_CUSRN].Properties[Value];\"" + NOV_CUSRN + "\"");

                if (BEN_NSTATE == "N")
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::BEN_NSTATE].Properties[Value];1");
                else
                    parametrosEtlCV.Append(" /SET \\Package.Variables[User::BEN_NSTATE].Properties[Value];0");
                milog += "9>";
                //parametro ETLcv SpHomologacion
                parametrosEtlCV.Append(" /SET \\Package.Variables[User::CodExtrHomol].Properties[Value];\"EXT-" + anio.Substring(2) + mes + dia + "\"");
              milog += "10>Parametros Etl ComisionVariable" + parametrosEtlCV.ToString() ;
            }

            milog += "11>";
            var ExtracComsiones = _svcCalculosClient.ExtractCf_CV(parametrosEtlCF.ToString(), parametrosEtlCV.ToString(), Convert.ToInt32(modeloId), Convert.ToInt16(anio), Convert.ToByte(mes),
                   0, Convert.ToByte(tipoLiqId), usuario, Convert.ToInt32(tipoLiqId));

            milog += "12>";

            StreamWriter log;
            string ruta = "E:/SAI/";
            if (System.IO.File.Exists(ruta + "logCalculoComision2.txt"))
            {
                log = new StreamWriter(ruta + "logCalculoComision2.txt");
            }
            else
            {
                log = System.IO.File.AppendText(ruta + "logCalculoComision2.txt");
            }

            log.WriteLine(milog);
            log.Close();


            return 1;
        }

        public void Pagar(Int32 NumLiq)
        {
            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();

            _svcCalculosClient.LiquidarComisiones(NumLiq);
        }

        public ActionResult LevantarEtlAnulacion(int idliquidacion, string anio, string mes, string dia)
        {
            try
            {

                AsyncManager.OutstandingOperations.Increment();

                //string username = string.Empty;
                //if (HttpContext.Session["userName"] != null)
                //{

                //    username = HttpContext.Session["userName"].ToString();

                //}


                var task1 = Task<int>.Factory.StartNew(() =>
                {

                    //  miLog+=" 6> " + anio +"-"+ mes +"-"+ tipoLiqId +"-"+ modeloId +"-"+ username ;
                    return AnularLiquidacion(idliquidacion,anio,mes,dia);

                });

                task1.ContinueWith(t =>
                {

                    AsyncManager.OutstandingOperations.Decrement();
                });



            }
            catch (Exception ex)
            {


            }

            return null;
        }

        public int AnularLiquidacion(int IdLiquidacion, string anio,string mes, string dia)
        {

            _svcCalculosClient = new CalculosTalentosComision.CalculosClient();

            StringBuilder parametrosEtlAnulacion = new StringBuilder();
            CultureInfo culture = new CultureInfo("es-ES");

            //DateTime FechaExt = Convert.ToDateTime(Fecha);

              mes = Convert.ToInt32(mes) < 10 ? "0" + mes : mes;
            //string dia = FechaExt.Day.ToString();
            //string anio = FechaExt.Year.ToString();

            parametrosEtlAnulacion.Append("/SET \\Package.Variables[User::IdLiquidacion].Properties[Value];\"" + IdLiquidacion + "\"");
            parametrosEtlAnulacion.Append(" /SET \\Package.Variables[User::CodExt].Properties[Value];\"EXT-" + anio.Substring(2) + mes + dia + "-" + IdLiquidacion + "\"");
            parametrosEtlAnulacion.Append(" /SET \\Package.Variables[User::CodMacBHF].Properties[Value];\"MAC-" + dia + mes + anio + "-" + IdLiquidacion + "F\"");
            parametrosEtlAnulacion.Append(" /SET \\Package.Variables[User::CodMacBHR].Properties[Value];\"MAC-" + dia + mes + anio + "-" + IdLiquidacion + "R\"");

            ComisionesSVC.ComisionesClient _svcComisiones = new ComisionesSVC.ComisionesClient();

            var ExtractAnulacion = _svcCalculosClient.ExtractAnulacion(parametrosEtlAnulacion.ToString(), IdLiquidacion);


            return 1;
        }

        public ActionResult ReprocesarEtl(string anio, string mes, string dia, string idliquidacion, string Tipoliq, string modeloid)
        {
            try
            {

                //se actualiza el estado de liquidacion a reprocesando
                _svcCalculosClient = new CalculosTalentosComision.CalculosClient();

                _svcCalculosClient.ActualizaEstadoReprocesar( Convert.ToInt32(idliquidacion));
                
            }
            catch (Exception ex)
            {


            }

            return null;

            //ActionResult resEtlAnul = LevantarEtlAnulacion(Convert.ToInt32(idliquidacion), anio, mes, dia);

            //ActionResult resEtlLiquidacion = levantarEtl(anio, mes, dia, Tipoliq, modeloid);

            //return null;
        
        }



    }

    
}
