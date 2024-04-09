
#pragma warning disable 162

namespace BizTalkSai_Project.CAPI
{

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEB__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEB _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEB();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEB__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEB)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEB__)
        },
        0,
        @"http://tempuri.org/#AIX_WEB"
    )]
    [System.SerializableAttribute]
    sealed internal class AIX_WEBSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEB__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEB__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AIX_WEBSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEBResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEBResponse _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEBResponse();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEBResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEBResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEBResponse__)
        },
        0,
        @"http://tempuri.org/#AIX_WEBResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class AIX_WEBSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEBResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX_WEBResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AIX_WEBSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX__)
        },
        0,
        @"http://tempuri.org/#AIX"
    )]
    [System.SerializableAttribute]
    sealed internal class AIXSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIX__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AIXSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIXResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIXResponse _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIXResponse();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIXResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIXResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIXResponse__)
        },
        0,
        @"http://tempuri.org/#AIXResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class AIXSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIXResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AIXResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AIXSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEB__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEB _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEB();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEB__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEB)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEB__)
        },
        0,
        @"http://tempuri.org/#XML_AIX_WEB"
    )]
    [System.SerializableAttribute]
    sealed internal class XML_AIX_WEBSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEB__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEB__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public XML_AIX_WEBSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEBResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEBResponse _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEBResponse();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEBResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEBResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEBResponse__)
        },
        0,
        @"http://tempuri.org/#XML_AIX_WEBResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class XML_AIX_WEBSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEBResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AIX_WEBResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public XML_AIX_WEBSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4 _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4__)
        },
        0,
        @"http://tempuri.org/#AS4"
    )]
    [System.SerializableAttribute]
    sealed internal class AS4SoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AS4SoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4Response__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4Response _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4Response();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4Response__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4Response)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4Response__)
        },
        0,
        @"http://tempuri.org/#AS4Response"
    )]
    [System.SerializableAttribute]
    sealed internal class AS4SoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4Response__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_AS4Response__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public AS4SoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4 _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4__)
        },
        0,
        @"http://tempuri.org/#XML_AS4"
    )]
    [System.SerializableAttribute]
    sealed internal class XML_AS4SoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public XML_AS4SoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4Response__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4Response _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4Response();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4Response__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4Response)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4Response__)
        },
        0,
        @"http://tempuri.org/#XML_AS4Response"
    )]
    [System.SerializableAttribute]
    sealed internal class XML_AS4SoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4Response__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_XML_AS4Response__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public XML_AS4SoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQL__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQL _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQL();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQL__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQL)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQL__)
        },
        0,
        @"http://tempuri.org/#SQL"
    )]
    [System.SerializableAttribute]
    sealed internal class SQLSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQL__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQL__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public SQLSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQLResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQLResponse _schema = new BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQLResponse();

        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQLResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQLResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQLResponse__)
        },
        0,
        @"http://tempuri.org/#SQLResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class SQLSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQLResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_CAPI_WsIntegrador_tempuri_org_SQLResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public SQLSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "AIX_WEB",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.AIX_WEBSoapIn), 
            typeof(BizTalkSai_Project.CAPI.AIX_WEBSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "AIX",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.AIXSoapIn), 
            typeof(BizTalkSai_Project.CAPI.AIXSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "XML_AIX_WEB",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.XML_AIX_WEBSoapIn), 
            typeof(BizTalkSai_Project.CAPI.XML_AIX_WEBSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "AS4",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.AS4SoapIn), 
            typeof(BizTalkSai_Project.CAPI.AS4SoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "XML_AS4",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.XML_AS4SoapIn), 
            typeof(BizTalkSai_Project.CAPI.XML_AS4SoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "SQL",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.SQLSoapIn), 
            typeof(BizTalkSai_Project.CAPI.SQLSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeAttribute(Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal, "")]
    [System.SerializableAttribute]
    sealed internal class WsIntegradorSoap : Microsoft.BizTalk.XLANGs.BTXEngine.BTXPortBase
    {
        public WsIntegradorSoap(int portInfo, Microsoft.XLANGs.Core.IServiceProxy s)
            : base(portInfo, s)
        { }
        public WsIntegradorSoap(WsIntegradorSoap p)
            : base(p)
        { }

        public override Microsoft.XLANGs.Core.PortBase Clone()
        {
            WsIntegradorSoap p = new WsIntegradorSoap(this);
            return p;
        }

        public static readonly Microsoft.XLANGs.BaseTypes.EXLangSAccess __access = Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal;
        #region port reflection support
        static public Microsoft.XLANGs.Core.OperationInfo AIX_WEB = new Microsoft.XLANGs.Core.OperationInfo
        (
            "AIX_WEB",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(AIX_WEBSoapIn),
            typeof(AIX_WEBSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo AIX = new Microsoft.XLANGs.Core.OperationInfo
        (
            "AIX",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(AIXSoapIn),
            typeof(AIXSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo XML_AIX_WEB = new Microsoft.XLANGs.Core.OperationInfo
        (
            "XML_AIX_WEB",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(XML_AIX_WEBSoapIn),
            typeof(XML_AIX_WEBSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo AS4 = new Microsoft.XLANGs.Core.OperationInfo
        (
            "AS4",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(AS4SoapIn),
            typeof(AS4SoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo XML_AS4 = new Microsoft.XLANGs.Core.OperationInfo
        (
            "XML_AS4",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(XML_AS4SoapIn),
            typeof(XML_AS4SoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo SQL = new Microsoft.XLANGs.Core.OperationInfo
        (
            "SQL",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(WsIntegradorSoap),
            typeof(SQLSoapIn),
            typeof(SQLSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public System.Collections.Hashtable OperationsInformation
        {
            get
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h[ "AIX_WEB" ] = AIX_WEB;
                h[ "AIX" ] = AIX;
                h[ "XML_AIX_WEB" ] = XML_AIX_WEB;
                h[ "AS4" ] = AS4;
                h[ "XML_AS4" ] = XML_AS4;
                h[ "SQL" ] = SQL;
                return h;
            }
        }
        #endregion // port reflection support
    }

    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "Operation_1",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.AS4SoapIn)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeAttribute(Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal, "")]
    [System.SerializableAttribute]
    sealed internal class PortType_1 : Microsoft.BizTalk.XLANGs.BTXEngine.BTXPortBase
    {
        public PortType_1(int portInfo, Microsoft.XLANGs.Core.IServiceProxy s)
            : base(portInfo, s)
        { }
        public PortType_1(PortType_1 p)
            : base(p)
        { }

        public override Microsoft.XLANGs.Core.PortBase Clone()
        {
            PortType_1 p = new PortType_1(this);
            return p;
        }

        public static readonly Microsoft.XLANGs.BaseTypes.EXLangSAccess __access = Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal;
        #region port reflection support
        static public Microsoft.XLANGs.Core.OperationInfo Operation_1 = new Microsoft.XLANGs.Core.OperationInfo
        (
            "Operation_1",
            System.Web.Services.Description.OperationFlow.OneWay,
            typeof(PortType_1),
            typeof(AS4SoapIn),
            null,
            new System.Type[]{},
            new string[]{}
        );
        static public System.Collections.Hashtable OperationsInformation
        {
            get
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h[ "Operation_1" ] = Operation_1;
                return h;
            }
        }
        #endregion // port reflection support
    }

    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "Operation_1",
        new System.Type[]{
            typeof(BizTalkSai_Project.CAPI.AS4SoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeAttribute(Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal, "")]
    [System.SerializableAttribute]
    sealed internal class PortType_2 : Microsoft.BizTalk.XLANGs.BTXEngine.BTXPortBase
    {
        public PortType_2(int portInfo, Microsoft.XLANGs.Core.IServiceProxy s)
            : base(portInfo, s)
        { }
        public PortType_2(PortType_2 p)
            : base(p)
        { }

        public override Microsoft.XLANGs.Core.PortBase Clone()
        {
            PortType_2 p = new PortType_2(this);
            return p;
        }

        public static readonly Microsoft.XLANGs.BaseTypes.EXLangSAccess __access = Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal;
        #region port reflection support
        static public Microsoft.XLANGs.Core.OperationInfo Operation_1 = new Microsoft.XLANGs.Core.OperationInfo
        (
            "Operation_1",
            System.Web.Services.Description.OperationFlow.OneWay,
            typeof(PortType_2),
            typeof(AS4SoapOut),
            null,
            new System.Type[]{},
            new string[]{}
        );
        static public System.Collections.Hashtable OperationsInformation
        {
            get
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h[ "Operation_1" ] = Operation_1;
                return h;
            }
        }
        #endregion // port reflection support
    }
    //#line 602 "E:\caalbarracinm\Principal-Desarrollo\ColpatriaSAI.IntegracionBiztalk\CAPI\WsIntegrador.odx"
    [Microsoft.XLANGs.BaseTypes.StaticSubscriptionAttribute(
        0, "AS4_IN", "Operation_1", -1, -1, true
    )]
    [Microsoft.XLANGs.BaseTypes.ServicePortsAttribute(
        new Microsoft.XLANGs.BaseTypes.EXLangSParameter[] {
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eImplements,
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses,
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        },
        new System.Type[] {
            typeof(BizTalkSai_Project.CAPI.PortType_1),
            typeof(BizTalkSai_Project.CAPI.WsIntegradorSoap),
            typeof(BizTalkSai_Project.CAPI.PortType_2)
        },
        new System.String[] {
            "AS4_IN",
            "WsIntegrador",
            "AS4_OUT"
        },
        new System.Type[] {
            null,
            null,
            null
        }
    )]
    [Microsoft.XLANGs.BaseTypes.ServiceCallTreeAttribute(
        new System.Type[] {
        },
        new System.Type[] {
        },
        new System.Type[] {
        }
    )]
    [Microsoft.XLANGs.BaseTypes.ServiceAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSServiceInfo.eNone
    )]
    [System.SerializableAttribute]
    [Microsoft.XLANGs.BaseTypes.BPELExportableAttribute(false)]
    sealed internal class WsIntegradorClient : Microsoft.BizTalk.XLANGs.BTXEngine.BTXService
    {
        public static readonly Microsoft.XLANGs.BaseTypes.EXLangSAccess __access = Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal;
        public static readonly bool __execable = false;
        [Microsoft.XLANGs.BaseTypes.CallCompensationAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSCallCompensationInfo.eHasRequestResponse
,
            new System.String[] {
            },
            new System.String[] {
            }
        )]
        public static void __bodyProxy()
        {
        }
        private static System.Guid _serviceId = Microsoft.XLANGs.Core.HashHelper.HashServiceType(typeof(WsIntegradorClient));
        private static volatile System.Guid[] _activationSubIds;

        private static new object _lockIdentity = new object();

        public static System.Guid UUID { get { return _serviceId; } }
        public override System.Guid ServiceId { get { return UUID; } }

        protected override System.Guid[] ActivationSubGuids
        {
            get { return _activationSubIds; }
            set { _activationSubIds = value; }
        }

        protected override object StaleStateLock
        {
            get { return _lockIdentity; }
        }

        protected override bool HasActivation { get { return true; } }

        internal bool IsExeced = false;

        static WsIntegradorClient()
        {
            Microsoft.BizTalk.XLANGs.BTXEngine.BTXService.CacheStaticState( _serviceId );
        }

        private void ConstructorHelper()
        {
            _segments = new Microsoft.XLANGs.Core.Segment[] {
                new Microsoft.XLANGs.Core.Segment( new Microsoft.XLANGs.Core.Segment.SegmentCode(this.segment0), 0, 0, 0),
                new Microsoft.XLANGs.Core.Segment( new Microsoft.XLANGs.Core.Segment.SegmentCode(this.segment1), 1, 1, 1),
                new Microsoft.XLANGs.Core.Segment( new Microsoft.XLANGs.Core.Segment.SegmentCode(this.segment2), 1, 2, 2),
                new Microsoft.XLANGs.Core.Segment( new Microsoft.XLANGs.Core.Segment.SegmentCode(this.segment3), 1, 2, 3)
            };

            _Locks = 0;
            _rootContext = new __WsIntegradorClient_root_0(this);
            _stateMgrs = new Microsoft.XLANGs.Core.IStateManager[3];
            _stateMgrs[0] = _rootContext;
            FinalConstruct();
        }

        public WsIntegradorClient(System.Guid instanceId, Microsoft.BizTalk.XLANGs.BTXEngine.BTXSession session, Microsoft.BizTalk.XLANGs.BTXEngine.BTXEvents tracker)
            : base(instanceId, session, "WsIntegradorClient", tracker)
        {
            ConstructorHelper();
        }

        public WsIntegradorClient(int callIndex, System.Guid instanceId, Microsoft.BizTalk.XLANGs.BTXEngine.BTXService parent)
            : base(callIndex, instanceId, parent, "WsIntegradorClient")
        {
            ConstructorHelper();
        }

        private const string _symInfo = @"
<XsymFile>
<ProcessFlow xmlns:om='http://schemas.microsoft.com/BizTalk/2003/DesignerData'>      <shapeType>RootShape</shapeType>      <ShapeID>c7276191-23e4-42af-a379-d9b0321a5363</ShapeID>      
<children>                          
<ShapeInfo>      <shapeType>ReceiveShape</shapeType>      <ShapeID>9bd9f2f7-0946-412f-94da-c0bf0450c2a8</ShapeID>      <ParentLink>ServiceBody_Statement</ParentLink>                <shapeText>Receive xml in</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>ScopeShape</shapeType>      <ShapeID>07ea286f-1407-47b3-807d-eaad578b4f6d</ShapeID>      <ParentLink>ServiceBody_Statement</ParentLink>                <shapeText>Scope AS4</shapeText>                  
<children>                          
<ShapeInfo>      <shapeType>SendShape</shapeType>      <ShapeID>8c96311b-adc7-42f1-b5ac-0b7094d0c4cc</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Send AS4</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>VariableAssignmentShape</shapeType>      <ShapeID>fad0287d-eecd-473c-827d-daeb8264d1ad</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Mensaje Error Servicio</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>ReceiveShape</shapeType>      <ShapeID>f94c2e56-4982-4c06-8eff-9bfd282b2e70</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Receive AS4</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>SendShape</shapeType>      <ShapeID>60eadeab-4fb8-4be1-bd76-578006a129c1</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Send xml out</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>CatchShape</shapeType>      <ShapeID>91c1f62f-3476-446a-99ad-411a4b40e282</ShapeID>      <ParentLink>Scope_Catch</ParentLink>                <shapeText>Respuesta AS4</shapeText>                      <ExceptionType>System.Exception</ExceptionType>            
<children>                          
<ShapeInfo>      <shapeType>VariableAssignmentShape</shapeType>      <ShapeID>ac537c0c-50f8-43b5-95fe-6e8499c01700</ShapeID>      <ParentLink>Catch_Statement</ParentLink>                <shapeText>Respuesta AS4</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>TerminateShape</shapeType>      <ShapeID>5e2c082e-7e39-4633-a51c-3f3eae31c787</ShapeID>      <ParentLink>Catch_Statement</ParentLink>                <shapeText>Terminate</shapeText>                  
<children>                </children>
  </ShapeInfo>
                  </children>
  </ShapeInfo>
                  </children>
  </ShapeInfo>
                  </children>
  </ProcessFlow><Metadata>

<TrkMetadata>
<ActionName>'WsIntegradorClient'</ActionName><IsAtomic>0</IsAtomic><Line>602</Line><Position>14</Position><ShapeID>'e211a116-cb8b-44e7-a052-0de295aa0001'</ShapeID>
</TrkMetadata>

<TrkMetadata>
<Line>615</Line><Position>22</Position><ShapeID>'9bd9f2f7-0946-412f-94da-c0bf0450c2a8'</ShapeID>
<Messages>
	<MsgInfo><name>WsRequestAS4</name><part>parameters</part><schema>BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org+AS4</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<ActionName>'??__scope35'</ActionName><IsAtomic>0</IsAtomic><Line>617</Line><Position>13</Position><ShapeID>'07ea286f-1407-47b3-807d-eaad578b4f6d'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>622</Line><Position>21</Position><ShapeID>'8c96311b-adc7-42f1-b5ac-0b7094d0c4cc'</ShapeID>
<Messages>
	<MsgInfo><name>WsRequestAS4</name><part>parameters</part><schema>BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org+AS4</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>624</Line><Position>55</Position><ShapeID>'fad0287d-eecd-473c-827d-daeb8264d1ad'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>626</Line><Position>21</Position><ShapeID>'f94c2e56-4982-4c06-8eff-9bfd282b2e70'</ShapeID>
<Messages>
	<MsgInfo><name>WsResponseAS4</name><part>parameters</part><schema>BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org+AS4Response</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>628</Line><Position>21</Position><ShapeID>'60eadeab-4fb8-4be1-bd76-578006a129c1'</ShapeID>
<Messages>
	<MsgInfo><name>WsResponseAS4</name><part>parameters</part><schema>BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org+AS4Response</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>633</Line><Position>21</Position><ShapeID>'91c1f62f-3476-446a-99ad-411a4b40e282'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>636</Line><Position>59</Position><ShapeID>'ac537c0c-50f8-43b5-95fe-6e8499c01700'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>638</Line><Position>25</Position><ShapeID>'5e2c082e-7e39-4633-a51c-3f3eae31c787'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>
</Metadata>
</XsymFile>";

        public override string odXml { get { return _symODXML; } }

        private const string _symODXML = @"
<?xml version='1.0' encoding='utf-8' standalone='yes'?>
<om:MetaModel MajorVersion='1' MinorVersion='3' Core='2b131234-7959-458d-834f-2dc0769ce683' ScheduleModel='66366196-361d-448d-976f-cab5e87496d2' xmlns:om='http://schemas.microsoft.com/BizTalk/2003/DesignerData'>
    <om:Element Type='Module' OID='8aab5011-f3c9-4cf7-a586-458bb8a9a498' LowerBound='1.1' HigherBound='137.1'>
        <om:Property Name='ReportToAnalyst' Value='True' />
        <om:Property Name='Name' Value='BizTalkSai_Project.CAPI' />
        <om:Property Name='Signal' Value='False' />
        <om:Element Type='PortType' OID='e0ede05e-0b6e-4610-806e-aa5aeb218baa' ParentLink='Module_PortType' LowerBound='52.1' HigherBound='79.1'>
            <om:Property Name='Synchronous' Value='True' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:portType name=&quot;WsIntegradorSoap&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WsIntegradorSoap' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='c35cba57-d6d5-437a-898b-e8d651904f1a' ParentLink='PortType_OperationDeclaration' LowerBound='54.1' HigherBound='58.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;AIX_WEB&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='AIX_WEB' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='4985ec28-ee83-4b36-a715-5b3277804733' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='56.13' HigherBound='56.26'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AIX_WEBSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:AIX_WEBSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='1cc81813-b1ff-470c-9022-c204de7f264d' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='56.28' HigherBound='56.42'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AIX_WEBSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:AIX_WEBSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='0d5a45a1-f846-47eb-adf5-3951511abb1a' ParentLink='PortType_OperationDeclaration' LowerBound='58.1' HigherBound='62.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;AIX&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='AIX' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='eeb4fe37-1e36-437e-99ed-892d9f97b017' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='60.13' HigherBound='60.22'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AIXSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:AIXSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='2c4bd33a-b663-48ac-8c92-42bc567cba2e' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='60.24' HigherBound='60.34'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AIXSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:AIXSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='359c6006-e19d-4c82-acb0-81e613266021' ParentLink='PortType_OperationDeclaration' LowerBound='62.1' HigherBound='66.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;XML_AIX_WEB&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='XML_AIX_WEB' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='62d7b91f-9d40-4c56-9859-d9ece93da350' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='64.13' HigherBound='64.30'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.XML_AIX_WEBSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:XML_AIX_WEBSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='abdcb128-014d-4d15-a002-8d1b4c9a8f20' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='64.32' HigherBound='64.50'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.XML_AIX_WEBSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:XML_AIX_WEBSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='211c4e67-0b4d-4dcc-ada3-e46ff78edad9' ParentLink='PortType_OperationDeclaration' LowerBound='66.1' HigherBound='70.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;AS4&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='AS4' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='d3be3a8c-13e9-4866-b149-1e92d7157a0f' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='68.13' HigherBound='68.22'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AS4SoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:AS4SoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='887b55e9-b9d0-4e2d-a074-9b89ba021d98' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='68.24' HigherBound='68.34'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AS4SoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:AS4SoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='241b328f-49cb-40fb-be31-72d467a76ba9' ParentLink='PortType_OperationDeclaration' LowerBound='70.1' HigherBound='74.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;XML_AS4&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='XML_AS4' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='0899cdc8-d4a6-4bba-9174-5f6f002f807d' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='72.13' HigherBound='72.26'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.XML_AS4SoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:XML_AS4SoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='6f83506d-11f6-4d3d-a581-381cc3673e08' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='72.28' HigherBound='72.42'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.XML_AS4SoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:XML_AS4SoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='ab1be6da-354f-4f9a-bb80-6ee1c5627126' ParentLink='PortType_OperationDeclaration' LowerBound='74.1' HigherBound='78.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;SQL&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='SQL' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='16fa3c96-8a3b-4884-b0d6-e62ef54d34b5' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='76.13' HigherBound='76.22'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.SQLSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://tempuri.org/:SQLSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='606e4aab-313f-4ede-a080-c8e3f6bef80c' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='76.24' HigherBound='76.34'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.SQLSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://tempuri.org/:SQLSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='PortType' OID='7ed57811-c360-47d9-8cc0-a0f29de00271' ParentLink='Module_PortType' LowerBound='79.1' HigherBound='86.1'>
            <om:Property Name='Synchronous' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='Name' Value='PortType_1' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='797c089f-1f60-46b5-9efa-1e52870db563' ParentLink='PortType_OperationDeclaration' LowerBound='81.1' HigherBound='85.1'>
                <om:Property Name='OperationType' Value='OneWay' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='Operation_1' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='c2848f44-032c-48a3-bd55-b2ccd5c10e2a' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='83.13' HigherBound='83.22'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AS4SoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='PortType' OID='877e5a87-3ec9-4539-a4b4-c12b6bd36879' ParentLink='Module_PortType' LowerBound='86.1' HigherBound='93.1'>
            <om:Property Name='Synchronous' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='Name' Value='PortType_2' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='f92baad7-acd2-4100-9be2-199b901ac728' ParentLink='PortType_OperationDeclaration' LowerBound='88.1' HigherBound='92.1'>
                <om:Property Name='OperationType' Value='OneWay' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='Operation_1' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='66e17bf9-d433-4820-8ea4-033ba4ebb16b' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='90.13' HigherBound='90.23'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.CAPI.AS4SoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='078ae773-4910-46f6-ba91-0600235623a1' ParentLink='Module_MessageType' LowerBound='4.1' HigherBound='8.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AIX_WEBSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AIX_WEBSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0a231164-dfc6-457d-93e0-7490e86aaa61' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='6.1' HigherBound='7.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEB' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f044853a-3922-4ee5-8f40-18c4a073e4a8' ParentLink='Module_MessageType' LowerBound='8.1' HigherBound='12.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AIX_WEBSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AIX_WEBSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='ef210b41-02d4-46da-b00d-ad87be9b6fd2' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='10.1' HigherBound='11.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX_WEBResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='17826460-7f53-41e4-a5c5-e6567a3397b3' ParentLink='Module_MessageType' LowerBound='12.1' HigherBound='16.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AIXSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AIXSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0083a454-f2cf-4df5-8331-7fe456040c57' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='14.1' HigherBound='15.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIX' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='a6b7379b-d65b-449d-bff5-187d798cd422' ParentLink='Module_MessageType' LowerBound='16.1' HigherBound='20.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AIXSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AIXSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='2d88eb92-7d60-4fcb-a9f1-72b0ac5efc7f' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='18.1' HigherBound='19.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AIXResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='a13fe868-2aaf-478e-b614-840d2b1d3a25' ParentLink='Module_MessageType' LowerBound='20.1' HigherBound='24.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;XML_AIX_WEBSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='XML_AIX_WEBSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='bc6cda5b-a099-412b-911f-e1d1de69a791' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='22.1' HigherBound='23.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEB' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='4c0130af-aaba-4543-be96-d7eaf568b601' ParentLink='Module_MessageType' LowerBound='24.1' HigherBound='28.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;XML_AIX_WEBSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='XML_AIX_WEBSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='734b176f-88ed-4572-89ee-1b037ad3a5a8' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='26.1' HigherBound='27.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AIX_WEBResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='4c0adf04-cdd5-4b4c-ae28-b8688206accb' ParentLink='Module_MessageType' LowerBound='28.1' HigherBound='32.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AS4SoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AS4SoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='7fb0a896-a9d9-4ee0-9956-524842c27318' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='30.1' HigherBound='31.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='9bfa901d-cdff-46b2-b054-2b8cbec5a5c3' ParentLink='Module_MessageType' LowerBound='32.1' HigherBound='36.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;AS4SoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='AS4SoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='ad757d23-55fa-4713-a661-fe25749f2d59' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='34.1' HigherBound='35.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.AS4Response' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0dfe089a-c641-4ba8-bef2-8fbe8b31aa6e' ParentLink='Module_MessageType' LowerBound='36.1' HigherBound='40.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;XML_AS4SoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='XML_AS4SoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='e6598163-0fb8-4761-9587-74ead9565f7a' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='38.1' HigherBound='39.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='6e8a467c-60d6-436b-aadb-7ccc0b689a1d' ParentLink='Module_MessageType' LowerBound='40.1' HigherBound='44.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;XML_AS4SoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='XML_AS4SoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='f45a504c-35e8-4a80-a5b2-f22b50d9f69a' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='42.1' HigherBound='43.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.XML_AS4Response' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='01e2955e-c105-41d6-8bdb-3a10324df7d4' ParentLink='Module_MessageType' LowerBound='44.1' HigherBound='48.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;SQLSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='SQLSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='6b0a96ec-e728-4b09-8837-002d4697a01d' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='46.1' HigherBound='47.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQL' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='05c8fcbf-c174-4dac-b350-6ab3241e58a9' ParentLink='Module_MessageType' LowerBound='48.1' HigherBound='52.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;SQLSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='SQLSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='77be1cdc-981b-4fd7-b8ff-6d76729cfb20' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='50.1' HigherBound='51.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.CAPI.WsIntegrador_tempuri_org.SQLResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='ServiceDeclaration' OID='6e1441c8-81af-42b6-88cd-1071d4f4531c' ParentLink='Module_ServiceDeclaration' LowerBound='93.1' HigherBound='136.1'>
            <om:Property Name='InitializedTransactionType' Value='False' />
            <om:Property Name='IsInvokable' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:service name=&quot;WsIntegrador&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WsIntegradorClient' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='MessageDeclaration' OID='56a7dcee-e021-482e-afc0-3a412d6794df' ParentLink='ServiceDeclaration_MessageDeclaration' LowerBound='102.1' HigherBound='103.1'>
                <om:Property Name='Type' Value='BizTalkSai_Project.CAPI.AS4SoapIn' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='WsRequestAS4' />
                <om:Property Name='Signal' Value='True' />
            </om:Element>
            <om:Element Type='MessageDeclaration' OID='0939d2b1-f4ed-4f34-aa32-452587f52145' ParentLink='ServiceDeclaration_MessageDeclaration' LowerBound='103.1' HigherBound='104.1'>
                <om:Property Name='Type' Value='BizTalkSai_Project.CAPI.AS4SoapOut' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='WsResponseAS4' />
                <om:Property Name='Signal' Value='True' />
            </om:Element>
            <om:Element Type='ServiceBody' OID='c7276191-23e4-42af-a379-d9b0321a5363' ParentLink='ServiceDeclaration_ServiceBody'>
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='Receive' OID='9bd9f2f7-0946-412f-94da-c0bf0450c2a8' ParentLink='ServiceBody_Statement' LowerBound='106.1' HigherBound='108.1'>
                    <om:Property Name='Activate' Value='True' />
                    <om:Property Name='PortName' Value='AS4_IN' />
                    <om:Property Name='MessageName' Value='WsRequestAS4' />
                    <om:Property Name='OperationName' Value='Operation_1' />
                    <om:Property Name='OperationMessageName' Value='Request' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Receive xml in' />
                    <om:Property Name='Signal' Value='True' />
                </om:Element>
                <om:Element Type='Scope' OID='07ea286f-1407-47b3-807d-eaad578b4f6d' ParentLink='ServiceBody_Statement' LowerBound='108.1' HigherBound='134.1'>
                    <om:Property Name='InitializedTransactionType' Value='True' />
                    <om:Property Name='IsSynchronized' Value='False' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Scope AS4' />
                    <om:Property Name='Signal' Value='True' />
                    <om:Element Type='Send' OID='8c96311b-adc7-42f1-b5ac-0b7094d0c4cc' ParentLink='ComplexStatement_Statement' LowerBound='113.1' HigherBound='115.1'>
                        <om:Property Name='PortName' Value='WsIntegrador' />
                        <om:Property Name='MessageName' Value='WsRequestAS4' />
                        <om:Property Name='OperationName' Value='AS4' />
                        <om:Property Name='OperationMessageName' Value='Request' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Send AS4' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='VariableAssignment' OID='fad0287d-eecd-473c-827d-daeb8264d1ad' ParentLink='ComplexStatement_Statement' LowerBound='115.1' HigherBound='117.1'>
                        <om:Property Name='Expression' Value='System.Diagnostics.Trace.WriteLine(&quot;Inicia llamado a AS4&quot;);' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Mensaje Error Servicio' />
                        <om:Property Name='Signal' Value='False' />
                    </om:Element>
                    <om:Element Type='Receive' OID='f94c2e56-4982-4c06-8eff-9bfd282b2e70' ParentLink='ComplexStatement_Statement' LowerBound='117.1' HigherBound='119.1'>
                        <om:Property Name='Activate' Value='False' />
                        <om:Property Name='PortName' Value='WsIntegrador' />
                        <om:Property Name='MessageName' Value='WsResponseAS4' />
                        <om:Property Name='OperationName' Value='AS4' />
                        <om:Property Name='OperationMessageName' Value='Response' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Receive AS4' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='Send' OID='60eadeab-4fb8-4be1-bd76-578006a129c1' ParentLink='ComplexStatement_Statement' LowerBound='119.1' HigherBound='121.1'>
                        <om:Property Name='PortName' Value='AS4_OUT' />
                        <om:Property Name='MessageName' Value='WsResponseAS4' />
                        <om:Property Name='OperationName' Value='Operation_1' />
                        <om:Property Name='OperationMessageName' Value='Request' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Send xml out' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='Catch' OID='91c1f62f-3476-446a-99ad-411a4b40e282' ParentLink='Scope_Catch' LowerBound='124.1' HigherBound='132.1'>
                        <om:Property Name='ExceptionName' Value='ex' />
                        <om:Property Name='ExceptionType' Value='System.Exception' />
                        <om:Property Name='IsFaultMessage' Value='False' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Respuesta AS4' />
                        <om:Property Name='Signal' Value='True' />
                        <om:Element Type='VariableAssignment' OID='ac537c0c-50f8-43b5-95fe-6e8499c01700' ParentLink='Catch_Statement' LowerBound='127.1' HigherBound='129.1'>
                            <om:Property Name='Expression' Value='System.Diagnostics.Trace.WriteLine(&quot;Respuesta AS4&quot;);' />
                            <om:Property Name='ReportToAnalyst' Value='True' />
                            <om:Property Name='Name' Value='Respuesta AS4' />
                            <om:Property Name='Signal' Value='False' />
                        </om:Element>
                        <om:Element Type='Terminate' OID='5e2c082e-7e39-4633-a51c-3f3eae31c787' ParentLink='Catch_Statement' LowerBound='129.1' HigherBound='131.1'>
                            <om:Property Name='ErrorMessage' Value='&quot;Fin de la orquestacion Crear Orden con Error &quot; + ex.Message;' />
                            <om:Property Name='ReportToAnalyst' Value='True' />
                            <om:Property Name='Name' Value='Terminate' />
                            <om:Property Name='Signal' Value='False' />
                        </om:Element>
                    </om:Element>
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='077d78b5-ce16-4150-8c72-78e5bca1825b' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='96.1' HigherBound='98.1'>
                <om:Property Name='PortModifier' Value='Uses' />
                <om:Property Name='Orientation' Value='Right' />
                <om:Property Name='PortIndex' Value='-1' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.CAPI.WsIntegradorSoap' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='WsIntegrador' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='155d5d9a-e0b9-4dde-a029-ff52891b6aac' ParentLink='PortDeclaration_CLRAttribute' LowerBound='96.1' HigherBound='97.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='be6a398f-9890-45a6-b5b6-d6db6bf50325' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='98.1' HigherBound='100.1'>
                <om:Property Name='PortModifier' Value='Uses' />
                <om:Property Name='Orientation' Value='Left' />
                <om:Property Name='PortIndex' Value='21' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.CAPI.PortType_2' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='AS4_OUT' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='fa3e7f56-627b-4f24-9dda-b0e01cab9b39' ParentLink='PortDeclaration_CLRAttribute' LowerBound='98.1' HigherBound='99.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='5f7bd930-7410-49a5-bdc0-345c57435efa' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='100.1' HigherBound='102.1'>
                <om:Property Name='PortModifier' Value='Implements' />
                <om:Property Name='Orientation' Value='Left' />
                <om:Property Name='PortIndex' Value='0' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.CAPI.PortType_1' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='AS4_IN' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='2c7ab883-4be8-469d-b6fa-ddba078d58ce' ParentLink='PortDeclaration_CLRAttribute' LowerBound='100.1' HigherBound='101.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
    </om:Element>
</om:MetaModel>
";

        [System.SerializableAttribute]
        public class __WsIntegradorClient_root_0 : Microsoft.XLANGs.Core.ServiceContext
        {
            public __WsIntegradorClient_root_0(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "WsIntegradorClient")
            {
            }

            public override int Index { get { return 0; } }

            public override Microsoft.XLANGs.Core.Segment InitialSegment
            {
                get { return _service._segments[0]; }
            }
            public override Microsoft.XLANGs.Core.Segment FinalSegment
            {
                get { return _service._segments[0]; }
            }

            public override int CompensationSegment { get { return -1; } }
            public override bool OnError()
            {
                Finally();
                return false;
            }

            public override void Finally()
            {
                WsIntegradorClient __svc__ = (WsIntegradorClient)_service;
                __WsIntegradorClient_root_0 __ctx0__ = (__WsIntegradorClient_root_0)(__svc__._stateMgrs[0]);

                if (__svc__.AS4_IN != null)
                {
                    __svc__.AS4_IN.Close(this, null);
                    __svc__.AS4_IN = null;
                }
                if (__svc__.AS4_OUT != null)
                {
                    __svc__.AS4_OUT.Close(this, null);
                    __svc__.AS4_OUT = null;
                }
                if (__svc__.WsIntegrador != null)
                {
                    __svc__.WsIntegrador.Close(this, null);
                    __svc__.WsIntegrador = null;
                }
                base.Finally();
            }

            internal Microsoft.XLANGs.Core.SubscriptionWrapper __subWrapper0;
            internal Microsoft.XLANGs.Core.SubscriptionWrapper __subWrapper1;
        }


        [System.SerializableAttribute]
        public class __WsIntegradorClient_1 : Microsoft.XLANGs.Core.ExceptionHandlingContext
        {
            public __WsIntegradorClient_1(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "WsIntegradorClient")
            {
            }

            public override int Index { get { return 1; } }

            public override bool CombineParentCommit { get { return true; } }

            public override Microsoft.XLANGs.Core.Segment InitialSegment
            {
                get { return _service._segments[1]; }
            }
            public override Microsoft.XLANGs.Core.Segment FinalSegment
            {
                get { return _service._segments[1]; }
            }

            public override int CompensationSegment { get { return -1; } }
            public override bool OnError()
            {
                Finally();
                return false;
            }

            public override void Finally()
            {
                WsIntegradorClient __svc__ = (WsIntegradorClient)_service;
                __WsIntegradorClient_1 __ctx1__ = (__WsIntegradorClient_1)(__svc__._stateMgrs[1]);

                if (__ctx1__ != null && __ctx1__.__WsRequestAS4 != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestAS4);
                    __ctx1__.__WsRequestAS4 = null;
                }
                base.Finally();
            }

            [Microsoft.XLANGs.Core.UserVariableAttribute("WsRequestAS4")]
            internal AS4SoapIn __WsRequestAS4;
            [Microsoft.XLANGs.Core.UserVariableAttribute("WsResponseAS4")]
            internal AS4SoapOut __WsResponseAS4;
        }


        [System.SerializableAttribute]
        public class ____scope35_2 : Microsoft.XLANGs.Core.ExceptionHandlingContext
        {
            public ____scope35_2(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "??__scope35")
            {
            }

            public override int Index { get { return 2; } }

            public override bool CombineParentCommit { get { return true; } }

            public override Microsoft.XLANGs.Core.Segment InitialSegment
            {
                get { return _service._segments[2]; }
            }
            public override Microsoft.XLANGs.Core.Segment FinalSegment
            {
                get { return _service._segments[2]; }
            }

            public override int CompensationSegment { get { return -1; } }
            public override bool OnError()
            {
                Microsoft.XLANGs.Core.Segment __seg__;
                Microsoft.XLANGs.Core.FaultReceiveException __fault__;

                __exv__ = _exception;
                if (!(__exv__ is Microsoft.XLANGs.Core.UnknownException))
                {
                    __fault__ = __exv__ as Microsoft.XLANGs.Core.FaultReceiveException;
                    if ((__fault__ == null) && (__exv__ is System.Exception))
                    {
                        __seg__ = _service._segments[3];
                        __seg__.Reset(1);
                        __seg__.PredecessorDone(_service);
                        return true;
                    }
                }

                Finally();
                return false;
            }

            public override void Finally()
            {
                WsIntegradorClient __svc__ = (WsIntegradorClient)_service;
                __WsIntegradorClient_1 __ctx1__ = (__WsIntegradorClient_1)(__svc__._stateMgrs[1]);
                __WsIntegradorClient_root_0 __ctx0__ = (__WsIntegradorClient_root_0)(__svc__._stateMgrs[0]);
                ____scope35_2 __ctx2__ = (____scope35_2)(__svc__._stateMgrs[2]);

                if (__ctx0__ != null && __ctx0__.__subWrapper1 != null)
                {
                    __ctx0__.__subWrapper1.Destroy(__svc__, __ctx0__);
                    __ctx0__.__subWrapper1 = null;
                }
                if (__ctx1__ != null && __ctx1__.__WsResponseAS4 != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseAS4);
                    __ctx1__.__WsResponseAS4 = null;
                }
                if (__ctx2__ != null)
                    __ctx2__.__ex_0 = null;
                base.Finally();
            }

            internal object __exv__;
            internal System.Exception __ex_0
            {
                get { return (System.Exception)__exv__; }
                set { __exv__ = value; }
            }
        }

        private static Microsoft.XLANGs.Core.CorrelationType[] _correlationTypes = null;
        public override Microsoft.XLANGs.Core.CorrelationType[] CorrelationTypes { get { return _correlationTypes; } }

        private static System.Guid[] _convoySetIds;

        public override System.Guid[] ConvoySetGuids
        {
            get { return _convoySetIds; }
            set { _convoySetIds = value; }
        }

        public static object[] StaticConvoySetInformation
        {
            get {
                return null;
            }
        }

        [Microsoft.XLANGs.BaseTypes.LogicalBindingAttribute()]
        [Microsoft.XLANGs.BaseTypes.PortAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.eImplements
        )]
        [Microsoft.XLANGs.Core.UserVariableAttribute("AS4_IN")]
        internal PortType_1 AS4_IN;
        [Microsoft.XLANGs.BaseTypes.LogicalBindingAttribute()]
        [Microsoft.XLANGs.BaseTypes.PortAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        )]
        [Microsoft.XLANGs.Core.UserVariableAttribute("WsIntegrador")]
        internal WsIntegradorSoap WsIntegrador;
        [Microsoft.XLANGs.BaseTypes.LogicalBindingAttribute()]
        [Microsoft.XLANGs.BaseTypes.PortAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        )]
        [Microsoft.XLANGs.Core.UserVariableAttribute("AS4_OUT")]
        internal PortType_2 AS4_OUT;

        public static Microsoft.XLANGs.Core.PortInfo[] _portInfo = new Microsoft.XLANGs.Core.PortInfo[] {
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {PortType_1.Operation_1},
                                               typeof(WsIntegradorClient).GetField("AS4_IN", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.implements,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(WsIntegradorClient), "AS4_IN"),
                                               null),
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {WsIntegradorSoap.AIX_WEB, WsIntegradorSoap.AIX, WsIntegradorSoap.XML_AIX_WEB, WsIntegradorSoap.AS4, WsIntegradorSoap.XML_AS4, WsIntegradorSoap.SQL},
                                               typeof(WsIntegradorClient).GetField("WsIntegrador", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.uses,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(WsIntegradorClient), "WsIntegrador"),
                                               null),
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {PortType_2.Operation_1},
                                               typeof(WsIntegradorClient).GetField("AS4_OUT", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.uses,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(WsIntegradorClient), "AS4_OUT"),
                                               null)
        };

        public override Microsoft.XLANGs.Core.PortInfo[] PortInformation
        {
            get { return _portInfo; }
        }

        static public System.Collections.Hashtable PortsInformation
        {
            get
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h[_portInfo[0].Name] = _portInfo[0];
                h[_portInfo[1].Name] = _portInfo[1];
                h[_portInfo[2].Name] = _portInfo[2];
                return h;
            }
        }

        public static System.Type[] InvokedServicesTypes
        {
            get
            {
                return new System.Type[] {
                    // type of each service invoked by this service
                };
            }
        }

        public static System.Type[] CalledServicesTypes
        {
            get
            {
                return new System.Type[] {
                };
            }
        }

        public static System.Type[] ExecedServicesTypes
        {
            get
            {
                return new System.Type[] {
                };
            }
        }

        public static object[] StaticSubscriptionsInformation {
            get {
                return new object[1]{
                     new object[5] { _portInfo[0], 0, null , -1, true }
                };
            }
        }

        public static Microsoft.XLANGs.RuntimeTypes.Location[] __eventLocations = new Microsoft.XLANGs.RuntimeTypes.Location[] {
            new Microsoft.XLANGs.RuntimeTypes.Location(0, "00000000-0000-0000-0000-000000000000", 1, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(1, "9bd9f2f7-0946-412f-94da-c0bf0450c2a8", 1, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(2, "9bd9f2f7-0946-412f-94da-c0bf0450c2a8", 1, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(3, "07ea286f-1407-47b3-807d-eaad578b4f6d", 1, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(4, "00000000-0000-0000-0000-000000000000", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(5, "8c96311b-adc7-42f1-b5ac-0b7094d0c4cc", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(6, "8c96311b-adc7-42f1-b5ac-0b7094d0c4cc", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(7, "fad0287d-eecd-473c-827d-daeb8264d1ad", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(8, "fad0287d-eecd-473c-827d-daeb8264d1ad", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(9, "f94c2e56-4982-4c06-8eff-9bfd282b2e70", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(10, "f94c2e56-4982-4c06-8eff-9bfd282b2e70", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(11, "60eadeab-4fb8-4be1-bd76-578006a129c1", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(12, "60eadeab-4fb8-4be1-bd76-578006a129c1", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(13, "91c1f62f-3476-446a-99ad-411a4b40e282", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(14, "ac537c0c-50f8-43b5-95fe-6e8499c01700", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(15, "ac537c0c-50f8-43b5-95fe-6e8499c01700", 3, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(16, "5e2c082e-7e39-4633-a51c-3f3eae31c787", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(17, "91c1f62f-3476-446a-99ad-411a4b40e282", 3, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(18, "07ea286f-1407-47b3-807d-eaad578b4f6d", 1, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(19, "00000000-0000-0000-0000-000000000000", 1, false)
        };

        public override Microsoft.XLANGs.RuntimeTypes.Location[] EventLocations
        {
            get { return __eventLocations; }
        }

        public static Microsoft.XLANGs.RuntimeTypes.EventData[] __eventData = new Microsoft.XLANGs.RuntimeTypes.EventData[] {
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Body),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Receive),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Scope),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Send),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Expression),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Expression),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Catch),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.Start | Microsoft.XLANGs.RuntimeTypes.Operation.Terminate),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Catch),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Scope),
            new Microsoft.XLANGs.RuntimeTypes.EventData( Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Body)
        };

        public static int[] __progressLocation0 = new int[] { 0,0,0,19,19,};
        public static int[] __progressLocation1 = new int[] { 0,0,1,1,2,3,3,3,18,19,19,19,19,};
        public static int[] __progressLocation2 = new int[] { 5,5,5,5,6,7,7,8,9,9,10,11,11,11,12,12,12,12,};
        public static int[] __progressLocation3 = new int[] { 13,13,14,14,15,16,16,17,17,};

        public static int[][] __progressLocations = new int[4] [] {__progressLocation0,__progressLocation1,__progressLocation2,__progressLocation3};
        public override int[][] ProgressLocations {get {return __progressLocations;} }

        public Microsoft.XLANGs.Core.StopConditions segment0(Microsoft.XLANGs.Core.StopConditions stopOn)
        {
            Microsoft.XLANGs.Core.Segment __seg__ = _segments[0];
            Microsoft.XLANGs.Core.Context __ctx__ = (Microsoft.XLANGs.Core.Context)_stateMgrs[0];
            __WsIntegradorClient_1 __ctx1__ = (__WsIntegradorClient_1)_stateMgrs[1];
            __WsIntegradorClient_root_0 __ctx0__ = (__WsIntegradorClient_root_0)_stateMgrs[0];

            switch (__seg__.Progress)
            {
            case 0:
                WsIntegrador = new WsIntegradorSoap(1, this);
                AS4_OUT = new PortType_2(2, this);
                AS4_IN = new PortType_1(0, this);
                __ctx__.PrologueCompleted = true;
                __ctx0__.__subWrapper0 = new Microsoft.XLANGs.Core.SubscriptionWrapper(ActivationSubGuids[0], AS4_IN, this);
                if ( !PostProgressInc( __seg__, __ctx__, 1 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.Initialized) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.Initialized;
                goto case 1;
            case 1:
                __ctx1__ = new __WsIntegradorClient_1(this);
                _stateMgrs[1] = __ctx1__;
                if ( !PostProgressInc( __seg__, __ctx__, 2 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 2;
            case 2:
                __ctx0__.StartContext(__seg__, __ctx1__);
                if ( !PostProgressInc( __seg__, __ctx__, 3 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                return Microsoft.XLANGs.Core.StopConditions.Blocked;
            case 3:
                if (!__ctx0__.CleanupAndPrepareToCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 4;
            case 4:
                __ctx1__.Finally();
                ServiceDone(__seg__, (Microsoft.XLANGs.Core.Context)_stateMgrs[0]);
                __ctx0__.OnCommit();
                break;
            }
            return Microsoft.XLANGs.Core.StopConditions.Completed;
        }

        public Microsoft.XLANGs.Core.StopConditions segment1(Microsoft.XLANGs.Core.StopConditions stopOn)
        {
            Microsoft.XLANGs.Core.Envelope __msgEnv__ = null;
            Microsoft.XLANGs.Core.Segment __seg__ = _segments[1];
            Microsoft.XLANGs.Core.Context __ctx__ = (Microsoft.XLANGs.Core.Context)_stateMgrs[1];
            __WsIntegradorClient_1 __ctx1__ = (__WsIntegradorClient_1)_stateMgrs[1];
            __WsIntegradorClient_root_0 __ctx0__ = (__WsIntegradorClient_root_0)_stateMgrs[0];
            ____scope35_2 __ctx2__ = (____scope35_2)_stateMgrs[2];

            switch (__seg__.Progress)
            {
            case 0:
                __ctx__.PrologueCompleted = true;
                if ( !PostProgressInc( __seg__, __ctx__, 1 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 1;
            case 1:
                if ( !PreProgressInc( __seg__, __ctx__, 2 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[0],__eventData[0],_stateMgrs[1].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 2;
            case 2:
                if ( !PreProgressInc( __seg__, __ctx__, 3 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[1],__eventData[1],_stateMgrs[1].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 3;
            case 3:
                if (!AS4_IN.GetMessageId(__ctx0__.__subWrapper0.getSubscription(this), __seg__, __ctx1__, out __msgEnv__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if (__ctx1__.__WsRequestAS4 != null)
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestAS4);
                __ctx1__.__WsRequestAS4 = new AS4SoapIn("WsRequestAS4", __ctx1__);
                __ctx1__.RefMessage(__ctx1__.__WsRequestAS4);
                AS4_IN.ReceiveMessage(0, __msgEnv__, __ctx1__.__WsRequestAS4, null, (Microsoft.XLANGs.Core.Context)_stateMgrs[1], __seg__);
                if (AS4_IN != null)
                {
                    AS4_IN.Close(__ctx1__, __seg__);
                    AS4_IN = null;
                }
                if ( !PostProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 4;
            case 4:
                if ( !PreProgressInc( __seg__, __ctx__, 5 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Receive);
                    __edata.Messages.Add(__ctx1__.__WsRequestAS4);
                    __edata.PortName = @"AS4_IN";
                    Tracker.FireEvent(__eventLocations[2],__edata,_stateMgrs[1].TrackDataStream );
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 5;
            case 5:
                if ( !PreProgressInc( __seg__, __ctx__, 6 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[3],__eventData[2],_stateMgrs[1].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 6;
            case 6:
                __ctx2__ = new ____scope35_2(this);
                _stateMgrs[2] = __ctx2__;
                if ( !PostProgressInc( __seg__, __ctx__, 7 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 7;
            case 7:
                __ctx1__.StartContext(__seg__, __ctx2__);
                if ( !PostProgressInc( __seg__, __ctx__, 8 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                return Microsoft.XLANGs.Core.StopConditions.Blocked;
            case 8:
                if ( !PreProgressInc( __seg__, __ctx__, 9 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                if (__ctx1__ != null && __ctx1__.__WsRequestAS4 != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestAS4);
                    __ctx1__.__WsRequestAS4 = null;
                }
                if (AS4_OUT != null)
                {
                    AS4_OUT.Close(__ctx1__, __seg__);
                    AS4_OUT = null;
                }
                if (WsIntegrador != null)
                {
                    WsIntegrador.Close(__ctx1__, __seg__);
                    WsIntegrador = null;
                }
                Tracker.FireEvent(__eventLocations[18],__eventData[9],_stateMgrs[1].TrackDataStream );
                __ctx2__.Finally();
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 9;
            case 9:
                if ( !PreProgressInc( __seg__, __ctx__, 10 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[19],__eventData[10],_stateMgrs[1].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 10;
            case 10:
                if (!__ctx1__.CleanupAndPrepareToCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 11 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 11;
            case 11:
                if ( !PreProgressInc( __seg__, __ctx__, 12 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                __ctx1__.OnCommit();
                goto case 12;
            case 12:
                __seg__.SegmentDone();
                _segments[0].PredecessorDone(this);
                break;
            }
            return Microsoft.XLANGs.Core.StopConditions.Completed;
        }

        public Microsoft.XLANGs.Core.StopConditions segment2(Microsoft.XLANGs.Core.StopConditions stopOn)
        {
            Microsoft.XLANGs.Core.Envelope __msgEnv__ = null;
            Microsoft.XLANGs.Core.Segment __seg__ = _segments[2];
            Microsoft.XLANGs.Core.Context __ctx__ = (Microsoft.XLANGs.Core.Context)_stateMgrs[2];
            __WsIntegradorClient_1 __ctx1__ = (__WsIntegradorClient_1)_stateMgrs[1];
            __WsIntegradorClient_root_0 __ctx0__ = (__WsIntegradorClient_root_0)_stateMgrs[0];
            ____scope35_2 __ctx2__ = (____scope35_2)_stateMgrs[2];

            switch (__seg__.Progress)
            {
            case 0:
                __ctx__.PrologueCompleted = true;
                if ( !PostProgressInc( __seg__, __ctx__, 1 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 1;
            case 1:
                if ( !PreProgressInc( __seg__, __ctx__, 2 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[5],__eventData[3],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 2;
            case 2:
                if (!__ctx2__.PrepareToPendingCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 3 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 3;
            case 3:
                if ( !PreProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                WsIntegrador.SendMessage(3, __ctx1__.__WsRequestAS4, null, null, out __ctx0__.__subWrapper1, __ctx2__, __seg__ );
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.OutgoingRqst) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.OutgoingRqst;
                goto case 4;
            case 4:
                if ( !PreProgressInc( __seg__, __ctx__, 5 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Send);
                    __edata.Messages.Add(__ctx1__.__WsRequestAS4);
                    __edata.PortName = @"WsIntegrador";
                    Tracker.FireEvent(__eventLocations[6],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 5;
            case 5:
                if ( !PreProgressInc( __seg__, __ctx__, 6 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[7],__eventData[4],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 6;
            case 6:
                System.Diagnostics.Trace.WriteLine("Inicia llamado a AS4");
                if ( !PostProgressInc( __seg__, __ctx__, 7 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 7;
            case 7:
                if ( !PreProgressInc( __seg__, __ctx__, 8 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[8],__eventData[5],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 8;
            case 8:
                if ( !PreProgressInc( __seg__, __ctx__, 9 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[9],__eventData[1],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 9;
            case 9:
                if (!WsIntegrador.GetMessageId(__ctx0__.__subWrapper1.getSubscription(this), __seg__, __ctx1__, out __msgEnv__, _locations[0]))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if (__ctx0__ != null && __ctx0__.__subWrapper1 != null)
                {
                    __ctx0__.__subWrapper1.Destroy(this, __ctx0__);
                    __ctx0__.__subWrapper1 = null;
                }
                if (__ctx1__.__WsResponseAS4 != null)
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseAS4);
                __ctx1__.__WsResponseAS4 = new AS4SoapOut("WsResponseAS4", __ctx1__);
                __ctx1__.RefMessage(__ctx1__.__WsResponseAS4);
                WsIntegrador.ReceiveMessage(3, __msgEnv__, __ctx1__.__WsResponseAS4, null, (Microsoft.XLANGs.Core.Context)_stateMgrs[2], __seg__);
                if ( !PostProgressInc( __seg__, __ctx__, 10 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 10;
            case 10:
                if ( !PreProgressInc( __seg__, __ctx__, 11 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Receive);
                    __edata.Messages.Add(__ctx1__.__WsResponseAS4);
                    __edata.PortName = @"WsIntegrador";
                    Tracker.FireEvent(__eventLocations[10],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 11;
            case 11:
                if ( !PreProgressInc( __seg__, __ctx__, 12 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[11],__eventData[3],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 12;
            case 12:
                if (!__ctx2__.PrepareToPendingCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 13 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 13;
            case 13:
                if ( !PreProgressInc( __seg__, __ctx__, 14 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                AS4_OUT.SendMessage(0, __ctx1__.__WsResponseAS4, null, null, __ctx2__, __seg__ , Microsoft.XLANGs.Core.ActivityFlags.NextActivityPersists );
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.OutgoingRqst) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.OutgoingRqst;
                goto case 14;
            case 14:
                if ( !PreProgressInc( __seg__, __ctx__, 15 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Send);
                    __edata.Messages.Add(__ctx1__.__WsResponseAS4);
                    __edata.PortName = @"AS4_OUT";
                    Tracker.FireEvent(__eventLocations[12],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (__ctx1__ != null && __ctx1__.__WsResponseAS4 != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseAS4);
                    __ctx1__.__WsResponseAS4 = null;
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 15;
            case 15:
                if (!__ctx2__.CleanupAndPrepareToCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 16 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 16;
            case 16:
                if ( !PreProgressInc( __seg__, __ctx__, 17 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                __ctx2__.OnCommit();
                goto case 17;
            case 17:
                __seg__.SegmentDone();
                _segments[1].PredecessorDone(this);
                break;
            }
            return Microsoft.XLANGs.Core.StopConditions.Completed;
        }

        public Microsoft.XLANGs.Core.StopConditions segment3(Microsoft.XLANGs.Core.StopConditions stopOn)
        {
            Microsoft.XLANGs.Core.Segment __seg__ = _segments[3];
            Microsoft.XLANGs.Core.Context __ctx__ = (Microsoft.XLANGs.Core.Context)_stateMgrs[2];
            ____scope35_2 __ctx2__ = (____scope35_2)_stateMgrs[2];

            switch (__seg__.Progress)
            {
            case 0:
                OnBeginCatchHandler(2);
                if ( !PostProgressInc( __seg__, __ctx__, 1 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 1;
            case 1:
                if ( !PreProgressInc( __seg__, __ctx__, 2 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[13],__eventData[6],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 2;
            case 2:
                if ( !PreProgressInc( __seg__, __ctx__, 3 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[14],__eventData[4],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 3;
            case 3:
                System.Diagnostics.Trace.WriteLine("Respuesta AS4");
                if ( !PostProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 4;
            case 4:
                if ( !PreProgressInc( __seg__, __ctx__, 5 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[15],__eventData[5],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 5;
            case 5:
                if ( !PreProgressInc( __seg__, __ctx__, 6 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[16],__eventData[7],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 6;
            case 6:
                RequestTerminate(__ctx2__,"Fin de la orquestacion Crear Orden con Error " + __ctx2__.__ex_0.Message);
                __seg__.SegmentDone();
                if (__ctx2__ != null)
                    __ctx2__.__ex_0 = null;
                break;
            case 7:
                if ( !PreProgressInc( __seg__, __ctx__, 8 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[17],__eventData[8],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 8;
            case 8:
                __ctx2__.__exv__ = null;
                OnEndCatchHandler(2, __seg__);
                __seg__.SegmentDone();
                break;
            }
            return Microsoft.XLANGs.Core.StopConditions.Completed;
        }
        private static Microsoft.XLANGs.Core.CachedObject[] _locations = new Microsoft.XLANGs.Core.CachedObject[] {
            new Microsoft.XLANGs.Core.CachedObject(new System.Guid("{DD7C52A2-DFFE-4092-8708-7A000E0B2BC5}"))
        };

    }

    [Microsoft.XLANGs.BaseTypes.BPELExportableAttribute(false)]
    sealed public class _MODULE_PROXY_ { }
}
