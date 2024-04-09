using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using System.Net;
using System.Configuration;
using System.Timers;
using Microsoft.SqlServer.Dts.Runtime; //Se agrega en la ruta: C:\Windows\assembly\GAC_32\Microsoft.SqlServer.DTSRuntimeWrap\10.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.DTSRuntimeWrap.dll
using Microsoft.SqlServer.Dts.Runtime.Wrapper;
using System.Collections.Specialized;
using System.Threading;


namespace ColpatriaSAI.Integracion
{
    class Integracion
    {
        static void EnviarFTP()
        {
            string rutaLocal = "c:\\Projects\\BizTalkIntegrador\\"; //Validar Ruta Relativa Web Config.
            string[] files = { "TestCAPIProductos.xml", "TestCAPINegocios.xml", "TestCAPIRecaudos.xml", "TestSISEVIDAProductos.xml", "TestSISEVIDANegocios.xml",
                               "TestSISEVIDARecaudos.xml", "TestSISEGENERALESProductos.xml", "TestSISEGENERALESNegocios.xml", "TestSISEGENERALESRecaudos.xml",
                               "TestGPParticipante.xml", "TestGPMultijerarquia.xml" };

            for (int i = 0; i <= 10; i++)
            {
                FileInfo info = new FileInfo(rutaLocal + files[i]);
                string FilePath = rutaLocal + files[i];
                FileInfo fileInf = new FileInfo(FilePath);
                string ftpServerIP = "10.132.82.232";
                string ftpUserID = "usrftpsai";
                string ftpPassword = "ftpsai";
                string uri = "ftp://" + ftpServerIP + "/" + "IntegracionBizTalk" + "/" + fileInf.Name;
                FtpWebRequest reqFTP;

                reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/" + "IntegracionBizTalk" + "/" + fileInf.Name));
                reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
                reqFTP.KeepAlive = false;
                reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
                reqFTP.UseBinary = true;
                reqFTP.ContentLength = fileInf.Length;

                int buffLength = 2048;
                byte[] buff = new byte[buffLength];
                int contentLen;

                FileStream fs = fileInf.OpenRead();

                try
                {
                    Stream strm = reqFTP.GetRequestStream();
                    contentLen = fs.Read(buff, 0, buffLength);

                    while (contentLen != 0)
                    {
                        strm.Write(buff, 0, contentLen);
                        contentLen = fs.Read(buff, 0, buffLength);
                    }

                    strm.Close();
                    fs.Close();
                }
                catch (Exception ex)
                {
                    string msg = ex.ToString();
                }
            }
        }

        static void ejecutarHilosETL()
        {
            int TIME = 10000; //En Produccion 10 min (100000)
            string ftpServerIP = "10.132.82.232:21";
            string ftpUserID = "usrftpsai";
            string ftpPassword = "ftpsai";
            string servidorETL = "DES-TSNETUI02"; //Cambiar a Servidor de ETL: DES-ETLRPTUI01
            string fechaActual = DateTime.Now.ToString("yyyyMMdd");
            
            Thread tCAPI = new Thread(() => MonitorearFTPCAPI(servidorETL, ftpServerIP, ftpUserID, ftpPassword, TIME, fechaActual));
            tCAPI.Start();

            Thread tSISEGENERALES = new Thread(() => MonitorearFTPSISEGENERALES(servidorETL, ftpServerIP, ftpUserID, ftpPassword, TIME, fechaActual));
            tSISEGENERALES.Start();

            Thread tSISEVIDA = new Thread(() => MonitorearFTPSISEVIDA(servidorETL, ftpServerIP, ftpUserID, ftpPassword, TIME, fechaActual));
            tSISEVIDA.Start();

            Thread tBH = new Thread(() => MonitorearFTPBH(servidorETL, ftpServerIP, ftpUserID, ftpPassword, TIME, fechaActual));
            tBH.Start();

            Thread tEMERMEDICA = new Thread(() => MonitorearFTPEMERMEDICA(servidorETL, ftpServerIP, ftpUserID, ftpPassword, TIME, fechaActual));
            tEMERMEDICA.Start();
        }

        static int MonitorearFTPCAPI(string serverETL, string IPFTP, string user, string pass, int tiemposleep, string fechaHoy)
        {
            FtpWebRequest reqFTP;
            FtpWebResponse resFTP;

            string[] filesFTPCAPI = { "GPCSPF00", "GNCSPF00", "GRCSPF00" };
            string[] package = { "CAPI_Productos", "CAPI_Negocios", "CAPI_Recaudo" };
            int j = 0;
            string cuenta = "";

            while (cuenta != "000") //Cantidad de Paquetes ejecutados correctamente
            {
                for (int k = 0; k <= filesFTPCAPI.Length - 1; k++)
                {
                    if (filesFTPCAPI[k] != "0")
                    {
                        string uri = "ftp://" + IPFTP + "/" + filesFTPCAPI[k];
                        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + filesFTPCAPI[k]));
                        reqFTP.Credentials = new NetworkCredential(user, pass);
                        reqFTP.KeepAlive = false;
                        reqFTP.UseBinary = true;

                        reqFTP.Method = WebRequestMethods.Ftp.GetDateTimestamp; //Obtiene la Fecha de Modificación del Archivo en la ruta FTP                        
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();


                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");

                        if (fechaArchivoFTP == fechaHoy)
                        {
                            string pkgLocation = @"File System\" + package[j];
                            Application app = new Application();
                            Package pkg = (Package)app.LoadFromDtsServer(pkgLocation, serverETL, true, null);
                            DTSExecResult pkgResults = pkg.Execute();
                            filesFTPCAPI[k] = "0";
                            cuenta += "0";
                        }                        
                    }

                    Thread.Sleep(tiemposleep);
                    j++;

                    if (cuenta != "000" && k == 2)
                    {
                        j = -1;
                        k = -1;
                    }
                }
            }

            return 0;
        }

        static int MonitorearFTPSISEGENERALES(string serverETL, string IPFTP, string user, string pass, int tiemposleep, string fechaHoy)
        {
            FtpWebRequest reqFTP;
            FtpWebResponse resFTP;

            string[] filesFTPSISEGENERALES = { "ProductosGenerales.txt", "NegociosGenerales.txt", "RecaudosGenerales.txt" };
            string[] package = { "SISE_Productos", "GENERALES_Negocios", "GENERALES_Recaudo" };
            int j = 0;
            string cuenta = "";

            while (cuenta != "000") //Cantidad de Paquetes ejecutados correctamente
            {
                for (int k = 0; k <= filesFTPSISEGENERALES.Length - 1; k++)
                {
                    if (filesFTPSISEGENERALES[k] != "0")
                    {
                        string uri = "ftp://" + IPFTP + "/" + filesFTPSISEGENERALES[k];
                        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + filesFTPSISEGENERALES[k]));
                        reqFTP.Credentials = new NetworkCredential(user, pass);
                        reqFTP.KeepAlive = false;
                        reqFTP.UseBinary = true;
                        reqFTP.Method = WebRequestMethods.Ftp.GetDateTimestamp; //Obtiene la Fecha de Modificación del Archivo en la ruta FTP
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");

                        if (fechaArchivoFTP == fechaHoy)
                        {
                            string pkgLocation = @"File System\" + package[j];
                            Application app = new Application();
                            Package pkg = (Package)app.LoadFromDtsServer(pkgLocation, serverETL, true, null);
                            DTSExecResult pkgResults = pkg.Execute();

                            filesFTPSISEGENERALES[k] = "0";
                            cuenta += "0";
                        }                                     
                    }
                    
                    Thread.Sleep(tiemposleep);
                    j++;

                    if (cuenta != "000" && k == 2)
                    {
                        j = -1;
                        k = -1;
                    }                 
                }
            }
            return 0;
        }

        static int MonitorearFTPSISEVIDA(string serverETL, string IPFTP, string user, string pass, int tiemposleep, string fechaHoy)
        {
            FtpWebRequest reqFTP;
            FtpWebResponse resFTP;

            string[] filesFTPSISEVIDA = { "ProductosVida.txt", "NegociosVida.txt", "RecaudosVida.txt" };
            string[] package = { "SISEVIDA_Productos", "VIDA_Negocios", "VIDA_Recaudo" };
            int j = 0;
            string cuenta = "";

            while (cuenta != "000") //Cantidad de Paquetes ejecutados correctamente
            {
                for (int k = 0; k <= filesFTPSISEVIDA.Length - 1; k++)
                {
                    if (filesFTPSISEVIDA[k] != "0")
                    {
                        string uri = "ftp://" + IPFTP + "/" + filesFTPSISEVIDA[k];
                        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + filesFTPSISEVIDA[k]));
                        reqFTP.Credentials = new NetworkCredential(user, pass);
                        reqFTP.KeepAlive = false;
                        reqFTP.UseBinary = true;
                        reqFTP.Method = WebRequestMethods.Ftp.GetDateTimestamp; //Obtiene la Fecha de Modificación del Archivo en la ruta FTP
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");

                        if (fechaArchivoFTP == fechaHoy)
                        {
                            string pkgLocation = @"File System\" + package[j];
                            Application app = new Application();
                            Package pkg = (Package)app.LoadFromDtsServer(pkgLocation, serverETL, true, null);
                            DTSExecResult pkgResults = pkg.Execute();

                            filesFTPSISEVIDA[k] = "0";
                            cuenta += "0";
                        }                             
                    }

                    Thread.Sleep(tiemposleep);
                    j++;

                    if (cuenta != "000" && k == 2)
                    {
                        j = -1;
                        k = -1;
                    }
                }
            }
            return 0;
        }
        
        static int MonitorearFTPEMERMEDICA(string serverETL, string IPFTP, string user, string pass, int tiemposleep, string fechaHoy)
        {
            FtpWebRequest reqFTP;
            FtpWebResponse resFTP;

            string[] filesFTPEMERMEDICA = { "PRODUCTOSEMERMEDICA.TXT", "NEGOCIOSEMERMEDICA.txt", "RECAUDOSEMERMEDICA.txt" };
            string[] package = { "SALUD_EMERMEDICA", "EMERMEDICA_Negocios", "EMERMEDICA_Recaudo" };
            int j = 0;
            string cuenta = "";

            while (cuenta != "000") //Cantidad de Paquetes ejecutados correctamente
            {
                for (int k = 0; k <= filesFTPEMERMEDICA.Length - 1; k++)
                {
                    if (filesFTPEMERMEDICA[k] != "0")
                    {
                        string uri = "ftp://" + IPFTP + "/" + filesFTPEMERMEDICA[k];
                        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + filesFTPEMERMEDICA[k]));
                        reqFTP.Credentials = new NetworkCredential(user, pass);
                        reqFTP.KeepAlive = false;
                        reqFTP.UseBinary = true;
                        reqFTP.Method = WebRequestMethods.Ftp.GetDateTimestamp; //Obtiene la Fecha de Modificación del Archivo en la ruta FTP
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");

                        if (fechaArchivoFTP == fechaHoy)
                        {
                            string pkgLocation = @"File System\" + package[j];
                            Application app = new Application();
                            Package pkg = (Package)app.LoadFromDtsServer(pkgLocation, serverETL, true, null);
                            DTSExecResult pkgResults = pkg.Execute();

                            filesFTPEMERMEDICA[k] = "0";
                            cuenta += "0";
                        }                          
                    }
                    
                    Thread.Sleep(tiemposleep);
                    j++;

                    if (cuenta != "000" && k == 2)
                    {
                        j = -1;
                        k = -1;
                    }                
                }
            }
            return 0;
        }

        static int MonitorearFTPBH(string serverETL, string IPFTP, string user, string pass, int tiemposleep, string fechaHoy)
        {
            FtpWebRequest reqFTP;
            FtpWebResponse resFTP;

            string[] filesFTPBH = { "SAIProduct.txt", "SAIBusiness.txt", "SAICollect.txt" };
            string[] package = { "SALUD_Productos", "BH_Negocios", "SALUDBH_Recaudo" };
            int j = 0;
            string cuenta = "";

            while (cuenta != "000") //Cantidad de Paquetes ejecutados correctamente
            {
                for (int k = 0; k <= filesFTPBH.Length - 1; k++)
                {
                    if (filesFTPBH[k] != "0")
                    {
                        string uri = "ftp://" + IPFTP + "/" + filesFTPBH[k];
                        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + IPFTP + "/" + filesFTPBH[k]));
                        reqFTP.Credentials = new NetworkCredential(user, pass);
                        reqFTP.KeepAlive = false;
                        reqFTP.UseBinary = true;
                        reqFTP.Method = WebRequestMethods.Ftp.GetDateTimestamp; //Obtiene la Fecha de Modificación del Archivo en la ruta FTP
                        resFTP = (FtpWebResponse)reqFTP.GetResponse();

                        string fechaArchivoFTP = resFTP.LastModified.ToString("yyyyMMdd");

                        if (fechaArchivoFTP == fechaHoy)
                        {
                            string pkgLocation = @"File System\" + package[j];
                            Application app = new Application();
                            Package pkg = (Package)app.LoadFromDtsServer(pkgLocation, serverETL, true, null);
                            DTSExecResult pkgResults = pkg.Execute();

                            filesFTPBH[k] = "0";
                            cuenta += "0";
                        }                        
                    }

                    Thread.Sleep(tiemposleep);
                    j++;

                    if (cuenta != "000" && k == 2)
                    {
                        j = -1;
                        k = -1;
                    }
                }
            }
            return 0;
        }

        static void Main(string[] args)
        {
            ejecutarHilosETL();
        }
    }
}


//si el ETL saca error se debe controlar desde el ETL, pero se debería mostrar mensaje en el llamado al ETL. R// Desde el programa solo se debe validar el llamado al archivo con la fechaActual. En la ETL se valida el log de errores.
//Adaptadores FTP de Biztalk.
//Validar los dias y los tiempos en que se hacen los llamados a los ETL, sobre todo en GP. R// Todos los días
//Validar Tarea programa desde Windows.
//Validar el tiempo máximo de monitoreo en el FTP. --> Cuando y a que horas comienza el monitoreo? --> Disparar este método a una hora determinada. Inicio: 1 a.m - Fin: 6 a.m
  


