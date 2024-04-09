using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Timers;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.SqlServer.Dts.Runtime; //Se agrega en la ruta: C:\Windows\assembly\GAC_32\Microsoft.SqlServer.DTSRuntimeWrap\10.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.DTSRuntimeWrap.dll
using Microsoft.SqlServer.Dts.Runtime.Wrapper;
using System.Net;
using System.Configuration;
using System.ServiceModel;
using EjecucionIntegracion.AdministracionSvc;
using EjecucionIntegracion.LoggingSvc;

namespace EjecucionIntegracion
{
    public class EjecutarProceso
    {
        public static void Main(string[] args)
        {
            BasicHttpBinding binding      = new BasicHttpBinding();

            //EndpointAddress address     = new EndpointAddress("http://localhost:2090/Administracion.svc");
            //EndpointAddress address     = new EndpointAddress("http://pru-aplnet.uinversion.colpatria.com:3090/Autenticacion/Administracion.svc");
            EndpointAddress address     = new EndpointAddress("http://pro-aplnetsai.uinversion.colpatria.com:4090/Autenticacion/Administracion.svc");

            //EndpointAddress addressAuditoria        = new EndpointAddress("http://localhost:2090/Logging.svc");
            //EndpointAddress addressAuditoria        = new EndpointAddress("http://pru-aplnet.uinversion.colpatria.com:3090/Autenticacion/Logging.svc");
            EndpointAddress addressAuditoria        = new EndpointAddress("http://pro-aplnetsai.uinversion.colpatria.com:4090/Autenticacion/Logging.svc");

            // PRIORIDADES AUDITORIA:
            //MuyAlta = 4,
            //Alta    = 3,
            //Media   = 2,
            //Baja    = 1

            AdministracionSvc.AdministracionClient administracionSAI = new AdministracionSvc.AdministracionClient(binding, address);
            LoggingSvc.LoggingClient LoggingAuditoria                = new LoggingSvc.LoggingClient(binding, addressAuditoria);

            binding.SendTimeout                             = TimeSpan.FromHours(2);
            binding.OpenTimeout                             = TimeSpan.FromHours(2);
            binding.CloseTimeout                            = TimeSpan.FromHours(2);
            binding.ReceiveTimeout                          = TimeSpan.FromHours(4);
            binding.AllowCookies                            = true;
            binding.BypassProxyOnLocal                      = false;
            binding.HostNameComparisonMode                  = HostNameComparisonMode.StrongWildcard;
            binding.MessageEncoding                         = WSMessageEncoding.Text;
            binding.TextEncoding                            = System.Text.Encoding.UTF8;
            binding.TransferMode                            = TransferMode.Buffered;
            binding.UseDefaultWebProxy                      = true;
            binding.Security.Mode                           = BasicHttpSecurityMode.TransportCredentialOnly;
            binding.Security.Transport.ClientCredentialType = HttpClientCredentialType.Windows;

            /// Permite obtener la dirección IP del servidor donde se está ejecutando la tarea programada.
            /// 
            IPHostEntry host;
            string localIP = "";
            host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (IPAddress ip in host.AddressList)
            {
                if (ip.AddressFamily.ToString() == "InterNetwork")
                {
                    localIP = ip.ToString();
                }
            }

            string clienteip = localIP;

            InfoAplicacion InfoApp               = new InfoAplicacion();
            InfoApp.direccionIP                  = clienteip;
            InfoApp.nombreUsuario                = Dns.GetHostName();

            EjecutarDts Dtss = new EjecutarDts(administracionSAI);

            /// Configuración de Inicio de Horas de ejecución de Métodos que llaman el SP que dispara los SP de carga.
            /// 
            /// Hora Inicio carga Negocios y Recaudos
            /// 
            int hIniMonitoreoNR = administracionSAI.RetornarHorasIntegracion(14);

            /// Hora Inicio ejecución Datos Adicionales (PreCalculos, CRM, RecaudosSIG, LogErrores, Comisiones, COMXXX, Entrega Negocios y Recaudos)
            /// 
            int hIniEjeDA = administracionSAI.RetornarHorasIntegracion(15);

            /// Se Ejecuta a la 12:30 a.m --> Tarea Programada
            /// 
            Console.WriteLine("Inicia llamado a Método de creacion de los Archivos XML...");
            LoggingAuditoria.Auditoria("Inicia llamado a Método de creacion de los Archivos XML...", 4, "Integración", InfoApp);

            int resultadoxmlfiles = administracionSAI.Linq2XmlCrearArchivosXml();

            if (resultadoxmlfiles != 0)
            {
                Console.WriteLine("Ejecución ETL de Preintegración. Crea las tablas temporales de integración.");
                int llamadoPreIntegracion = Dtss.EjecutarPreIntegracion();
                LoggingAuditoria.Auditoria("Ejecución ETL de Preintegración. Crea las tablas temporales de integración.", 4, "Integración", InfoApp);

                /// Se Ejecuta a la 1 a.m
                /// 
                while (DateTime.Now.Hour <= hIniMonitoreoNR)
                {
                    if (DateTime.Now.Hour == hIniMonitoreoNR)
                    {
                        /// Llamado a las ETL de carga de Productos, Negocios de SISE GENERALES, SISE VIDA
                        /// CAPI, BH y EMERMEDICA y Recaudos de CAPI, BH y EMERMEDICA //Llamado en paralelo.
                        /// 
                        Console.WriteLine("Inicia Monitoreo al FTP para la ejecución de ETL's de Productos, Negocios y Recaudos por Compania...");
                        LoggingAuditoria.Auditoria("Inicia Monitoreo al FTP para la ejecución de ETL's de Productos, Negocios y Recaudos por Compania...", 4, "Integración", InfoApp);

                        Thread thSISEGEN     = new Thread(new ThreadStart(Dtss.MonitorearFTPSISEGEN));
                        Thread thSISEVIDA    = new Thread(new ThreadStart(Dtss.MonitorearFTPSISEVIDA));
                        Thread thCAPI        = new Thread(new ThreadStart(Dtss.MonitorearFTPCAPI));
                        Thread thBH          = new Thread(new ThreadStart(Dtss.MonitorearFTPBH));
                        Thread thEMERMEDICA  = new Thread(new ThreadStart(Dtss.MonitorearFTPEMERMEDICA));
                        Thread thExcepciones = new Thread(new ThreadStart(Dtss.EjecutarCargaExcepciones));

                        thSISEGEN.Start();
                        thSISEVIDA.Start();
                        thCAPI.Start();
                        thBH.Start();
                        thEMERMEDICA.Start();
                        thExcepciones.Start();
                        break;
                    }
                }

                while (DateTime.Now.Hour <= hIniEjeDA)
                {
                    if (DateTime.Now.Hour == hIniEjeDA)
                    {
                        /// Llamado a la ETL que ejecuta los recaudos de SISE (GENERALES y VIDA)
                        Console.WriteLine("Llamado a la ETL que ejecuta los recaudos de SISE (GENERALES y VIDA)...");
                        int thSISEREC = Dtss.MonitorearFTPSISEREC();
                        LoggingAuditoria.Auditoria("Llamado a la ETL que ejecuta los recaudos de SISE (GENERALES y VIDA)...", 4, "Integración", InfoApp);

                        /// Valida si existen ETL's que aún se esten ejecutando
                        Console.WriteLine("Valida si existen ETL's que aún se esten ejecutando...");
                        int cantidadPaquetesenCurso = administracionSAI.CantidadPaquetesenEjecución();
                        LoggingAuditoria.Auditoria("Valida si existen ETL's que aún se esten ejecutando...", 4, "Integración", InfoApp);

                        if (cantidadPaquetesenCurso > 0)
                            continue;                        

                        Console.WriteLine("Llamado a la ETL del calculo de Siniestralidad...");
                        int llamadoSiniestralidad = Dtss.EjecutarSiniestralidad();
                        LoggingAuditoria.Auditoria("Llamado a la ETL del calculo de Siniestralidad...", 4, "Integración", InfoApp);

                        Console.WriteLine("Llamado a la ETL con PreCalculos SAI...");
                        LoggingAuditoria.Auditoria("Llamado a la ETL con PreCalculos SAI...", 4, "Integración", InfoApp);
                        int llamadoPreCalculos = Dtss.EjecutarPreCalculos();

                        /// Ejecución de los calculos de Siniestralidad, Persistencia de Vida e Ingresos.
                        /// Entrega de información al CRM y de Recaudos al SIG. Llamado en paralelo.                    
                        /// 
                        Console.WriteLine("Inicia Ejecución de ELT's de entrega de información...");
                        LoggingAuditoria.Auditoria("Inicia Ejecución de ELT's de entrega de información y carga de Comisiones...", 4, "Integración", InfoApp);

                        Thread thCRM              = new Thread(new ThreadStart(Dtss.EjecutarCRM));
                        Thread thRecaudosSIG      = new Thread(new ThreadStart(Dtss.EjecutarRecaudosSIG));
                        Thread thLogErrores       = new Thread(new ThreadStart(Dtss.GenerarArchivosLogdeErrores));
                        Thread thCOMXXXF          = new Thread(new ThreadStart(Dtss.EjecutarCOMXXXF));
                        Thread thPortal           = new Thread(new ThreadStart(Dtss.EjecutarPortal));
                        Thread thReportes_Neg_Rec = new Thread(new ThreadStart(Dtss.EjecutarReportes_Neg_Rec));
                        Thread thComision         = new Thread(new ThreadStart(Dtss.EjecutarComisiones));

                        thCOMXXXF.Start();
                        thPortal.Start();
                        thLogErrores.Start();
                        thCRM.Start();
                        thRecaudosSIG.Start();
                        thReportes_Neg_Rec.Start();
                        thComision.Start();
                        
                        break;
                    }
                }
            }
        }
    }

    public class EjecutarDts
    {
        /// <summary>
        /// Ruta inicial donde se encuentran publicadas las Etls.
        /// </summary>
        const string PATH_ETL = @"File System\SAI\";

        /// <summary>
        /// Enumeración que contiene las compañias con las que se hace la integración.
        /// </summary>
        private enum Company { GENERALES, VIDA, CAPI, BH, EMERMEDICA };

        /// <summary>
        /// 20 segundos
        /// </summary>
        int tiemposleep = 20000;

        /// <summary>
        /// Fecha actual formateada.
        /// </summary>
        string fechaHoy = DateTime.Now.ToString("yyyyMMdd");

                /// <summary>
        /// Fecha ayer formateada.
        /// </summary>
        string fechaAyer = DateTime.Now.AddDays(-1).ToString("yyyyMMdd");

        /// <summary>
        /// Hora de Fin del Monitoreo del FTP para la carga de Negocios y Recaudos.
        /// </summary>
        int hFinMonitoreoNR = 3;

        /// <summary>
        /// Hora de Fin del Monitoreo del FTP para la carga de Comisiones y Siniestralidad.
        /// </summary>
        int hFinMonitoreoDA = 7;

        string IPFTP           = "";
        string user            = "";
        string pass            = "";
        string serverETL       = "";
        string passwordPackage = "";
        string horaSISE        = "";

        public EjecutarDts(AdministracionSvc.AdministracionClient administracionSAI)
        {
            string valoresWebConfig = administracionSAI.ValoresWebConfigServicio();
            string[] valores        = valoresWebConfig.Split(',');

            IPFTP     = valores[1];
            user      = valores[2];
            pass      = valores[3];
            serverETL = Dns.GetHostName();
            Console.WriteLine("Procesando sobre el servidor de ETL's" + " " + serverETL);
            passwordPackage = valores[5];
            horaSISE        = valores[7];
        }

        /// Monitoreo del FTP de los archivos de SISE GENERALES (Productos, Negocios y Recaudos
        /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
        /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
        /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
        /// 
        public int MonitorearFTPSISEREC()
        {
            FtpWebRequest reqFTP = null;
            FtpWebResponse resFTP = null;

            string[] filesFTPSISEREC = { "RecaudosGenerales.txt", "RecaudosVida.txt" };
            string[] packageSISEREC = { "GENERALES_Recaudo", "VIDA_Recaudo" };

            int cuentaSISEREC = filesFTPSISEREC.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaSISEREC > 0 && DateTime.Now.Hour < Convert.ToInt16(horaSISE))
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPSISEREC.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPSISEREC[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPSISEREC[k];

                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPSISEREC[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: Recaudos SISE " + "Fecha del archivo de " + filesFTPSISEREC[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPSISEREC[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;

                        Console.WriteLine("Tamaño del archivo de Recaudos SISE " + filesFTPSISEREC[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageSISEREC[k], "Recaudos SISE");

                        filesFTPSISEREC[k] = "0";
                        cuentaSISEREC -= 1;
                    }
                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }

            return 0;
        }

        /// Monitoreo del FTP de los archivos de SISE GENERALES (Productos, Negocios y Recaudos
        /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
        /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
        /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
        /// 
        public void MonitorearFTPSISEGEN()
        {
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            //string[] filesFTPSISEGEN = { "ProductosGenerales.txt", "ProductosGenerales.txt", "ProductosGenerales.txt" };
            //string[] packageSISEGEN = { "SISE_Productos", "SISE_Productos", "SISE_Productos" };

            string[] filesFTPSISEGEN = { "ProductosGenerales.txt", "NegociosGenerales.txt" };
            string[] packageSISEGEN = { "SISE_Productos", "GENERALES_Negocios" };

            int cuentaSISEGEN = filesFTPSISEGEN.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaSISEGEN > 0 && DateTime.Now.Hour < hFinMonitoreoNR)
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPSISEGEN.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPSISEGEN[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPSISEGEN[k];

                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPSISEGEN[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: GENERALES " + "Fecha del archivo de " + filesFTPSISEGEN[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPSISEGEN[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;

                        Console.WriteLine("Tamaño del archivo de GENERALES " + filesFTPSISEGEN[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageSISEGEN[k], "GENERALES");

                        filesFTPSISEGEN[k] = "0";
                        cuentaSISEGEN -= 1;
                    }
                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }
        }

        public void MonitorearFTPSISEVIDA()
        {
            /// Monitoreo del FTP de los archivos de SISE VIDA (Productos, Negocios y Recaudos
            /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
            /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
            /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
            /// 
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            string[] filesFTPSISEVIDA = { "ProductosVida.txt", "NegociosVida.txt" };
            string[] packageSISEVIDA  = { "SISEVIDA_Productos", "VIDA_Negocios" };

            int cuentaSISEVIDA = filesFTPSISEVIDA.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaSISEVIDA > 0 && DateTime.Now.Hour < hFinMonitoreoNR)
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPSISEVIDA.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPSISEVIDA[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPSISEVIDA[k];

                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPSISEVIDA[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                        /// 
                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: VIDA " + "Fecha del archivo de " + filesFTPSISEVIDA[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        ///

                        reqFTP = ConsultarFTP(filesFTPSISEVIDA[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;
                        Console.WriteLine("Tamaño del archivo de VIDA " + filesFTPSISEVIDA[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageSISEVIDA[k], "VIDA");

                        filesFTPSISEVIDA[k] = "0";
                        cuentaSISEVIDA     -= 1;
                    }

                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }
        }

        public void MonitorearFTPCAPI()
        {
            /// Monitoreo del FTP de los archivos de CAPI (Productos, Negocios y Recaudos
            /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
            /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
            /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
            /// 
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            string[] filesFTPCAPI = { "GPCSPF00", "GNCSPF00", "GRCSPF00", "NOM301O", "COMJJEO", "NOM235O"/*, "CODC01O"*/ };
            string[] packageCAPI  = { "CAPI_Productos", "CAPI_Negocios", "CAPI_Recaudo", "NOM301O", "COMJJEOMultijer", "NOM231"/*, "CODC01"*/ };

            int cuentaCAPI = filesFTPCAPI.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaCAPI > 0 && DateTime.Now.Hour < hFinMonitoreoNR)
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPCAPI.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPCAPI[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPCAPI[k];

                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPCAPI[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                        /// 
                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: CAPI " + "Fecha del archivo de " + filesFTPCAPI[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        ///

                        reqFTP = ConsultarFTP(filesFTPCAPI[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;
                        Console.WriteLine("Tamaño del archivo de CAPI " + filesFTPCAPI[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageCAPI[k], "CAPI");

                        filesFTPCAPI[k] = "0";
                        cuentaCAPI -= 1;
                    }

                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }
        }

        public void MonitorearFTPBH()
        {
            /// Monitoreo del FTP de los archivos de BH (Productos, Negocios y Recaudos
            /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
            /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
            /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
            /// 
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            string[] filesFTPBH = { "SAIProduct.txt", "SAIBusiness.txt", "SAICollect.txt" };
            string[] packageBH  = { "SALUD_Productos", "BH_Negocios", "SALUDBH_Recaudo" };

            int cuentaBH = filesFTPBH.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaBH > 0 && DateTime.Now.Hour < hFinMonitoreoNR)
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPBH.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPBH[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPBH[k];

                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPBH[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                        /// 
                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: BH " + "Fecha del archivo de " + filesFTPBH[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        ///

                        reqFTP = ConsultarFTP(filesFTPBH[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;
                        Console.WriteLine("Tamaño del archivo de BH " + filesFTPBH[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageBH[k], "BH");

                        filesFTPBH[k] = "0";
                        cuentaBH     -= 1;
                    }

                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }
        }

        /// Monitoreo del FTP de los archivos de EMERMEDICA (Productos, Negocios y Recaudos
        /// Se monitorea el FTP de 2 a.m a 4 a.m y cuando se encuentra uno de estos archivos
        /// con la fecha de Modificación igual a la fecha Actual se hace llamado al metodo que ejecuta
        /// el SP que dispara la ETL correspondiente al archivo de carga encontrado.
        /// 
        public void MonitorearFTPEMERMEDICA()
        {
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            string[] filesFTPEMERMEDICA = { "SAIPRODUEMER.TXT", "SAINEGOEMER.txt", "SAIRECAUEMER.txt" };
            string[] packageEMERMEDICA  = { "SALUD_EMERMEDICA", "EMERMEDICA_Negocios", "EMERMEDICA_Recaudo" };

            int cuentaEMERMEDICA = filesFTPEMERMEDICA.Length;

            /// Mientras que queden archivos por procesar o no se haya cumplido el tiempo límite
            /// se verifica que los archivos existan y si es así, se ejecuta la etl 
            /// correspondiente.
            /// 
            while (cuentaEMERMEDICA > 0 && DateTime.Now.Hour < hFinMonitoreoNR)
            {
                /// Por cada uno de los archivos, si existen y no se encuentran ocupados, se ejecuta la etl
                /// correspondiente.
                /// 
                for (int k = 0; k <= (filesFTPEMERMEDICA.Length - 1); k++)
                {
                    /// Se interrumpe la verificación de archivos, por un período corto de tiempo.
                    /// 
                    Thread.Sleep(tiemposleep);

                    if (filesFTPEMERMEDICA[k] == "0")
                        continue;

                    string uri = "ftp://" + IPFTP + "/" + filesFTPEMERMEDICA[k];
                    
                    try
                    {
                        /// Se obtiene la fecha del archivo correspondiente.
                        /// 

                        reqFTP = ConsultarFTP(filesFTPEMERMEDICA[k], WebRequestMethods.Ftp.GetDateTimestamp);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                        /// 
                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                        Console.WriteLine("Compañia: EMERMEDICA " + "Fecha del archivo de " + filesFTPEMERMEDICA[k] + ": " + fechaArchivoFTP);

                        /// Se obtiene el tamaño del archivo correspondiente.
                        ///

                        reqFTP = ConsultarFTP(filesFTPEMERMEDICA[k], WebRequestMethods.Ftp.GetFileSize);
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        /// Obtiene el tamaño del Archivo en la ruta FTP.
                        /// 
                        long tamanioArchivoFTP = resFTP.ContentLength;
                        Console.WriteLine("Tamaño del archivo de EMERMEDICA " + filesFTPEMERMEDICA[k] + ": " + tamanioArchivoFTP);

                        if (fechaArchivoFTP != fechaHoy || tamanioArchivoFTP == 0)
                            continue;

                        EjecutarETL(packageEMERMEDICA[k], "EMERMEDICA");

                        filesFTPEMERMEDICA[k] = "0";
                        cuentaEMERMEDICA     -= 1;
                    }

                    catch (WebException ex)
                    {
                        /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                        /// se continua intentando con el siguiente archivo.
                        /// 
                        FtpWebResponse response = (FtpWebResponse)ex.Response;
                        if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                            continue;
                    }
                    finally
                    {
                        if (resFTP != null)
                            resFTP.Close();
                    }
                }
            }
        }

        /// <summary>
        /// Método que se encarga de ejecutar una etl síncronamente.
        /// </summary>
        /// <param name="nombrePaquete">El nombre del paquete de integración a ejecutar.</param>
        /// <param name="compania">Nombre de la compañia al que pertenece el paquete.</param>
        /// <returns></returns>
        public void EjecutarETL(string nombrePaquete, string compania)
        {
            Application app          = new Application();
            app.PackagePassword      = passwordPackage;
            Package pkg              = (Package)app.LoadFromDtsServer(PATH_ETL + nombrePaquete, serverETL, true, null);
            DTSExecResult pkgResults = pkg.Execute();    

            Console.WriteLine("Resultado ETL: " + compania + " " + nombrePaquete + " - " +
                                (pkg.Errors.Count != 0 ? pkg.Errors.Count + " error(es)." : "Exitoso"));
        }

        /// <summary>
        /// Método encargado de crear un objeto FtpWebRequest, hacia un nombre de archivo 
        /// y con un método (GetFileSize, GetDateTimestamp, etc.) determinado.
        /// </summary>
        /// <param name="nombreArchivo">Nombre del archivo.</param>
        /// <param name="metodoFTP">Método FTP que se va a utilizar.</param>
        /// <returns></returns>
        public FtpWebRequest ConsultarFTP(string nombreArchivo, string metodoFTP)
        {
            FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + nombreArchivo));
            reqFTP.Credentials   = new NetworkCredential(user, pass);
            reqFTP.KeepAlive     = false;
            reqFTP.UseBinary     = true;
            reqFTP.Method        = metodoFTP;

            return reqFTP;
        }

        public int EjecutarPreCalculos()
        {
            EjecutarETL("PRECALCULOS", null);

            return 0;
        }

        public int EjecutarPreIntegracion()
        {
            EjecutarETL("PreIntegracion", null);

            return 0;
        }

        public void EjecutarCargaExcepciones()
        {
            FtpWebRequest reqFTP = null;
            FtpWebResponse resFTP = null;

            string uri = "ftp://" + IPFTP + "/SalidaSAI/Excepciones/Excepciones.csv";
            try
            {
                /// Se obtiene la fecha del archivo correspondiente.
                /// 

                reqFTP = ConsultarFTP("Excepciones.csv", WebRequestMethods.Ftp.GetDateTimestamp);
                resFTP = (FtpWebResponse)reqFTP.GetResponse();

                /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                /// 
                string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                Console.WriteLine("Sistema: Usuario " + "Fecha del archivo de " + "Excepciones" + ": " + fechaArchivoFTP);

                /// Se obtiene el tamaño del archivo correspondiente.
                ///

                reqFTP = ConsultarFTP("Excepciones.csv", WebRequestMethods.Ftp.GetFileSize);
                resFTP = (FtpWebResponse)reqFTP.GetResponse();

                /// Obtiene el tamaño del Archivo en la ruta FTP.
                /// 
                long tamanioArchivoFTP = resFTP.ContentLength;
                Console.WriteLine("Tamaño del archivo de Excepciones " + "Excepciones" + ": " + tamanioArchivoFTP);

                if (fechaArchivoFTP == fechaAyer && tamanioArchivoFTP != 0)
                {
                    EjecutarETL("CargarExcepciones", null);
                }
            }

            catch (WebException ex)
            {
                /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                /// se continua intentando con el siguiente archivo.
                /// 
                FtpWebResponse response = (FtpWebResponse)ex.Response;
                if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                    Console.Write(FtpStatusCode.ActionNotTakenFileUnavailableOrBusy);
            }
            finally
            {
                if (resFTP != null)
                    resFTP.Close();
            }
        }

        public int EjecutarSiniestralidad()
        {
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;

            string uri = "ftp://" + IPFTP + "/ArchivoSai";
                try
                {
                    /// Se obtiene la fecha del archivo correspondiente.
                    /// 

                    reqFTP = ConsultarFTP("ArchivoSai", WebRequestMethods.Ftp.GetDateTimestamp);
                    resFTP = (FtpWebResponse)reqFTP.GetResponse();

                    /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                    /// 
                    string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                    Console.WriteLine("Sistema: SIG " + "Fecha del archivo de " + "Siniestralidad" + ": " + fechaArchivoFTP);

                    /// Se obtiene el tamaño del archivo correspondiente.
                    ///

                    reqFTP = ConsultarFTP("ArchivoSai", WebRequestMethods.Ftp.GetFileSize);
                    resFTP = (FtpWebResponse)reqFTP.GetResponse();

                    /// Obtiene el tamaño del Archivo en la ruta FTP.
                    /// 
                    long tamanioArchivoFTP = resFTP.ContentLength;
                    Console.WriteLine("Tamaño del archivo de Siniestralidad " + "Siniestralidad" + ": " + tamanioArchivoFTP);

                    if (fechaArchivoFTP == fechaHoy && tamanioArchivoFTP != 0)
                    {
                        EjecutarETL("Siniestralidad", null);
                    }
                }

                catch (WebException ex)
                {
                    /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                    /// se continua intentando con el siguiente archivo.
                    /// 
                    FtpWebResponse response = (FtpWebResponse)ex.Response;
                    if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                        Console.Write(FtpStatusCode.ActionNotTakenFileUnavailableOrBusy);
                }
                finally
                {
                    if (resFTP != null)
                        resFTP.Close();
                }            

            return 0;
        }

        public void EjecutarComisiones()
        {
            FtpWebRequest reqFTP  = null;
            FtpWebResponse resFTP = null;
            int estadoEjecucion   = 0;

            /// Mientras que el el archivo de Comisiones no se haya procesado y
            /// la hora actual sea menor a la hora final de monitoreo.
            /// 
            while (DateTime.Now.Hour < hFinMonitoreoDA && estadoEjecucion == 0)
            {
                string uri = "ftp://" + IPFTP + "/CODC01O";
                try
                {
                    /// Se obtiene la fecha del archivo correspondiente.
                    /// 

                    reqFTP = ConsultarFTP("CODC01O", WebRequestMethods.Ftp.GetDateTimestamp);
                    resFTP = (FtpWebResponse)reqFTP.GetResponse();

                    /// Obtiene la Fecha de Modificación y el tamaño del Archivo en la ruta FTP.
                    /// 
                    string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");
                    Console.WriteLine("Sistema: GP " + "Fecha del archivo de " + "CODC01O" + ": " + fechaArchivoFTP);

                    /// Se obtiene el tamaño del archivo correspondiente.
                    ///

                    reqFTP = ConsultarFTP("CODC01O", WebRequestMethods.Ftp.GetFileSize);
                    resFTP = (FtpWebResponse)reqFTP.GetResponse();

                    /// Obtiene el tamaño del Archivo en la ruta FTP.
                    /// 
                    long tamanioArchivoFTP = resFTP.ContentLength;
                    Console.WriteLine("Tamaño del archivo de Comisiones " + "CODC01O" + ": " + tamanioArchivoFTP);

                    if (fechaArchivoFTP == fechaHoy && tamanioArchivoFTP != 0)
                    {
                        EjecutarETL("CODC01", null);
                        estadoEjecucion = 1;
                    }
                }

                catch (WebException ex)
                {
                    /// Si el archivo no existe o se encuentra ocupado (se esta escribiendo), 
                    /// se continua intentando con el siguiente archivo.
                    /// 
                    FtpWebResponse response = (FtpWebResponse)ex.Response;
                    if (response.StatusCode == FtpStatusCode.ActionNotTakenFileUnavailableOrBusy)
                        Console.Write(FtpStatusCode.ActionNotTakenFileUnavailableOrBusy);
                }
                finally
                {
                    if (resFTP != null)
                        resFTP.Close();
                }
            }
        }

        public void EjecutarCRM()
        {
            EjecutarETL("CRM", null);
        }

        public void EjecutarRecaudosSIG()
        {
            EjecutarETL("Recaudos_SIG", null);
        }

        public void GenerarArchivosLogdeErrores()
        {
            EjecutarETL("EXPORTARLOG_ERRORES", null);
        }

        public void EjecutarCOMXXXF()
        {
            EjecutarETL("COMXXXF", null);
        }

        public void EjecutarPortal()
        {
            EjecutarETL("Portal", null);
        }

        public void EjecutarReportes_Neg_Rec()
        {
            EjecutarETL("Reportes_Neg_Rec", null);
        }
    }
}