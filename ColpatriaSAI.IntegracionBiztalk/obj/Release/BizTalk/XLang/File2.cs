
#pragma warning disable 162

namespace BizTalkSai_Project.BH
{

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractsByMemberMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractsByMemberMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractsByMemberMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractsByMemberMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractsByMemberMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByMemberMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractsByMemberMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractCodeMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractCodeMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractCodeMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractCodeMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractCodeMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodeMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractCodeMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractApplicationCodeMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractApplicationCodeMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractApplicationCodeMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractApplicationCodeMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractApplicationCodeMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractApplicationCodeMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractApplicationCodeMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractCodeMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractCodeMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractCodeMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractCodeMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractCodeMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodeMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractCodeMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractApplicationCodeMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractApplicationCodeMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractApplicationCodeMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractApplicationCodeMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractApplicationCodeMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractApplicationCodeMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractApplicationCodeMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSCollectiveContractsByIntermediaryMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSCollectiveContractsByIntermediaryMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSCollectiveContractsByIntermediaryMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSCollectiveContractsByIntermediaryMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSCollectiveContractsByIntermediaryMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByIntermediaryMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSCollectiveContractsByIntermediaryMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSSearchSubContractsMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSSearchSubContractsMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSSearchSubContractsMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSSearchSubContractsMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSSearchSubContractsMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSearchSubContractsMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSSearchSubContractsMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSSubContractsByCollectiveContractMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSSubContractsByCollectiveContractMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSSubContractsByCollectiveContractMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSSubContractsByCollectiveContractMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSSubContractsByCollectiveContractMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSSubContractsByCollectiveContractMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSSubContractsByCollectiveContractMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractByMemberPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractByMemberPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractByMemberPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractByMemberPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractByMemberPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractByMemberPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractByMemberPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractCodePOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractCodePOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractCodePOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByContractCodePOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByContractCodePOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByContractCodePOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByContractCodePOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractCodePOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractCodePOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractCodePOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMemberInformationByContractCodePOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMemberInformationByContractCodePOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMemberInformationByContractCodePOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMemberInformationByContractCodePOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSCollectiveContractsByEmployerMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSCollectiveContractsByEmployerMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSCollectiveContractsByEmployerMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSCollectiveContractsByEmployerMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSCollectiveContractsByEmployerMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSCollectiveContractsByEmployerMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSCollectiveContractsByEmployerMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByEmployerPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByEmployerPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByEmployerPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSMembersByEmployerPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSMembersByEmployerPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSMembersByEmployerPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSMembersByEmployerPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSFindContractByCodeMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSFindContractByCodeMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSFindContractByCodeMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSFindContractByCodeMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSFindContractByCodeMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractByCodeMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSFindContractByCodeMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateHeaderMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateHeaderMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateHeaderMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateHeaderMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateHeaderMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateHeaderMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateHeaderMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateDetailsMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateDetailsMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateDetailsMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateDetailsMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateDetailsMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateDetailsMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateDetailsMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateFooterMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateFooterMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateFooterMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractAccountStateFooterMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractAccountStateFooterMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractAccountStateFooterMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractAccountStateFooterMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformation__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformation _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformation();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformation__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformation)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformation__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSIPSCapitaInformation"
    )]
    [System.SerializableAttribute]
    sealed internal class WSIPSCapitaInformationSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformation__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformation__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSIPSCapitaInformationSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformationResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformationResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformationResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformationResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformationResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformationResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSIPSCapitaInformationResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSIPSCapitaInformationSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformationResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIPSCapitaInformationResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSIPSCapitaInformationSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSInvoiceInformationMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSInvoiceInformationMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSInvoiceInformationMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSInvoiceInformationMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSInvoiceInformationMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSInvoiceInformationMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSInvoiceInformationDetailMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSInvoiceInformationDetailMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSInvoiceInformationDetailMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSInvoiceInformationDetailMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSInvoiceInformationDetailMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSInvoiceInformationDetailMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSInvoiceInformationDetailMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractYearsByClientMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractYearsByClientMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractYearsByClientMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractYearsByClientMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractYearsByClientMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByClientMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractYearsByClientMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractsByYearMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractsByYearMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractsByYearMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractsByYearMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractsByYearMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractsByYearMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractsByYearMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSRetentionCertificateByContractMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSRetentionCertificateByContractMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSRetentionCertificateByContractMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSRetentionCertificateByContractMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSRetentionCertificateByContractMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSRetentionCertificateByContractMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSRetentionCertificateByContractDetailMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSRetentionCertificateByContractDetailMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSRetentionCertificateByContractDetailMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSRetentionCertificateByContractDetailMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSRetentionCertificateByContractDetailMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSRetentionCertificateByContractDetailMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSRetentionCertificateByContractDetailMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSFindContractsByMemberDocumentMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSFindContractsByMemberDocumentMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSFindContractsByMemberDocumentMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSFindContractsByMemberDocumentMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSFindContractsByMemberDocumentMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSFindContractsByMemberDocumentMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSFindContractsByMemberDocumentMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractYearsByContractMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractYearsByContractMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractYearsByContractMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSContractYearsByContractMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSContractYearsByContractMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSContractYearsByContractMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSContractYearsByContractMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentYearsByMemberPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentYearsByMemberPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentYearsByMemberPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentYearsByMemberPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentYearsByMemberPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByMemberPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentYearsByMemberPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSEmployersByMemberPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSEmployersByMemberPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSEmployersByMemberPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSEmployersByMemberPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSEmployersByMemberPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSEmployersByMemberPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSEmployersByMemberPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentYearsByEmployerMemberPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentYearsByEmployerMemberPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentYearsByEmployerMemberPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentYearsByEmployerMemberPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentYearsByEmployerMemberPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentYearsByEmployerMemberPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentYearsByEmployerMemberPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateHeaderPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateHeaderPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateHeaderPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateHeaderPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateHeaderPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateHeaderPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateHeaderPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateDetailForUPCPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateDetailForUPCPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateDetailForUPCPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateDetailForUPCPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateDetailForUPCPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailForUPCPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateDetailForUPCPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOS__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOS _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOS();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOS__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOS)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOS__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateDetailPOS"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateDetailPOSSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOS__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOS__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateDetailPOSSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOSResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOSResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOSResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOSResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOSResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOSResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPaymentCertificateDetailPOSResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPaymentCertificateDetailPOSSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOSResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPaymentCertificateDetailPOSResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPaymentCertificateDetailPOSSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPP__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPP _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPP();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPP__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPP)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPP__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSNoveltyOrNoteDetailMPP"
    )]
    [System.SerializableAttribute]
    sealed internal class WSNoveltyOrNoteDetailMPPSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPP__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPP__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSNoveltyOrNoteDetailMPPSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPPResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPPResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPPResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPPResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPPResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPPResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSNoveltyOrNoteDetailMPPResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSNoveltyOrNoteDetailMPPSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPPResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSNoveltyOrNoteDetailMPPResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSNoveltyOrNoteDetailMPPSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExists__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExists _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExists();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExists__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExists)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExists__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPersonOrInstitutionExists"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPersonOrInstitutionExistsSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExists__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExists__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPersonOrInstitutionExistsSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExistsResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExistsResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExistsResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExistsResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExistsResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExistsResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPersonOrInstitutionExistsResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPersonOrInstitutionExistsSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExistsResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPersonOrInstitutionExistsResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPersonOrInstitutionExistsSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProduct__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProduct _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProduct();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProduct__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProduct)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProduct__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPortfolioBalanceByMemberDocumentAndProduct"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPortfolioBalanceByMemberDocumentAndProductSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProduct__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProduct__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPortfolioBalanceByMemberDocumentAndProductSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProductResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProductResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProductResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProductResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProductResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProductResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSPortfolioBalanceByMemberDocumentAndProductResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSPortfolioBalanceByMemberDocumentAndProductSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProductResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSPortfolioBalanceByMemberDocumentAndProductResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSPortfolioBalanceByMemberDocumentAndProductSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystem__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystem _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystem();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystem__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystem)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystem__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSIncentivesAdministrationSystem"
    )]
    [System.SerializableAttribute]
    sealed internal class WSIncentivesAdministrationSystemSoapIn : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystem__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystem__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSIncentivesAdministrationSystemSoapIn(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [System.SerializableAttribute]
    sealed public class __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystemResponse__ : Microsoft.XLANGs.Core.XSDPart
    {
        private static BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystemResponse _schema = new BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystemResponse();

        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystemResponse__(Microsoft.XLANGs.Core.XMessage msg, string name, int index) : base(msg, name, index) { }

        
        #region part reflection support
        public static Microsoft.XLANGs.BaseTypes.SchemaBase PartSchema { get { return (Microsoft.XLANGs.BaseTypes.SchemaBase)_schema; } }
        #endregion // part reflection support
    }

    [Microsoft.XLANGs.BaseTypes.MessageTypeAttribute(
        Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal,
        Microsoft.XLANGs.BaseTypes.EXLangSMessageInfo.eNone,
        "",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystemResponse)
        },
        new string[]{
            "parameters"
        },
        new System.Type[]{
            typeof(__BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystemResponse__)
        },
        0,
        @"http://BeyondHealth/WebServices#WSIncentivesAdministrationSystemResponse"
    )]
    [System.SerializableAttribute]
    sealed internal class WSIncentivesAdministrationSystemSoapOut : Microsoft.BizTalk.XLANGs.BTXEngine.BTXMessage
    {
        public __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystemResponse__ parameters;

        private void __CreatePartWrappers()
        {
            parameters = new __BizTalkSai_Project_BH_Service_beyondhealth_WebServices_WSIncentivesAdministrationSystemResponse__(this, "parameters", 0);
            this.AddPart("parameters", 0, parameters);
        }

        public WSIncentivesAdministrationSystemSoapOut(string msgName, Microsoft.XLANGs.Core.Context ctx) : base(msgName, ctx)
        {
            __CreatePartWrappers();
        }
    }

    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractsByMemberMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractsByMemberMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractsByMemberMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMembersByContractCodeMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMembersByContractCodeMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMembersByContractCodeMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMembersByContractApplicationCodeMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMembersByContractApplicationCodeMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMembersByContractApplicationCodeMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMemberInformationByContractCodeMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractCodeMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractCodeMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMemberInformationByContractApplicationCodeMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractApplicationCodeMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractApplicationCodeMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSCollectiveContractsByIntermediaryMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSCollectiveContractsByIntermediaryMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSCollectiveContractsByIntermediaryMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSSearchSubContractsMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSSearchSubContractsMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSSearchSubContractsMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSSubContractsByCollectiveContractMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSSubContractsByCollectiveContractMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSSubContractsByCollectiveContractMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractByMemberPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractByMemberPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractByMemberPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMembersByContractCodePOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMembersByContractCodePOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMembersByContractCodePOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMemberInformationByContractCodePOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractCodePOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMemberInformationByContractCodePOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSCollectiveContractsByEmployerMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSCollectiveContractsByEmployerMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSCollectiveContractsByEmployerMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSMembersByEmployerPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSMembersByEmployerPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSMembersByEmployerPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSFindContractByCodeMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSFindContractByCodeMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSFindContractByCodeMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractAccountStateHeaderMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractAccountStateHeaderMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractAccountStateHeaderMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractAccountStateDetailsMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractAccountStateDetailsMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractAccountStateDetailsMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractAccountStateFooterMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractAccountStateFooterMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractAccountStateFooterMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSIPSCapitaInformation",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSIPSCapitaInformationSoapIn), 
            typeof(BizTalkSai_Project.BH.WSIPSCapitaInformationSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSInvoiceInformationMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSInvoiceInformationMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSInvoiceInformationMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSInvoiceInformationDetailMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSInvoiceInformationDetailMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSInvoiceInformationDetailMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractYearsByClientMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractYearsByClientMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractYearsByClientMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractsByYearMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractsByYearMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractsByYearMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSRetentionCertificateByContractMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSRetentionCertificateByContractMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSRetentionCertificateByContractMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSRetentionCertificateByContractDetailMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSRetentionCertificateByContractDetailMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSRetentionCertificateByContractDetailMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSFindContractsByMemberDocumentMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSFindContractsByMemberDocumentMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSFindContractsByMemberDocumentMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSContractYearsByContractMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSContractYearsByContractMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSContractYearsByContractMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPaymentYearsByMemberPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPaymentYearsByMemberPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPaymentYearsByMemberPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSEmployersByMemberPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSEmployersByMemberPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSEmployersByMemberPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPaymentYearsByEmployerMemberPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPaymentYearsByEmployerMemberPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPaymentYearsByEmployerMemberPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPaymentCertificateHeaderPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateHeaderPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateHeaderPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPaymentCertificateDetailForUPCPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateDetailForUPCPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateDetailForUPCPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPaymentCertificateDetailPOS",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateDetailPOSSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPaymentCertificateDetailPOSSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSNoveltyOrNoteDetailMPP",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSNoveltyOrNoteDetailMPPSoapIn), 
            typeof(BizTalkSai_Project.BH.WSNoveltyOrNoteDetailMPPSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPersonOrInstitutionExists",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPersonOrInstitutionExistsSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPersonOrInstitutionExistsSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSPortfolioBalanceByMemberDocumentAndProduct",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSPortfolioBalanceByMemberDocumentAndProductSoapIn), 
            typeof(BizTalkSai_Project.BH.WSPortfolioBalanceByMemberDocumentAndProductSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "WSIncentivesAdministrationSystem",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapIn), 
            typeof(BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapOut)
        },
        new string[]{
        }
    )]
    [Microsoft.XLANGs.BaseTypes.PortTypeAttribute(Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal, "")]
    [System.SerializableAttribute]
    sealed internal class ServiceSoap : Microsoft.BizTalk.XLANGs.BTXEngine.BTXPortBase
    {
        public ServiceSoap(int portInfo, Microsoft.XLANGs.Core.IServiceProxy s)
            : base(portInfo, s)
        { }
        public ServiceSoap(ServiceSoap p)
            : base(p)
        { }

        public override Microsoft.XLANGs.Core.PortBase Clone()
        {
            ServiceSoap p = new ServiceSoap(this);
            return p;
        }

        public static readonly Microsoft.XLANGs.BaseTypes.EXLangSAccess __access = Microsoft.XLANGs.BaseTypes.EXLangSAccess.eInternal;
        #region port reflection support
        static public Microsoft.XLANGs.Core.OperationInfo WSContractsByMemberMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractsByMemberMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractsByMemberMPPSoapIn),
            typeof(WSContractsByMemberMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMembersByContractCodeMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMembersByContractCodeMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMembersByContractCodeMPPSoapIn),
            typeof(WSMembersByContractCodeMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMembersByContractApplicationCodeMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMembersByContractApplicationCodeMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMembersByContractApplicationCodeMPPSoapIn),
            typeof(WSMembersByContractApplicationCodeMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMemberInformationByContractCodeMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMemberInformationByContractCodeMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMemberInformationByContractCodeMPPSoapIn),
            typeof(WSMemberInformationByContractCodeMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMemberInformationByContractApplicationCodeMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMemberInformationByContractApplicationCodeMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMemberInformationByContractApplicationCodeMPPSoapIn),
            typeof(WSMemberInformationByContractApplicationCodeMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSCollectiveContractsByIntermediaryMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSCollectiveContractsByIntermediaryMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSCollectiveContractsByIntermediaryMPPSoapIn),
            typeof(WSCollectiveContractsByIntermediaryMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSSearchSubContractsMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSSearchSubContractsMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSSearchSubContractsMPPSoapIn),
            typeof(WSSearchSubContractsMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSSubContractsByCollectiveContractMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSSubContractsByCollectiveContractMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSSubContractsByCollectiveContractMPPSoapIn),
            typeof(WSSubContractsByCollectiveContractMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractByMemberPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractByMemberPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractByMemberPOSSoapIn),
            typeof(WSContractByMemberPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMembersByContractCodePOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMembersByContractCodePOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMembersByContractCodePOSSoapIn),
            typeof(WSMembersByContractCodePOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMemberInformationByContractCodePOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMemberInformationByContractCodePOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMemberInformationByContractCodePOSSoapIn),
            typeof(WSMemberInformationByContractCodePOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSCollectiveContractsByEmployerMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSCollectiveContractsByEmployerMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSCollectiveContractsByEmployerMPPSoapIn),
            typeof(WSCollectiveContractsByEmployerMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSMembersByEmployerPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSMembersByEmployerPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSMembersByEmployerPOSSoapIn),
            typeof(WSMembersByEmployerPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSFindContractByCodeMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSFindContractByCodeMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSFindContractByCodeMPPSoapIn),
            typeof(WSFindContractByCodeMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractAccountStateHeaderMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractAccountStateHeaderMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractAccountStateHeaderMPPSoapIn),
            typeof(WSContractAccountStateHeaderMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractAccountStateDetailsMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractAccountStateDetailsMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractAccountStateDetailsMPPSoapIn),
            typeof(WSContractAccountStateDetailsMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractAccountStateFooterMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractAccountStateFooterMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractAccountStateFooterMPPSoapIn),
            typeof(WSContractAccountStateFooterMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSIPSCapitaInformation = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSIPSCapitaInformation",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSIPSCapitaInformationSoapIn),
            typeof(WSIPSCapitaInformationSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSInvoiceInformationMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSInvoiceInformationMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSInvoiceInformationMPPSoapIn),
            typeof(WSInvoiceInformationMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSInvoiceInformationDetailMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSInvoiceInformationDetailMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSInvoiceInformationDetailMPPSoapIn),
            typeof(WSInvoiceInformationDetailMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractYearsByClientMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractYearsByClientMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractYearsByClientMPPSoapIn),
            typeof(WSContractYearsByClientMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractsByYearMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractsByYearMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractsByYearMPPSoapIn),
            typeof(WSContractsByYearMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSRetentionCertificateByContractMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSRetentionCertificateByContractMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSRetentionCertificateByContractMPPSoapIn),
            typeof(WSRetentionCertificateByContractMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSRetentionCertificateByContractDetailMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSRetentionCertificateByContractDetailMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSRetentionCertificateByContractDetailMPPSoapIn),
            typeof(WSRetentionCertificateByContractDetailMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSFindContractsByMemberDocumentMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSFindContractsByMemberDocumentMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSFindContractsByMemberDocumentMPPSoapIn),
            typeof(WSFindContractsByMemberDocumentMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSContractYearsByContractMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSContractYearsByContractMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSContractYearsByContractMPPSoapIn),
            typeof(WSContractYearsByContractMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPaymentYearsByMemberPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPaymentYearsByMemberPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPaymentYearsByMemberPOSSoapIn),
            typeof(WSPaymentYearsByMemberPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSEmployersByMemberPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSEmployersByMemberPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSEmployersByMemberPOSSoapIn),
            typeof(WSEmployersByMemberPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPaymentYearsByEmployerMemberPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPaymentYearsByEmployerMemberPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPaymentYearsByEmployerMemberPOSSoapIn),
            typeof(WSPaymentYearsByEmployerMemberPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPaymentCertificateHeaderPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPaymentCertificateHeaderPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPaymentCertificateHeaderPOSSoapIn),
            typeof(WSPaymentCertificateHeaderPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPaymentCertificateDetailForUPCPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPaymentCertificateDetailForUPCPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPaymentCertificateDetailForUPCPOSSoapIn),
            typeof(WSPaymentCertificateDetailForUPCPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPaymentCertificateDetailPOS = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPaymentCertificateDetailPOS",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPaymentCertificateDetailPOSSoapIn),
            typeof(WSPaymentCertificateDetailPOSSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSNoveltyOrNoteDetailMPP = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSNoveltyOrNoteDetailMPP",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSNoveltyOrNoteDetailMPPSoapIn),
            typeof(WSNoveltyOrNoteDetailMPPSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPersonOrInstitutionExists = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPersonOrInstitutionExists",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPersonOrInstitutionExistsSoapIn),
            typeof(WSPersonOrInstitutionExistsSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSPortfolioBalanceByMemberDocumentAndProduct = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSPortfolioBalanceByMemberDocumentAndProduct",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSPortfolioBalanceByMemberDocumentAndProductSoapIn),
            typeof(WSPortfolioBalanceByMemberDocumentAndProductSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public Microsoft.XLANGs.Core.OperationInfo WSIncentivesAdministrationSystem = new Microsoft.XLANGs.Core.OperationInfo
        (
            "WSIncentivesAdministrationSystem",
            System.Web.Services.Description.OperationFlow.RequestResponse,
            typeof(ServiceSoap),
            typeof(WSIncentivesAdministrationSystemSoapIn),
            typeof(WSIncentivesAdministrationSystemSoapOut),
            new System.Type[]{},
            new string[]{}
        );
        static public System.Collections.Hashtable OperationsInformation
        {
            get
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h[ "WSContractsByMemberMPP" ] = WSContractsByMemberMPP;
                h[ "WSMembersByContractCodeMPP" ] = WSMembersByContractCodeMPP;
                h[ "WSMembersByContractApplicationCodeMPP" ] = WSMembersByContractApplicationCodeMPP;
                h[ "WSMemberInformationByContractCodeMPP" ] = WSMemberInformationByContractCodeMPP;
                h[ "WSMemberInformationByContractApplicationCodeMPP" ] = WSMemberInformationByContractApplicationCodeMPP;
                h[ "WSCollectiveContractsByIntermediaryMPP" ] = WSCollectiveContractsByIntermediaryMPP;
                h[ "WSSearchSubContractsMPP" ] = WSSearchSubContractsMPP;
                h[ "WSSubContractsByCollectiveContractMPP" ] = WSSubContractsByCollectiveContractMPP;
                h[ "WSContractByMemberPOS" ] = WSContractByMemberPOS;
                h[ "WSMembersByContractCodePOS" ] = WSMembersByContractCodePOS;
                h[ "WSMemberInformationByContractCodePOS" ] = WSMemberInformationByContractCodePOS;
                h[ "WSCollectiveContractsByEmployerMPP" ] = WSCollectiveContractsByEmployerMPP;
                h[ "WSMembersByEmployerPOS" ] = WSMembersByEmployerPOS;
                h[ "WSFindContractByCodeMPP" ] = WSFindContractByCodeMPP;
                h[ "WSContractAccountStateHeaderMPP" ] = WSContractAccountStateHeaderMPP;
                h[ "WSContractAccountStateDetailsMPP" ] = WSContractAccountStateDetailsMPP;
                h[ "WSContractAccountStateFooterMPP" ] = WSContractAccountStateFooterMPP;
                h[ "WSIPSCapitaInformation" ] = WSIPSCapitaInformation;
                h[ "WSInvoiceInformationMPP" ] = WSInvoiceInformationMPP;
                h[ "WSInvoiceInformationDetailMPP" ] = WSInvoiceInformationDetailMPP;
                h[ "WSContractYearsByClientMPP" ] = WSContractYearsByClientMPP;
                h[ "WSContractsByYearMPP" ] = WSContractsByYearMPP;
                h[ "WSRetentionCertificateByContractMPP" ] = WSRetentionCertificateByContractMPP;
                h[ "WSRetentionCertificateByContractDetailMPP" ] = WSRetentionCertificateByContractDetailMPP;
                h[ "WSFindContractsByMemberDocumentMPP" ] = WSFindContractsByMemberDocumentMPP;
                h[ "WSContractYearsByContractMPP" ] = WSContractYearsByContractMPP;
                h[ "WSPaymentYearsByMemberPOS" ] = WSPaymentYearsByMemberPOS;
                h[ "WSEmployersByMemberPOS" ] = WSEmployersByMemberPOS;
                h[ "WSPaymentYearsByEmployerMemberPOS" ] = WSPaymentYearsByEmployerMemberPOS;
                h[ "WSPaymentCertificateHeaderPOS" ] = WSPaymentCertificateHeaderPOS;
                h[ "WSPaymentCertificateDetailForUPCPOS" ] = WSPaymentCertificateDetailForUPCPOS;
                h[ "WSPaymentCertificateDetailPOS" ] = WSPaymentCertificateDetailPOS;
                h[ "WSNoveltyOrNoteDetailMPP" ] = WSNoveltyOrNoteDetailMPP;
                h[ "WSPersonOrInstitutionExists" ] = WSPersonOrInstitutionExists;
                h[ "WSPortfolioBalanceByMemberDocumentAndProduct" ] = WSPortfolioBalanceByMemberDocumentAndProduct;
                h[ "WSIncentivesAdministrationSystem" ] = WSIncentivesAdministrationSystem;
                return h;
            }
        }
        #endregion // port reflection support
    }

    [Microsoft.XLANGs.BaseTypes.PortTypeOperationAttribute(
        "Operation_1",
        new System.Type[]{
            typeof(BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapIn)
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
            typeof(WSIncentivesAdministrationSystemSoapIn),
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
            typeof(BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapOut)
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
            typeof(WSIncentivesAdministrationSystemSoapOut),
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
    //#line 2493 "C:\Users\CAALBARRACINM\Documents\SAI\Principal-Desarrollo\ColpatriaSAI.IntegracionBiztalk\BH\Service.odx"
    [Microsoft.XLANGs.BaseTypes.StaticSubscriptionAttribute(
        0, "BH_IN", "Operation_1", -1, -1, true
    )]
    [Microsoft.XLANGs.BaseTypes.ServicePortsAttribute(
        new Microsoft.XLANGs.BaseTypes.EXLangSParameter[] {
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eImplements,
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses,
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.ePort|Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        },
        new System.Type[] {
            typeof(BizTalkSai_Project.BH.PortType_1),
            typeof(BizTalkSai_Project.BH.ServiceSoap),
            typeof(BizTalkSai_Project.BH.PortType_2)
        },
        new System.String[] {
            "BH_IN",
            "BH_SERVICE",
            "BH_OUT"
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
    sealed internal class ServiceClient : Microsoft.BizTalk.XLANGs.BTXEngine.BTXService
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
        private static System.Guid _serviceId = Microsoft.XLANGs.Core.HashHelper.HashServiceType(typeof(ServiceClient));
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

        static ServiceClient()
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

            _Locks = 3;
            _rootContext = new __ServiceClient_root_0(this);
            _stateMgrs = new Microsoft.XLANGs.Core.IStateManager[3];
            _stateMgrs[0] = _rootContext;
            FinalConstruct();
        }

        public ServiceClient(System.Guid instanceId, Microsoft.BizTalk.XLANGs.BTXEngine.BTXSession session, Microsoft.BizTalk.XLANGs.BTXEngine.BTXEvents tracker)
            : base(instanceId, session, "ServiceClient", tracker)
        {
            ConstructorHelper();
        }

        public ServiceClient(int callIndex, System.Guid instanceId, Microsoft.BizTalk.XLANGs.BTXEngine.BTXService parent)
            : base(callIndex, instanceId, parent, "ServiceClient")
        {
            ConstructorHelper();
        }

        private const string _symInfo = @"
<XsymFile>
<ProcessFlow xmlns:om='http://schemas.microsoft.com/BizTalk/2003/DesignerData'>      <shapeType>RootShape</shapeType>      <ShapeID>b3a49638-9433-45f2-a262-400c5ca758bc</ShapeID>      
<children>                          
<ShapeInfo>      <shapeType>ReceiveShape</shapeType>      <ShapeID>68313f8a-a7df-49d8-9fc3-562de1ba5747</ShapeID>      <ParentLink>ServiceBody_Statement</ParentLink>                <shapeText>Receive xml in</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>ScopeShape</shapeType>      <ShapeID>e2b90d7c-74cf-4868-b1b1-4be6171fc817</ShapeID>      <ParentLink>ServiceBody_Statement</ParentLink>                <shapeText>ScopeBH</shapeText>                  
<children>                          
<ShapeInfo>      <shapeType>SendShape</shapeType>      <ShapeID>2228e690-82cb-4dd5-92e9-bb223161de12</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Send wsIncentives</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>VariableAssignmentShape</shapeType>      <ShapeID>663c87ee-8afb-4fd9-84a7-a84100225c91</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Mensaje Error Servicio</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>ReceiveShape</shapeType>      <ShapeID>7462a32d-d421-41ba-a09d-9ab82eb5bdfd</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Receive wsIncentives</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>SendShape</shapeType>      <ShapeID>bca39419-f249-4e43-95b2-106e8e81c7b8</ShapeID>      <ParentLink>ComplexStatement_Statement</ParentLink>                <shapeText>Send xml out</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>CatchShape</shapeType>      <ShapeID>92dac415-2aa2-4d8b-994b-0be67ece83ce</ShapeID>      <ParentLink>Scope_Catch</ParentLink>                <shapeText>RespuestaBH</shapeText>                      <ExceptionType>System.Exception</ExceptionType>            
<children>                          
<ShapeInfo>      <shapeType>VariableAssignmentShape</shapeType>      <ShapeID>8717c1e4-248f-4b69-a0f9-9ca0b6c53d46</ShapeID>      <ParentLink>Catch_Statement</ParentLink>                <shapeText>Respuesta BH</shapeText>                  
<children>                </children>
  </ShapeInfo>
                            
<ShapeInfo>      <shapeType>TerminateShape</shapeType>      <ShapeID>01fa43e9-7650-4f01-83b0-e394663ca9bf</ShapeID>      <ParentLink>Catch_Statement</ParentLink>                <shapeText>Terminate</shapeText>                  
<children>                </children>
  </ShapeInfo>
                  </children>
  </ShapeInfo>
                  </children>
  </ShapeInfo>
                  </children>
  </ProcessFlow><Metadata>

<TrkMetadata>
<ActionName>'ServiceClient'</ActionName><IsAtomic>0</IsAtomic><Line>2493</Line><Position>14</Position><ShapeID>'e211a116-cb8b-44e7-a052-0de295aa0001'</ShapeID>
</TrkMetadata>

<TrkMetadata>
<Line>2506</Line><Position>22</Position><ShapeID>'68313f8a-a7df-49d8-9fc3-562de1ba5747'</ShapeID>
<Messages>
	<MsgInfo><name>WsRequestBH</name><part>parameters</part><schema>BizTalkSai_Project.BH.Service_beyondhealth_WebServices+WSIncentivesAdministrationSystem</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<ActionName>'??__scope36'</ActionName><IsAtomic>0</IsAtomic><Line>2508</Line><Position>13</Position><ShapeID>'e2b90d7c-74cf-4868-b1b1-4be6171fc817'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2513</Line><Position>21</Position><ShapeID>'2228e690-82cb-4dd5-92e9-bb223161de12'</ShapeID>
<Messages>
	<MsgInfo><name>WsRequestBH</name><part>parameters</part><schema>BizTalkSai_Project.BH.Service_beyondhealth_WebServices+WSIncentivesAdministrationSystem</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2515</Line><Position>55</Position><ShapeID>'663c87ee-8afb-4fd9-84a7-a84100225c91'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2517</Line><Position>21</Position><ShapeID>'7462a32d-d421-41ba-a09d-9ab82eb5bdfd'</ShapeID>
<Messages>
	<MsgInfo><name>WsResponseBH</name><part>parameters</part><schema>BizTalkSai_Project.BH.Service_beyondhealth_WebServices+WSIncentivesAdministrationSystemResponse</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2519</Line><Position>21</Position><ShapeID>'bca39419-f249-4e43-95b2-106e8e81c7b8'</ShapeID>
<Messages>
	<MsgInfo><name>WsResponseBH</name><part>parameters</part><schema>BizTalkSai_Project.BH.Service_beyondhealth_WebServices+WSIncentivesAdministrationSystemResponse</schema><direction>Out</direction></MsgInfo>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2524</Line><Position>21</Position><ShapeID>'92dac415-2aa2-4d8b-994b-0be67ece83ce'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2527</Line><Position>59</Position><ShapeID>'8717c1e4-248f-4b69-a0f9-9ca0b6c53d46'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>

<TrkMetadata>
<Line>2529</Line><Position>25</Position><ShapeID>'01fa43e9-7650-4f01-83b0-e394663ca9bf'</ShapeID>
<Messages>
</Messages>
</TrkMetadata>
</Metadata>
</XsymFile>";

        public override string odXml { get { return _symODXML; } }

        private const string _symODXML = @"
<?xml version='1.0' encoding='utf-8' standalone='yes'?>
<om:MetaModel MajorVersion='1' MinorVersion='3' Core='2b131234-7959-458d-834f-2dc0769ce683' ScheduleModel='66366196-361d-448d-976f-cab5e87496d2' xmlns:om='http://schemas.microsoft.com/BizTalk/2003/DesignerData'>
    <om:Element Type='Module' OID='dbcb2148-7dab-4b79-b3fd-aa300730e77e' LowerBound='1.1' HigherBound='497.1'>
        <om:Property Name='ReportToAnalyst' Value='True' />
        <om:Property Name='Name' Value='BizTalkSai_Project.BH' />
        <om:Property Name='Signal' Value='False' />
        <om:Element Type='PortType' OID='f041f351-189f-4204-a0a1-fc0657ba3038' ParentLink='Module_PortType' LowerBound='292.1' HigherBound='439.1'>
            <om:Property Name='Synchronous' Value='True' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:portType name=&quot;ServiceSoap&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='ServiceSoap' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='99b8dee4-83ca-47e6-b594-755ed5959602' ParentLink='PortType_OperationDeclaration' LowerBound='294.1' HigherBound='298.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractsByMemberMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.1 Lista los contratos PAS que apliquen para un afiliado (Sea titular o beneficiario)&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractsByMemberMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='f050ff25-5a12-4c8a-8570-481ec969066b' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='296.13' HigherBound='296.41'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractsByMemberMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractsByMemberMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='87532322-cabf-44ab-bbda-d318f823942f' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='296.43' HigherBound='296.72'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractsByMemberMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractsByMemberMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='1024cff8-7bf7-4df8-80ee-daa29ded8ab5' ParentLink='PortType_OperationDeclaration' LowerBound='298.1' HigherBound='302.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMembersByContractCodeMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.2 Lista los Afiliados PAS que apliquen para un contrato. Solo aplica para contratos ya expedidos con un código de contrato&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMembersByContractCodeMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='5302b17b-36bc-4335-a67f-9cd3d013bbf3' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='300.13' HigherBound='300.45'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractCodeMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMembersByContractCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='504fc6cc-579f-4411-82fa-a701af8b7286' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='300.47' HigherBound='300.80'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractCodeMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMembersByContractCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='48801a3f-4f04-4bf2-af29-8cab50de4bcd' ParentLink='PortType_OperationDeclaration' LowerBound='302.1' HigherBound='306.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMembersByContractApplicationCodeMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.3 Lista los Afiliados MPP que apliquen para un contrato por su código de solicitud, puede utilizarse para cuando un contrato no ha sido aún expedido&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMembersByContractApplicationCodeMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='7c44331d-5f3b-4adf-81be-688c59f1faf5' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='304.13' HigherBound='304.56'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractApplicationCodeMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMembersByContractApplicationCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='6dccb676-8554-40fb-8f67-3d007be2259b' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='304.58' HigherBound='304.102'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractApplicationCodeMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMembersByContractApplicationCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='d356c0ad-f247-4a69-8a9e-be76e249181a' ParentLink='PortType_OperationDeclaration' LowerBound='306.1' HigherBound='310.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMemberInformationByContractCodeMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.4 Devuelve la información de un afiliado PAS, recibiendo su número de identificación y su código de contrato&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMemberInformationByContractCodeMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='3d9ee63a-9a31-4772-949f-2712c7ec0249' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='308.13' HigherBound='308.55'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractCodeMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='92bc2664-97e8-49a1-b013-8fce32947bec' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='308.57' HigherBound='308.100'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractCodeMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='a299601e-d03e-47e2-82dc-f6a4953f3fc1' ParentLink='PortType_OperationDeclaration' LowerBound='310.1' HigherBound='314.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMemberInformationByContractApplicationCodeMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.5 Devuelve la información de un afiliado MPP, recibiendo su número de identificación y su código de solicitud de contrato para contratos no expedidos&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMemberInformationByContractApplicationCodeMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='b4eef5af-bdbd-4b10-8325-df1dd4fdee60' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='312.13' HigherBound='312.66'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractApplicationCodeMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractApplicationCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='4c994d27-bdca-422d-bafd-af4403c957b0' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='312.68' HigherBound='312.122'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractApplicationCodeMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractApplicationCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='ad02eeed-7429-45b1-9f8d-c9adbc39c1f7' ParentLink='PortType_OperationDeclaration' LowerBound='314.1' HigherBound='318.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSCollectiveContractsByIntermediaryMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.6 Devuelve la información de los contratos asociativos o colectivos de un asesor, filtrados por vigentes o cancelados&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSCollectiveContractsByIntermediaryMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='6a38a550-5451-42fa-a866-ba12e77653e9' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='316.13' HigherBound='316.57'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSCollectiveContractsByIntermediaryMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSCollectiveContractsByIntermediaryMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='f9accf20-a27c-4232-8662-71022e7c7b70' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='316.59' HigherBound='316.104'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSCollectiveContractsByIntermediaryMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSCollectiveContractsByIntermediaryMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='7eb8a331-9f22-4d14-a097-1df8eed1e58c' ParentLink='PortType_OperationDeclaration' LowerBound='318.1' HigherBound='322.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSSearchSubContractsMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.7 Buscar un subcontrato dentro de un contrato colectivo, un contrato colectivo o un contrato familiar ya sea por primer apellido, número de contrato o número de identificación (Si se reciben los tres parámetros en null, no se devuelve ningún registro, la búsqueda será de tipo “Comienza por”), En el caso de subcontratos o asociativos, se puede ingresar el código del contrato padre para limitar la búsqueda&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSSearchSubContractsMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='a442688e-5cc0-4385-afee-2aa04a9e15d5' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='320.13' HigherBound='320.42'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSSearchSubContractsMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSSearchSubContractsMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='d7a13c18-f8c5-48c8-a4ff-15faf4e009cf' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='320.44' HigherBound='320.74'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSSearchSubContractsMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSSearchSubContractsMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='4ec32ddc-e920-4ebd-8860-79c8b9adfbdb' ParentLink='PortType_OperationDeclaration' LowerBound='322.1' HigherBound='326.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSSubContractsByCollectiveContractMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.8 Devuelve los subcontratos dentro de un contrato colectivo o un contrato asociativo&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSSubContractsByCollectiveContractMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='632e8f32-f6bd-48a5-a83a-fe34a9558bae' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='324.13' HigherBound='324.56'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSSubContractsByCollectiveContractMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSSubContractsByCollectiveContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='f496ee23-5ffa-451e-8474-a3b22dfd21df' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='324.58' HigherBound='324.102'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSSubContractsByCollectiveContractMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSSubContractsByCollectiveContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='b6d63df0-108f-4b45-8c7b-ed0474d35044' ParentLink='PortType_OperationDeclaration' LowerBound='326.1' HigherBound='330.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractByMemberPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.9 Trae el contrato POS que aplique para un afiliado cotizante&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractByMemberPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='c5683fa3-bc49-4592-8020-39fa3e12e48b' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='328.13' HigherBound='328.40'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractByMemberPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='5d4bec6b-4d17-421d-ab56-d3c1bdd7a21d' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='328.42' HigherBound='328.70'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractByMemberPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='7cd8d2d1-7bfa-48dd-ab2e-94315a5dc6e3' ParentLink='PortType_OperationDeclaration' LowerBound='330.1' HigherBound='334.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMembersByContractCodePOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.10 Lista los Afiliados POS que apliquen para un contrato por su código Contrato POS&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMembersByContractCodePOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='012cd741-a6ee-4666-8b5a-67b5a2897365' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='332.13' HigherBound='332.45'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractCodePOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMembersByContractCodePOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='67588e9c-f416-4b19-8da4-e89431207cdc' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='332.47' HigherBound='332.80'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByContractCodePOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMembersByContractCodePOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='da9abe35-a453-4fa6-9255-dd93aa578923' ParentLink='PortType_OperationDeclaration' LowerBound='334.1' HigherBound='338.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMemberInformationByContractCodePOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.11 Devuelve la información de un afiliado POS, recibiendo su número de identificación y su código de contrato&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMemberInformationByContractCodePOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='10e9cd8f-b489-400f-ba94-fb7735857b4e' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='336.13' HigherBound='336.55'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractCodePOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractCodePOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='5cd36492-aa84-44dd-bb63-d040f9d3bf3c' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='336.57' HigherBound='336.100'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMemberInformationByContractCodePOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMemberInformationByContractCodePOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='699971ae-10f5-4d70-9457-b40141f9394b' ParentLink='PortType_OperationDeclaration' LowerBound='338.1' HigherBound='342.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSCollectiveContractsByEmployerMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.13 Devuelve la información de los contratos colectivos de un empleador&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSCollectiveContractsByEmployerMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='82fb038d-8c2d-47ba-9054-7fe9936c489c' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='340.13' HigherBound='340.53'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSCollectiveContractsByEmployerMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSCollectiveContractsByEmployerMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='3af12e46-0e47-4988-bca5-5c4aad6b1af6' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='340.55' HigherBound='340.96'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSCollectiveContractsByEmployerMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSCollectiveContractsByEmployerMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='fe2ed06c-ae07-42a2-ab6b-b56f06996ec8' ParentLink='PortType_OperationDeclaration' LowerBound='342.1' HigherBound='346.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSMembersByEmployerPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.14 Devuelve los cotizantes asociados a un empleador&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSMembersByEmployerPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='41911a6e-42de-4c62-a458-0173e35eaac8' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='344.13' HigherBound='344.41'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByEmployerPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSMembersByEmployerPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='24a6de23-cd4a-415a-8164-d05abc3f59d6' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='344.43' HigherBound='344.72'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSMembersByEmployerPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSMembersByEmployerPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='7f4d4f12-7c0c-42d5-b742-c7a255d58733' ParentLink='PortType_OperationDeclaration' LowerBound='346.1' HigherBound='350.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSFindContractByCodeMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.15 Devuelve la información de un contrato PAS por código (Familiar, subcontrato o contrato colectivo)&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSFindContractByCodeMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='20bfcf37-e839-4a72-a892-73101e9cdc5b' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='348.13' HigherBound='348.42'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSFindContractByCodeMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSFindContractByCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='63f43bef-9a7b-428c-80d6-9cd5be072c37' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='348.44' HigherBound='348.74'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSFindContractByCodeMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSFindContractByCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='218774ba-b98a-41a5-b528-66062724d2ca' ParentLink='PortType_OperationDeclaration' LowerBound='350.1' HigherBound='354.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractAccountStateHeaderMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.16 Devuelve la información del encabezado del estado de cuenta de un contrato MPP&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractAccountStateHeaderMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='f679dab0-c9af-47e9-915b-ae88bb491872' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='352.13' HigherBound='352.50'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateHeaderMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateHeaderMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='06baca23-d4a8-45cb-9cf2-77e26a14ad7c' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='352.52' HigherBound='352.90'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateHeaderMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateHeaderMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='f5098d05-1eb5-4202-8e0c-fc85c4c667a1' ParentLink='PortType_OperationDeclaration' LowerBound='354.1' HigherBound='358.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractAccountStateDetailsMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.17 Devuelve la información del detalle del estado de cuenta de un contrato MPP, basado en las fechas límite&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractAccountStateDetailsMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='717cb91d-1efd-436a-be66-ba30a6b0efa1' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='356.13' HigherBound='356.51'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateDetailsMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateDetailsMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='978ced59-9c1d-4961-a1e1-efaf90dc3268' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='356.53' HigherBound='356.92'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateDetailsMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateDetailsMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='179057a3-d34f-49e4-9dcc-dae9202eee7c' ParentLink='PortType_OperationDeclaration' LowerBound='358.1' HigherBound='362.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractAccountStateFooterMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.18 Devuelve la información final del estado de cuenta de un contrato MPP&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractAccountStateFooterMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='c73e91ea-1720-405b-a7c2-1e45ba2034f3' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='360.13' HigherBound='360.50'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateFooterMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateFooterMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='0a4345f1-7697-498f-ae39-f0d239b308b2' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='360.52' HigherBound='360.90'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractAccountStateFooterMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractAccountStateFooterMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='f6a75c6a-ef86-44cc-92c9-85cbd9a38e5a' ParentLink='PortType_OperationDeclaration' LowerBound='362.1' HigherBound='366.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSIPSCapitaInformation&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.19 Genera un listado sobre el último proceso de capitación de una IPS específica EN UN ARCHIVO, para se ejecutado periódicamente.&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSIPSCapitaInformation' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='ba433be4-17c4-4529-8f14-71f0857363ed' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='364.13' HigherBound='364.41'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIPSCapitaInformationSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSIPSCapitaInformationSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='e24e9597-b9c5-4050-8525-2deec7ab877d' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='364.43' HigherBound='364.72'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIPSCapitaInformationSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSIPSCapitaInformationSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='0ca1a8d5-d078-4eae-af55-230786fb596f' ParentLink='PortType_OperationDeclaration' LowerBound='366.1' HigherBound='370.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSInvoiceInformationMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.20 Genera la información de una factura MPP por afiliado&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSInvoiceInformationMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='6bd4ca25-3e40-4454-96c6-da2c1b1835d8' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='368.13' HigherBound='368.42'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSInvoiceInformationMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSInvoiceInformationMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='351d038f-29e4-4696-bcdb-fdf9a759e638' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='368.44' HigherBound='368.74'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSInvoiceInformationMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSInvoiceInformationMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='64ed7c7d-baa0-4dc1-9f5b-b2bcea75c510' ParentLink='PortType_OperationDeclaration' LowerBound='370.1' HigherBound='374.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSInvoiceInformationDetailMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.21 Genera la el detalle de una factura MPP por afiliado, debe complementar el Web Service 1.20, para mostrar el detalle de una factura&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSInvoiceInformationDetailMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='c4baa139-2aec-4a17-8bf6-4a88945a3e2c' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='372.13' HigherBound='372.48'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSInvoiceInformationDetailMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSInvoiceInformationDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='4a7799eb-00ee-49d7-89d0-eb5a7ccf5253' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='372.50' HigherBound='372.86'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSInvoiceInformationDetailMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSInvoiceInformationDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='d69ca10d-5000-4f26-a689-0db60e51f512' ParentLink='PortType_OperationDeclaration' LowerBound='374.1' HigherBound='378.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractYearsByClientMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.22 Devuelve los años que un afiliado ha sido contratante de MPP en diferentes contratos&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractYearsByClientMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='08404b33-b1e0-450b-b5c4-9357f2971069' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='376.13' HigherBound='376.45'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractYearsByClientMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractYearsByClientMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='a7824708-7389-4897-a7fd-8cb27aa176fd' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='376.47' HigherBound='376.80'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractYearsByClientMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractYearsByClientMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='687cca49-de28-44ac-9e24-2b523de3fa12' ParentLink='PortType_OperationDeclaration' LowerBound='378.1' HigherBound='382.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractsByYearMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.23 Devuelve los contratos que un afiliado ha tenido vigentes en un año específico&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractsByYearMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='34c2e3f4-966f-411e-82cd-344e45c3d785' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='380.13' HigherBound='380.39'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractsByYearMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractsByYearMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='7968756e-8546-4b3a-80b5-9ddb9e360316' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='380.41' HigherBound='380.68'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractsByYearMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractsByYearMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='fbbabaf7-cb9c-4459-809e-bc028a9fd32c' ParentLink='PortType_OperationDeclaration' LowerBound='382.1' HigherBound='386.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSRetentionCertificateByContractMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.24 Devuelve la información del certificado de retención en la fuente para un cliente MPP, en un contrato específico&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSRetentionCertificateByContractMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='56b4b31f-4451-4c26-8f65-d2a8c60c1154' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='384.13' HigherBound='384.54'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSRetentionCertificateByContractMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSRetentionCertificateByContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='1ebe8e0f-402e-4172-999d-becfbcf5f2bd' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='384.56' HigherBound='384.98'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSRetentionCertificateByContractMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSRetentionCertificateByContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='ebb6811c-ba88-4e03-9426-03961ba39e4f' ParentLink='PortType_OperationDeclaration' LowerBound='386.1' HigherBound='390.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSRetentionCertificateByContractDetailMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.25 Devuelve la información del certificado de los beneficiarios y sus pagos para un cliente MPP, en un contrato específico. Complementa el certificado del Web Service 1.24&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSRetentionCertificateByContractDetailMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='ef95888f-c9e0-42cc-b574-e8eb5b2e505b' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='388.13' HigherBound='388.60'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSRetentionCertificateByContractDetailMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSRetentionCertificateByContractDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='f038bef2-11ba-4e1b-b738-0d7e0d31fbb2' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='388.62' HigherBound='388.110'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSRetentionCertificateByContractDetailMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSRetentionCertificateByContractDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='0dabafd7-a859-4a41-b1ac-0db60400a72f' ParentLink='PortType_OperationDeclaration' LowerBound='390.1' HigherBound='394.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSFindContractsByMemberDocumentMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.26 Devuelve la información de los contratos PAS por número de documento de titular&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSFindContractsByMemberDocumentMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='948653b8-d591-4bed-883d-92a0e0e97ffd' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='392.13' HigherBound='392.53'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSFindContractsByMemberDocumentMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSFindContractsByMemberDocumentMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='5be43ba3-f2f2-420c-9657-8e54a99f4a50' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='392.55' HigherBound='392.96'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSFindContractsByMemberDocumentMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSFindContractsByMemberDocumentMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='8af6018a-4b72-4b55-95ce-572ce09d3a04' ParentLink='PortType_OperationDeclaration' LowerBound='394.1' HigherBound='398.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSContractYearsByContractMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.27 Devuelve la años que un afiliado ha sido contratante de MPP por un contrato específico&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSContractYearsByContractMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='45559213-5621-4faa-99cc-e589befa7081' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='396.13' HigherBound='396.47'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractYearsByContractMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSContractYearsByContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='adecf7be-75ba-458b-9276-b7468696fc4d' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='396.49' HigherBound='396.84'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSContractYearsByContractMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSContractYearsByContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='5f1b1a3b-e5a8-4c1b-8334-59ea73bfcb81' ParentLink='PortType_OperationDeclaration' LowerBound='398.1' HigherBound='402.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPaymentYearsByMemberPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.28 Devuelve los años en los cuales un cotizante POS ha realizado pagos, sea por aporte cotizante o por UPC adicional&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPaymentYearsByMemberPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='f14f0be0-cd98-41aa-9ec8-6a8a97805ab8' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='400.13' HigherBound='400.44'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentYearsByMemberPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPaymentYearsByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='d0c35303-2215-4169-9a30-117fb25d94b1' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='400.46' HigherBound='400.78'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentYearsByMemberPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPaymentYearsByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='31fd45ed-26d7-44cf-bb5f-d2d8cf4fb723' ParentLink='PortType_OperationDeclaration' LowerBound='402.1' HigherBound='406.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSEmployersByMemberPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.29 Devuelve los empleadores que ha tenido el cliente POS en su historia.&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSEmployersByMemberPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='be96418b-f9e1-4fb5-ba62-241a9e3ac54e' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='404.13' HigherBound='404.41'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSEmployersByMemberPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSEmployersByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='78986ecc-7839-43de-a12a-ddd49fc0d4f8' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='404.43' HigherBound='404.72'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSEmployersByMemberPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSEmployersByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='c3ef9818-893a-42f3-941a-266f0b7a7177' ParentLink='PortType_OperationDeclaration' LowerBound='406.1' HigherBound='410.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPaymentYearsByEmployerMemberPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.30 Devuelve los años en los que un empleador ha cotizado POS a un afiliado&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPaymentYearsByEmployerMemberPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='1c8e7247-ddeb-40ee-bc6a-96406ed169e8' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='408.13' HigherBound='408.52'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentYearsByEmployerMemberPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPaymentYearsByEmployerMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='5f60ccaa-37d4-404f-81aa-919c51cc8092' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='408.54' HigherBound='408.94'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentYearsByEmployerMemberPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPaymentYearsByEmployerMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='d280ff1c-8956-4eda-a272-060850f00cb0' ParentLink='PortType_OperationDeclaration' LowerBound='410.1' HigherBound='414.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPaymentCertificateHeaderPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.31 Devuelve el encabezado de un certificado de pagos POS, sea por cotizante dependiente, independiente, UPC Adicional o empleador POS&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPaymentCertificateHeaderPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='7e72d716-ee8b-4c9c-ba92-e69aee3e8e0a' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='412.13' HigherBound='412.48'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateHeaderPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateHeaderPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='5b4ceddc-d02f-4dec-b25f-308299e52ef3' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='412.50' HigherBound='412.86'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateHeaderPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateHeaderPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='83e2d40e-3772-492d-a25d-16f4e11d21bc' ParentLink='PortType_OperationDeclaration' LowerBound='414.1' HigherBound='418.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPaymentCertificateDetailForUPCPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.32 Devuelve el detalle de un certificado de pagos POS únicamente para UPC Adicional&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPaymentCertificateDetailForUPCPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='68ac31f6-7e07-4bb9-b971-184db46967bd' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='416.13' HigherBound='416.54'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateDetailForUPCPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateDetailForUPCPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='e5619ae8-140e-468a-8b65-c94cc7441980' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='416.56' HigherBound='416.98'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateDetailForUPCPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateDetailForUPCPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='4d675037-c98f-401a-9964-48a8a58c0126' ParentLink='PortType_OperationDeclaration' LowerBound='418.1' HigherBound='422.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPaymentCertificateDetailPOS&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.33 Devuelve el detalle de un certificado de pagos POS, sea por cotizante dependiente, independiente o empleador POS&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPaymentCertificateDetailPOS' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='d92ec0de-56ee-420d-9d29-3af0b525bca6' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='420.13' HigherBound='420.48'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateDetailPOSSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateDetailPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='d7c5965c-661c-4254-a362-a8a7507853c8' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='420.50' HigherBound='420.86'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPaymentCertificateDetailPOSSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPaymentCertificateDetailPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='2c330bbf-cf61-4294-84d4-2e2b7a079d1f' ParentLink='PortType_OperationDeclaration' LowerBound='422.1' HigherBound='426.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSNoveltyOrNoteDetailMPP&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.34 Devuelve el detalle de una Nota o de una novedad para el estado de cuenta de un contrato Familiar o un Subcontrato&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSNoveltyOrNoteDetailMPP' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='df48b383-9b06-4701-b034-c932c3779049' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='424.13' HigherBound='424.43'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSNoveltyOrNoteDetailMPPSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSNoveltyOrNoteDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='642409ce-dfa0-4ed8-bb0b-7a42833c7294' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='424.45' HigherBound='424.76'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSNoveltyOrNoteDetailMPPSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSNoveltyOrNoteDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='718436e7-70a8-4047-b25c-5543cc5c24eb' ParentLink='PortType_OperationDeclaration' LowerBound='426.1' HigherBound='430.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPersonOrInstitutionExists&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.35 Devuelve si existe una persona o institución por su tipo y número de identificación&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPersonOrInstitutionExists' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='286e439f-da8d-4578-82eb-1c27be08a5dd' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='428.13' HigherBound='428.46'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPersonOrInstitutionExistsSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPersonOrInstitutionExistsSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='fac26aaa-d38c-4e8a-80fc-fbda7c9bc41e' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='428.48' HigherBound='428.82'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPersonOrInstitutionExistsSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPersonOrInstitutionExistsSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='60933413-ad20-48d3-9c4b-c3d5dff0fb65' ParentLink='PortType_OperationDeclaration' LowerBound='430.1' HigherBound='434.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSPortfolioBalanceByMemberDocumentAndProduct&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.36 Devuelve informacion del saldo en cartera de un contrato activo PAS por beneficiario&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSPortfolioBalanceByMemberDocumentAndProduct' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='bbc136d1-a187-4fe3-a6f0-59484b9bd0f7' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='432.13' HigherBound='432.63'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPortfolioBalanceByMemberDocumentAndProductSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSPortfolioBalanceByMemberDocumentAndProductSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='49aa94d0-2e42-4639-bbc6-7c165acaa249' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='432.65' HigherBound='432.116'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSPortfolioBalanceByMemberDocumentAndProductSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSPortfolioBalanceByMemberDocumentAndProductSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='OperationDeclaration' OID='d754881a-63f9-4afe-80c2-1ae3b577461f' ParentLink='PortType_OperationDeclaration' LowerBound='434.1' HigherBound='438.1'>
                <om:Property Name='OperationType' Value='RequestResponse' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:operation name=&quot;WSIncentivesAdministrationSystem&quot;/&gt;&#xD;&#xA;&#xD;&#xA;				1.37 Genera los archivos planos para el sistema de Administración de Incentivos(SAI)&#xD;&#xA;			&#xD;&#xA;' />
                <om:Property Name='Name' Value='WSIncentivesAdministrationSystem' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='5f656cc2-39c5-4239-a9a5-f5a5d9b6e1f4' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='436.13' HigherBound='436.51'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:input message=&quot;http://BeyondHealth/WebServices:WSIncentivesAdministrationSystemSoapIn&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
                <om:Element Type='MessageRef' OID='cfcab533-7be4-4e16-b8ef-320ba3e4699e' ParentLink='OperationDeclaration_ResponseMessageRef' LowerBound='436.53' HigherBound='436.92'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='AnalystComments' Value='&lt;wsdl:output message=&quot;http://BeyondHealth/WebServices:WSIncentivesAdministrationSystemSoapOut&quot;/&gt;&#xD;&#xA;' />
                    <om:Property Name='Name' Value='Response' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='PortType' OID='53438606-c838-40e4-ab70-3f9299f6c08f' ParentLink='Module_PortType' LowerBound='439.1' HigherBound='446.1'>
            <om:Property Name='Synchronous' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='Name' Value='PortType_1' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='76ccd46b-3b30-422a-aa44-19b4d990cf6c' ParentLink='PortType_OperationDeclaration' LowerBound='441.1' HigherBound='445.1'>
                <om:Property Name='OperationType' Value='OneWay' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='Operation_1' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='655a61b9-86d7-4cbe-98e5-71e2556d52f4' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='443.13' HigherBound='443.51'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapIn' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='PortType' OID='2272300d-8fe4-40b1-a4e7-b16235853275' ParentLink='Module_PortType' LowerBound='446.1' HigherBound='453.1'>
            <om:Property Name='Synchronous' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='Name' Value='PortType_2' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='OperationDeclaration' OID='5169bb92-a601-4518-8051-fc20fd9711cc' ParentLink='PortType_OperationDeclaration' LowerBound='448.1' HigherBound='452.1'>
                <om:Property Name='OperationType' Value='OneWay' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='Operation_1' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='MessageRef' OID='8e5cf260-a49a-4a5f-8c3a-6823fd70ca1c' ParentLink='OperationDeclaration_RequestMessageRef' LowerBound='450.13' HigherBound='450.52'>
                    <om:Property Name='Ref' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapOut' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Request' />
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='3effc4de-48b3-4dfa-937a-497990c7dfd3' ParentLink='Module_MessageType' LowerBound='4.1' HigherBound='8.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractsByMemberMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractsByMemberMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='d7499799-1b3e-4062-9e80-d8ee8c7469a6' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='6.1' HigherBound='7.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0996348c-fa12-4c85-9245-2aff7719a456' ParentLink='Module_MessageType' LowerBound='8.1' HigherBound='12.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractsByMemberMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractsByMemberMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='09f2ecc0-f445-4235-b513-13cf830b3805' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='10.1' HigherBound='11.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByMemberMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='53365bfb-7948-4c8e-a8bf-859602bcd0b3' ParentLink='Module_MessageType' LowerBound='12.1' HigherBound='16.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractCodeMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='8cf03988-6998-44b0-a0c4-3cc874ac638d' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='14.1' HigherBound='15.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='e24b05f4-595c-434f-8d03-952e31f42a05' ParentLink='Module_MessageType' LowerBound='16.1' HigherBound='20.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractCodeMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0984a299-3533-4c80-a5fd-0c912b5c25c8' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='18.1' HigherBound='19.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodeMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='39306974-6473-4147-8ba3-3729fcda0edf' ParentLink='Module_MessageType' LowerBound='20.1' HigherBound='24.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractApplicationCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractApplicationCodeMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='1939ad6f-a7bc-4e68-8891-8141dfa82359' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='22.1' HigherBound='23.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='5d94c5de-2a67-4405-af58-b8366686a8bb' ParentLink='Module_MessageType' LowerBound='24.1' HigherBound='28.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractApplicationCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractApplicationCodeMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='efcbf6a4-c635-47ac-8e8e-a158e82cf0d3' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='26.1' HigherBound='27.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractApplicationCodeMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='2e731cc5-5330-4547-803a-4dc35cf6a383' ParentLink='Module_MessageType' LowerBound='28.1' HigherBound='32.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractCodeMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='1bc636a7-b490-4fb4-8ce8-489f3decdf5a' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='30.1' HigherBound='31.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='6761b32e-a589-4d96-97cc-ecc07aebfe87' ParentLink='Module_MessageType' LowerBound='32.1' HigherBound='36.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractCodeMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='89e0fb1b-b587-44a4-a43d-f31b0daa6185' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='34.1' HigherBound='35.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodeMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f11a27fe-0905-4248-a67a-bab9a1696552' ParentLink='Module_MessageType' LowerBound='36.1' HigherBound='40.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractApplicationCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractApplicationCodeMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='556154d1-ae37-49d2-a922-cf4d8985fee7' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='38.1' HigherBound='39.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='4a741cab-2d10-4100-a043-6c2de2073a1c' ParentLink='Module_MessageType' LowerBound='40.1' HigherBound='44.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractApplicationCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractApplicationCodeMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='e9b3bde9-f316-4689-92d3-e67066bdead1' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='42.1' HigherBound='43.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractApplicationCodeMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='ead106e8-a889-4c35-bc3b-6757e2dfdc6f' ParentLink='Module_MessageType' LowerBound='44.1' HigherBound='48.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSCollectiveContractsByIntermediaryMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSCollectiveContractsByIntermediaryMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='d7747f78-9c9a-403e-a224-86b416d2b45e' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='46.1' HigherBound='47.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='c9e7ba84-581b-49b0-ac7f-3f92bb8abfab' ParentLink='Module_MessageType' LowerBound='48.1' HigherBound='52.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSCollectiveContractsByIntermediaryMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSCollectiveContractsByIntermediaryMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='47d3ecd8-8cf1-4280-a176-038b75790602' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='50.1' HigherBound='51.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByIntermediaryMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='02bcc863-988e-4349-9a7c-f6a88b121efe' ParentLink='Module_MessageType' LowerBound='52.1' HigherBound='56.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSSearchSubContractsMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSSearchSubContractsMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='10b2d752-df7d-43f1-bad4-213a53105e98' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='54.1' HigherBound='55.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='a70c8472-fdb3-4110-b19f-82805c96f8f1' ParentLink='Module_MessageType' LowerBound='56.1' HigherBound='60.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSSearchSubContractsMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSSearchSubContractsMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='2529cf1b-ccb3-4052-a2c5-84f986e10333' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='58.1' HigherBound='59.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSearchSubContractsMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f90ec544-c614-44dd-8c2b-7a77fff7ebab' ParentLink='Module_MessageType' LowerBound='60.1' HigherBound='64.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSSubContractsByCollectiveContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSSubContractsByCollectiveContractMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='e738eff6-4ea6-4cdd-84a5-d7304017dc74' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='62.1' HigherBound='63.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0c4807c3-b418-4933-9e78-c68dadbed84b' ParentLink='Module_MessageType' LowerBound='64.1' HigherBound='68.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSSubContractsByCollectiveContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSSubContractsByCollectiveContractMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='2d9a9ee3-8ab0-4321-b661-4e9a09c1cbf6' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='66.1' HigherBound='67.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSSubContractsByCollectiveContractMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='640acfdd-5b85-4d0a-8324-075087dbe751' ParentLink='Module_MessageType' LowerBound='68.1' HigherBound='72.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractByMemberPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='e462ee8a-2d0f-49eb-b6a8-b44ce634008f' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='70.1' HigherBound='71.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='4cc881a4-8ffa-4f34-bca2-893f3e123aa7' ParentLink='Module_MessageType' LowerBound='72.1' HigherBound='76.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractByMemberPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='a2db7341-c796-4c5c-a8df-4bdfa2f8e432' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='74.1' HigherBound='75.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractByMemberPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='b004fe73-1c8c-40de-aafe-264f4eeee417' ParentLink='Module_MessageType' LowerBound='76.1' HigherBound='80.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractCodePOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractCodePOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='9f1c5599-aafd-47bb-bd73-ae27f0bafdd7' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='78.1' HigherBound='79.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='91b5044b-f7bc-4e27-9c6b-c7393826f70d' ParentLink='Module_MessageType' LowerBound='80.1' HigherBound='84.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByContractCodePOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByContractCodePOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0bc671a6-da93-48ab-8129-85ae483b30d3' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='82.1' HigherBound='83.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByContractCodePOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='69baa663-0dd6-4915-8263-a5e2fd227a3a' ParentLink='Module_MessageType' LowerBound='84.1' HigherBound='88.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractCodePOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractCodePOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='d90bc88d-3a15-40bf-9318-96a25b311c0a' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='86.1' HigherBound='87.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='fef5afb7-a8b2-461f-849a-3bf241550bc0' ParentLink='Module_MessageType' LowerBound='88.1' HigherBound='92.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMemberInformationByContractCodePOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMemberInformationByContractCodePOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='41ff2a06-b1e9-47e2-aad7-050c12bc5534' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='90.1' HigherBound='91.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMemberInformationByContractCodePOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='67138209-0a09-4643-ad2f-cea3cfb0d20c' ParentLink='Module_MessageType' LowerBound='92.1' HigherBound='96.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSCollectiveContractsByEmployerMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSCollectiveContractsByEmployerMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='e00ec058-81ff-4d7c-9f1e-5e8c310d0957' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='94.1' HigherBound='95.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='645e448d-7596-4c6c-b7fb-792aa94d6de5' ParentLink='Module_MessageType' LowerBound='96.1' HigherBound='100.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSCollectiveContractsByEmployerMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSCollectiveContractsByEmployerMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0da773ca-8f21-4920-b038-a2b09334c75e' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='98.1' HigherBound='99.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSCollectiveContractsByEmployerMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='33aefd35-9130-470b-838a-0d58e6fc169d' ParentLink='Module_MessageType' LowerBound='100.1' HigherBound='104.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByEmployerPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByEmployerPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='4c413505-4146-49af-bb73-f27b1751fc58' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='102.1' HigherBound='103.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='7d4d02fe-c34d-4652-ba1c-a1ef771fe638' ParentLink='Module_MessageType' LowerBound='104.1' HigherBound='108.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSMembersByEmployerPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSMembersByEmployerPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='ffead6d9-af59-4856-9bc0-bc45ba4b8096' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='106.1' HigherBound='107.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSMembersByEmployerPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='b621fbfc-1267-4f1a-8f42-cb1651dbce16' ParentLink='Module_MessageType' LowerBound='108.1' HigherBound='112.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSFindContractByCodeMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSFindContractByCodeMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='8dc2a127-296b-4223-a377-3f285ddded57' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='110.1' HigherBound='111.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='53399c65-da89-4d31-a228-5f59fd429c6d' ParentLink='Module_MessageType' LowerBound='112.1' HigherBound='116.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSFindContractByCodeMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSFindContractByCodeMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='70e8efcb-a890-409e-ac4f-84fa2f0a8d4d' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='114.1' HigherBound='115.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractByCodeMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='52d34dc6-7a9b-4cb3-833f-df7aedc2d1f9' ParentLink='Module_MessageType' LowerBound='116.1' HigherBound='120.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateHeaderMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateHeaderMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='ff47dacd-1307-4456-bddc-8279ccf42dc4' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='118.1' HigherBound='119.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0eaa9d0c-c975-4990-a4ee-bac7015a810c' ParentLink='Module_MessageType' LowerBound='120.1' HigherBound='124.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateHeaderMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateHeaderMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0b1a678d-2abe-4be5-9f10-a16f0859292b' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='122.1' HigherBound='123.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateHeaderMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='5fe74743-ea26-496c-95dd-3288bdba1ae0' ParentLink='Module_MessageType' LowerBound='124.1' HigherBound='128.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateDetailsMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateDetailsMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='17d43adb-1999-439e-993d-33141c25fa07' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='126.1' HigherBound='127.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='4769eec7-291d-476e-88b5-c85532d6ff22' ParentLink='Module_MessageType' LowerBound='128.1' HigherBound='132.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateDetailsMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateDetailsMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='f34eaf6b-39c0-4fe0-b6cc-db3091f372ea' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='130.1' HigherBound='131.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateDetailsMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='24d32a14-6d9b-4c67-909b-3419de7f5f87' ParentLink='Module_MessageType' LowerBound='132.1' HigherBound='136.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateFooterMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateFooterMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='4a4a767d-b9c7-4e42-9163-ba1d390367d3' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='134.1' HigherBound='135.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='3ebc79e9-a5fc-43da-8f58-1235285613b1' ParentLink='Module_MessageType' LowerBound='136.1' HigherBound='140.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractAccountStateFooterMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractAccountStateFooterMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='b0e9b429-91f5-4471-b5e5-7641592aefa6' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='138.1' HigherBound='139.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractAccountStateFooterMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f9acbcf3-d565-487a-bea6-e8a65e25e75c' ParentLink='Module_MessageType' LowerBound='140.1' HigherBound='144.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSIPSCapitaInformationSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSIPSCapitaInformationSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='0cf0c33f-889b-4266-907a-b4a2e568b614' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='142.1' HigherBound='143.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformation' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='3860df1a-378d-4461-8b35-fb00de9e7c4b' ParentLink='Module_MessageType' LowerBound='144.1' HigherBound='148.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSIPSCapitaInformationSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSIPSCapitaInformationSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='fec1b636-4cb8-46a9-bba0-1b1cc3c6b898' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='146.1' HigherBound='147.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIPSCapitaInformationResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='426b8dec-2f99-4f2f-a46c-d08b88300470' ParentLink='Module_MessageType' LowerBound='148.1' HigherBound='152.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSInvoiceInformationMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSInvoiceInformationMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='fcc4e0cf-bfda-44eb-8519-eec2e4c76fc4' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='150.1' HigherBound='151.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='9730cd9d-6f84-4479-8af1-5f0d0db5ae93' ParentLink='Module_MessageType' LowerBound='152.1' HigherBound='156.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSInvoiceInformationMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSInvoiceInformationMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='fc485a97-c640-4e32-9ecd-be193cc4a928' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='154.1' HigherBound='155.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f64e54e1-4df1-440a-ac49-317de16b6341' ParentLink='Module_MessageType' LowerBound='156.1' HigherBound='160.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSInvoiceInformationDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSInvoiceInformationDetailMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='6e7284a5-9859-49d1-a306-4044b734bb17' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='158.1' HigherBound='159.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='870c4ada-dc9c-421f-a177-bcc2f20b084e' ParentLink='Module_MessageType' LowerBound='160.1' HigherBound='164.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSInvoiceInformationDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSInvoiceInformationDetailMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='72a889f0-c882-4dfa-aa86-c88444c12853' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='162.1' HigherBound='163.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSInvoiceInformationDetailMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='623e0117-06ad-4d99-930f-ae27514760a4' ParentLink='Module_MessageType' LowerBound='164.1' HigherBound='168.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractYearsByClientMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractYearsByClientMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='f7b1069d-0223-429c-9658-8b69d0c2b8fc' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='166.1' HigherBound='167.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='141da415-224f-497a-b462-0cfbb45e51e6' ParentLink='Module_MessageType' LowerBound='168.1' HigherBound='172.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractYearsByClientMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractYearsByClientMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='b3188105-5b47-418f-a82d-f94d06cf8967' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='170.1' HigherBound='171.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByClientMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='84230e79-a853-4ef5-a8a1-3be3b2d778f4' ParentLink='Module_MessageType' LowerBound='172.1' HigherBound='176.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractsByYearMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractsByYearMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='33030822-65b1-424e-acf8-a8a303eef830' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='174.1' HigherBound='175.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='b70b0cef-2924-4640-a1c0-921ac692d43b' ParentLink='Module_MessageType' LowerBound='176.1' HigherBound='180.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractsByYearMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractsByYearMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='705998de-c8d6-4eee-a0e7-79fec4bbfad7' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='178.1' HigherBound='179.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractsByYearMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='25a13341-0e77-47d4-91a6-2d567ff0c6da' ParentLink='Module_MessageType' LowerBound='180.1' HigherBound='184.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSRetentionCertificateByContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSRetentionCertificateByContractMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='43ffd254-288e-408e-a991-980c309d2790' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='182.1' HigherBound='183.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='f06c35fb-af7d-40b9-9a64-ff2bafd8eb50' ParentLink='Module_MessageType' LowerBound='184.1' HigherBound='188.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSRetentionCertificateByContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSRetentionCertificateByContractMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='96d4d6dc-b4b0-4df0-904a-cc6e60c3a962' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='186.1' HigherBound='187.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='6e18e6c2-de9a-44d9-a4f3-dc89004a7981' ParentLink='Module_MessageType' LowerBound='188.1' HigherBound='192.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSRetentionCertificateByContractDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSRetentionCertificateByContractDetailMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='366b2983-6d41-4a0d-be6a-bf0e8cc3c58d' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='190.1' HigherBound='191.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='60df8acf-3db5-4b3b-82c9-b82f3ec43685' ParentLink='Module_MessageType' LowerBound='192.1' HigherBound='196.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSRetentionCertificateByContractDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSRetentionCertificateByContractDetailMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='4cd9d411-3619-4606-b828-c9d6b973a3f3' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='194.1' HigherBound='195.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSRetentionCertificateByContractDetailMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='abc26222-7f4c-44d1-a98e-4a95f7cb7f1f' ParentLink='Module_MessageType' LowerBound='196.1' HigherBound='200.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSFindContractsByMemberDocumentMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSFindContractsByMemberDocumentMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='9e6e3ac2-0f9e-44d2-af3d-a3106f645d76' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='198.1' HigherBound='199.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='77786ccf-e445-40ca-b7b1-a95f45c67159' ParentLink='Module_MessageType' LowerBound='200.1' HigherBound='204.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSFindContractsByMemberDocumentMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSFindContractsByMemberDocumentMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='ed7986cb-36db-4dc5-af1e-6b0acb1207a8' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='202.1' HigherBound='203.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSFindContractsByMemberDocumentMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='9cc38fda-0297-4aaf-afed-be799f36847a' ParentLink='Module_MessageType' LowerBound='204.1' HigherBound='208.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractYearsByContractMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractYearsByContractMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='9402d866-a4c7-4c08-a3f3-fa4fb7d4b4c2' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='206.1' HigherBound='207.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='af3dfe4c-387b-4f24-8808-178dced91aae' ParentLink='Module_MessageType' LowerBound='208.1' HigherBound='212.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSContractYearsByContractMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSContractYearsByContractMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='9f944654-aa52-41cd-8b85-a103a74749d5' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='210.1' HigherBound='211.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSContractYearsByContractMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='42193466-e610-441b-aeee-e1695350f7c2' ParentLink='Module_MessageType' LowerBound='212.1' HigherBound='216.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentYearsByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentYearsByMemberPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='4e6d72cf-a16c-4f96-b1e0-2120c5c4bffd' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='214.1' HigherBound='215.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='bf019f0f-cc80-4815-a903-6770ce089f3d' ParentLink='Module_MessageType' LowerBound='216.1' HigherBound='220.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentYearsByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentYearsByMemberPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='fd9deeca-5498-478b-94dc-12fc4541788b' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='218.1' HigherBound='219.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByMemberPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='87968339-bee8-4868-9184-e43ec4e41865' ParentLink='Module_MessageType' LowerBound='220.1' HigherBound='224.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSEmployersByMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSEmployersByMemberPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='4d087197-be3b-4508-aac9-2f018b7d586b' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='222.1' HigherBound='223.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='352f8b79-3029-4be6-a8ec-456e95b6790a' ParentLink='Module_MessageType' LowerBound='224.1' HigherBound='228.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSEmployersByMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSEmployersByMemberPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='b22a1865-0919-4c35-8b19-65c39bf02256' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='226.1' HigherBound='227.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSEmployersByMemberPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='87c9150e-ff6f-4e25-a33f-68fb3117df65' ParentLink='Module_MessageType' LowerBound='228.1' HigherBound='232.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentYearsByEmployerMemberPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentYearsByEmployerMemberPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='31146ef0-c9aa-4f63-9da5-4d5d6b5959db' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='230.1' HigherBound='231.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='c483cb85-7a56-4e25-8a7e-ec2ada9d6fb3' ParentLink='Module_MessageType' LowerBound='232.1' HigherBound='236.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentYearsByEmployerMemberPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentYearsByEmployerMemberPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='6281963f-ee46-4ed5-adcf-0e9d1a70bad8' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='234.1' HigherBound='235.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentYearsByEmployerMemberPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='d6495f45-3ebb-40fd-9104-a20d9b21c1e1' ParentLink='Module_MessageType' LowerBound='236.1' HigherBound='240.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateHeaderPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateHeaderPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='d232a4da-7856-4eb6-8c48-8750c8a20934' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='238.1' HigherBound='239.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='dd2b6bab-7d76-4b9c-8208-40cd58652b3a' ParentLink='Module_MessageType' LowerBound='240.1' HigherBound='244.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateHeaderPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateHeaderPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='aac589ea-b410-432d-9ca4-6bee311f55d9' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='242.1' HigherBound='243.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateHeaderPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='af9df4dd-8a57-498b-891c-2d9501984b71' ParentLink='Module_MessageType' LowerBound='244.1' HigherBound='248.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateDetailForUPCPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateDetailForUPCPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='62f1c0f8-882c-4c77-8977-6697a6a92ef2' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='246.1' HigherBound='247.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='b65e866a-6bcd-4bd7-8010-fbf1b8b7640d' ParentLink='Module_MessageType' LowerBound='248.1' HigherBound='252.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateDetailForUPCPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateDetailForUPCPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='bcf29d55-87fc-4a2e-89c8-c8e03eebbe16' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='250.1' HigherBound='251.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailForUPCPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='fb09dcc3-3625-4bd3-8265-b3090b1e6ddd' ParentLink='Module_MessageType' LowerBound='252.1' HigherBound='256.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateDetailPOSSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateDetailPOSSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='8b0a2b1d-2dcf-463c-bc67-95fca9f917fe' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='254.1' HigherBound='255.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOS' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0a18df3f-0790-4738-be00-3cf9321e66c7' ParentLink='Module_MessageType' LowerBound='256.1' HigherBound='260.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPaymentCertificateDetailPOSSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPaymentCertificateDetailPOSSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='96e4727f-fe1e-400c-bd6a-3ff4b2649a5b' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='258.1' HigherBound='259.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPaymentCertificateDetailPOSResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='5e864f6a-6957-42d4-bacf-284853558265' ParentLink='Module_MessageType' LowerBound='260.1' HigherBound='264.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSNoveltyOrNoteDetailMPPSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSNoveltyOrNoteDetailMPPSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='a015180d-2246-430b-86c1-e1e89ccb064e' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='262.1' HigherBound='263.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPP' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='8d6e9c08-c91b-4eef-8d60-e6238fc390cb' ParentLink='Module_MessageType' LowerBound='264.1' HigherBound='268.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSNoveltyOrNoteDetailMPPSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSNoveltyOrNoteDetailMPPSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='31ee98b9-1c43-4ddc-86b0-815aaffcc247' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='266.1' HigherBound='267.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSNoveltyOrNoteDetailMPPResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='a54de620-d501-4fa8-a735-bfb304397e27' ParentLink='Module_MessageType' LowerBound='268.1' HigherBound='272.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPersonOrInstitutionExistsSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPersonOrInstitutionExistsSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='bd396d9e-0362-4f4d-aafd-79109281ab8e' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='270.1' HigherBound='271.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExists' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='9711a0ff-2400-482c-9776-63a1dc3a6904' ParentLink='Module_MessageType' LowerBound='272.1' HigherBound='276.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPersonOrInstitutionExistsSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPersonOrInstitutionExistsSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='c2994aad-e3b3-4a93-b6c3-21c74667c28c' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='274.1' HigherBound='275.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPersonOrInstitutionExistsResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0e3f95c8-fd51-480b-80ea-639a4bfbbd7f' ParentLink='Module_MessageType' LowerBound='276.1' HigherBound='280.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPortfolioBalanceByMemberDocumentAndProductSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPortfolioBalanceByMemberDocumentAndProductSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='04cd5fe7-219b-442f-a402-3092e6788651' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='278.1' HigherBound='279.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProduct' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='5374b183-a178-43be-b353-e6e33af9df89' ParentLink='Module_MessageType' LowerBound='280.1' HigherBound='284.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSPortfolioBalanceByMemberDocumentAndProductSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSPortfolioBalanceByMemberDocumentAndProductSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='3a44168b-cbf8-437d-acf5-deac8835a8a4' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='282.1' HigherBound='283.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSPortfolioBalanceByMemberDocumentAndProductResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='0ab14672-2b5f-4d7f-a6e4-00261222aa93' ParentLink='Module_MessageType' LowerBound='284.1' HigherBound='288.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSIncentivesAdministrationSystemSoapIn&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSIncentivesAdministrationSystemSoapIn' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='707d763e-f5d6-4581-be02-8afd861e7f0f' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='286.1' HigherBound='287.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystem' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='MultipartMessageType' OID='8961437a-8dbb-42ac-8a5f-19982a8cd2bb' ParentLink='Module_MessageType' LowerBound='288.1' HigherBound='292.1'>
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:message name=&quot;WSIncentivesAdministrationSystemSoapOut&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='WSIncentivesAdministrationSystemSoapOut' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='PartDeclaration' OID='f7b7d19e-c0d9-4634-9fe9-2ecf27dcb228' ParentLink='MultipartMessageType_PartDeclaration' LowerBound='290.1' HigherBound='291.1'>
                <om:Property Name='ClassName' Value='BizTalkSai_Project.BH.Service_beyondhealth_WebServices.WSIncentivesAdministrationSystemResponse' />
                <om:Property Name='IsBodyPart' Value='True' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='AnalystComments' Value='&lt;wsdl:part name=&quot;parameters&quot;/&gt;&#xD;&#xA;' />
                <om:Property Name='Name' Value='parameters' />
                <om:Property Name='Signal' Value='False' />
            </om:Element>
        </om:Element>
        <om:Element Type='ServiceDeclaration' OID='b33412e7-96c1-454b-a888-2cf2e66dc8d2' ParentLink='Module_ServiceDeclaration' LowerBound='453.1' HigherBound='496.1'>
            <om:Property Name='InitializedTransactionType' Value='False' />
            <om:Property Name='IsInvokable' Value='False' />
            <om:Property Name='TypeModifier' Value='Internal' />
            <om:Property Name='ReportToAnalyst' Value='True' />
            <om:Property Name='AnalystComments' Value='&lt;wsdl:service name=&quot;Service&quot;/&gt;&#xD;&#xA;' />
            <om:Property Name='Name' Value='ServiceClient' />
            <om:Property Name='Signal' Value='False' />
            <om:Element Type='MessageDeclaration' OID='8223ea9b-3cd9-4775-9d3f-ad5f862658f0' ParentLink='ServiceDeclaration_MessageDeclaration' LowerBound='462.1' HigherBound='463.1'>
                <om:Property Name='Type' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapIn' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='WsRequestBH' />
                <om:Property Name='Signal' Value='True' />
            </om:Element>
            <om:Element Type='MessageDeclaration' OID='9effb41d-a05b-40b2-b98e-fd26593c551b' ParentLink='ServiceDeclaration_MessageDeclaration' LowerBound='463.1' HigherBound='464.1'>
                <om:Property Name='Type' Value='BizTalkSai_Project.BH.WSIncentivesAdministrationSystemSoapOut' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='WsResponseBH' />
                <om:Property Name='Signal' Value='True' />
            </om:Element>
            <om:Element Type='ServiceBody' OID='b3a49638-9433-45f2-a262-400c5ca758bc' ParentLink='ServiceDeclaration_ServiceBody'>
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='Receive' OID='68313f8a-a7df-49d8-9fc3-562de1ba5747' ParentLink='ServiceBody_Statement' LowerBound='466.1' HigherBound='468.1'>
                    <om:Property Name='Activate' Value='True' />
                    <om:Property Name='PortName' Value='BH_IN' />
                    <om:Property Name='MessageName' Value='WsRequestBH' />
                    <om:Property Name='OperationName' Value='Operation_1' />
                    <om:Property Name='OperationMessageName' Value='Request' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='Receive xml in' />
                    <om:Property Name='Signal' Value='True' />
                </om:Element>
                <om:Element Type='Scope' OID='e2b90d7c-74cf-4868-b1b1-4be6171fc817' ParentLink='ServiceBody_Statement' LowerBound='468.1' HigherBound='494.1'>
                    <om:Property Name='InitializedTransactionType' Value='True' />
                    <om:Property Name='IsSynchronized' Value='True' />
                    <om:Property Name='ReportToAnalyst' Value='True' />
                    <om:Property Name='Name' Value='ScopeBH' />
                    <om:Property Name='Signal' Value='True' />
                    <om:Element Type='Send' OID='2228e690-82cb-4dd5-92e9-bb223161de12' ParentLink='ComplexStatement_Statement' LowerBound='473.1' HigherBound='475.1'>
                        <om:Property Name='PortName' Value='BH_SERVICE' />
                        <om:Property Name='MessageName' Value='WsRequestBH' />
                        <om:Property Name='OperationName' Value='WSIncentivesAdministrationSystem' />
                        <om:Property Name='OperationMessageName' Value='Request' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Send wsIncentives' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='VariableAssignment' OID='663c87ee-8afb-4fd9-84a7-a84100225c91' ParentLink='ComplexStatement_Statement' LowerBound='475.1' HigherBound='477.1'>
                        <om:Property Name='Expression' Value='System.Diagnostics.Trace.WriteLine(&quot;Inicia llamado a wsIncentivesAdministration&quot;);' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Mensaje Error Servicio' />
                        <om:Property Name='Signal' Value='False' />
                    </om:Element>
                    <om:Element Type='Receive' OID='7462a32d-d421-41ba-a09d-9ab82eb5bdfd' ParentLink='ComplexStatement_Statement' LowerBound='477.1' HigherBound='479.1'>
                        <om:Property Name='Activate' Value='False' />
                        <om:Property Name='PortName' Value='BH_SERVICE' />
                        <om:Property Name='MessageName' Value='WsResponseBH' />
                        <om:Property Name='OperationName' Value='WSIncentivesAdministrationSystem' />
                        <om:Property Name='OperationMessageName' Value='Response' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Receive wsIncentives' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='Send' OID='bca39419-f249-4e43-95b2-106e8e81c7b8' ParentLink='ComplexStatement_Statement' LowerBound='479.1' HigherBound='481.1'>
                        <om:Property Name='PortName' Value='BH_OUT' />
                        <om:Property Name='MessageName' Value='WsResponseBH' />
                        <om:Property Name='OperationName' Value='Operation_1' />
                        <om:Property Name='OperationMessageName' Value='Request' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='Name' Value='Send xml out' />
                        <om:Property Name='Signal' Value='True' />
                    </om:Element>
                    <om:Element Type='Catch' OID='92dac415-2aa2-4d8b-994b-0be67ece83ce' ParentLink='Scope_Catch' LowerBound='484.1' HigherBound='492.1'>
                        <om:Property Name='ExceptionName' Value='ex' />
                        <om:Property Name='ExceptionType' Value='System.Exception' />
                        <om:Property Name='IsFaultMessage' Value='False' />
                        <om:Property Name='ReportToAnalyst' Value='True' />
                        <om:Property Name='AnalystComments' Value='Capturar Excepcion General' />
                        <om:Property Name='Name' Value='RespuestaBH' />
                        <om:Property Name='Signal' Value='True' />
                        <om:Element Type='VariableAssignment' OID='8717c1e4-248f-4b69-a0f9-9ca0b6c53d46' ParentLink='Catch_Statement' LowerBound='487.1' HigherBound='489.1'>
                            <om:Property Name='Expression' Value='System.Diagnostics.Trace.WriteLine(&quot;Respuesta BH&quot;);' />
                            <om:Property Name='ReportToAnalyst' Value='True' />
                            <om:Property Name='Name' Value='Respuesta BH' />
                            <om:Property Name='Signal' Value='True' />
                        </om:Element>
                        <om:Element Type='Terminate' OID='01fa43e9-7650-4f01-83b0-e394663ca9bf' ParentLink='Catch_Statement' LowerBound='489.1' HigherBound='491.1'>
                            <om:Property Name='ErrorMessage' Value='&quot;Fin de la orquestacion Crear Orden con Error &quot; + ex.Message;' />
                            <om:Property Name='ReportToAnalyst' Value='True' />
                            <om:Property Name='Name' Value='Terminate' />
                            <om:Property Name='Signal' Value='True' />
                        </om:Element>
                    </om:Element>
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='ff908b8c-dccf-4184-8245-3a1ae65126b5' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='456.1' HigherBound='458.1'>
                <om:Property Name='PortModifier' Value='Uses' />
                <om:Property Name='Orientation' Value='Right' />
                <om:Property Name='PortIndex' Value='-1' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.BH.ServiceSoap' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='BH_SERVICE' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='ad96ed71-fbd2-4263-a622-fa39ace9f8d4' ParentLink='PortDeclaration_CLRAttribute' LowerBound='456.1' HigherBound='457.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='0ddbdca3-c110-45e6-88b8-f884864c97d4' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='458.1' HigherBound='460.1'>
                <om:Property Name='PortModifier' Value='Uses' />
                <om:Property Name='Orientation' Value='Left' />
                <om:Property Name='PortIndex' Value='12' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.BH.PortType_2' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='BH_OUT' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='dddf51df-881d-4ce8-b037-0126bf3d9ce5' ParentLink='PortDeclaration_CLRAttribute' LowerBound='458.1' HigherBound='459.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
            <om:Element Type='PortDeclaration' OID='5e8f1cbf-71b6-4632-b59d-56fd2b7d58b2' ParentLink='ServiceDeclaration_PortDeclaration' LowerBound='460.1' HigherBound='462.1'>
                <om:Property Name='PortModifier' Value='Implements' />
                <om:Property Name='Orientation' Value='Left' />
                <om:Property Name='PortIndex' Value='0' />
                <om:Property Name='IsWebPort' Value='False' />
                <om:Property Name='OrderedDelivery' Value='False' />
                <om:Property Name='DeliveryNotification' Value='None' />
                <om:Property Name='Type' Value='BizTalkSai_Project.BH.PortType_1' />
                <om:Property Name='ParamDirection' Value='In' />
                <om:Property Name='ReportToAnalyst' Value='True' />
                <om:Property Name='Name' Value='BH_IN' />
                <om:Property Name='Signal' Value='False' />
                <om:Element Type='LogicalBindingAttribute' OID='c5a0e8f2-4801-453d-a0d6-b4777ec2d696' ParentLink='PortDeclaration_CLRAttribute' LowerBound='460.1' HigherBound='461.1'>
                    <om:Property Name='Signal' Value='False' />
                </om:Element>
            </om:Element>
        </om:Element>
    </om:Element>
</om:MetaModel>
";

        [System.SerializableAttribute]
        public class __ServiceClient_root_0 : Microsoft.XLANGs.Core.ServiceContext
        {
            public __ServiceClient_root_0(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "ServiceClient")
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
                ServiceClient __svc__ = (ServiceClient)_service;
                __ServiceClient_root_0 __ctx0__ = (__ServiceClient_root_0)(__svc__._stateMgrs[0]);

                if (__svc__.BH_SERVICE != null)
                {
                    __svc__.BH_SERVICE.Close(this, null);
                    __svc__.BH_SERVICE = null;
                }
                if (__svc__.BH_OUT != null)
                {
                    __svc__.BH_OUT.Close(this, null);
                    __svc__.BH_OUT = null;
                }
                if (__svc__.BH_IN != null)
                {
                    __svc__.BH_IN.Close(this, null);
                    __svc__.BH_IN = null;
                }
                base.Finally();
            }

            internal Microsoft.XLANGs.Core.SubscriptionWrapper __subWrapper0;
            internal Microsoft.XLANGs.Core.SubscriptionWrapper __subWrapper1;
        }


        [System.SerializableAttribute]
        public class __ServiceClient_1 : Microsoft.XLANGs.Core.ExceptionHandlingContext
        {
            public __ServiceClient_1(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "ServiceClient")
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
                ServiceClient __svc__ = (ServiceClient)_service;
                __ServiceClient_1 __ctx1__ = (__ServiceClient_1)(__svc__._stateMgrs[1]);

                if (__ctx1__ != null && __ctx1__.__WsRequestBH != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestBH);
                    __ctx1__.__WsRequestBH = null;
                }
                base.Finally();
            }

            [Microsoft.XLANGs.Core.UserVariableAttribute("WsRequestBH")]
            internal WSIncentivesAdministrationSystemSoapIn __WsRequestBH;  // lock index = 0
            [Microsoft.XLANGs.Core.UserVariableAttribute("WsResponseBH")]
            internal WSIncentivesAdministrationSystemSoapOut __WsResponseBH;  // lock index = 1
        }


        [System.SerializableAttribute]
        public class ____scope36_2 : Microsoft.XLANGs.Core.ExceptionHandlingContext
        {
            public ____scope36_2(Microsoft.XLANGs.Core.Service svc)
                : base(svc, "??__scope36")
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
                ServiceClient __svc__ = (ServiceClient)_service;
                __ServiceClient_1 __ctx1__ = (__ServiceClient_1)(__svc__._stateMgrs[1]);
                ____scope36_2 __ctx2__ = (____scope36_2)(__svc__._stateMgrs[2]);
                __ServiceClient_root_0 __ctx0__ = (__ServiceClient_root_0)(__svc__._stateMgrs[0]);

                if (__ctx0__ != null && __ctx0__.__subWrapper1 != null)
                {
                    __ctx0__.__subWrapper1.Destroy(__svc__, __ctx0__);
                    __ctx0__.__subWrapper1 = null;
                }
                if (__ctx1__ != null && __ctx1__.__WsResponseBH != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseBH);
                    __ctx1__.__WsResponseBH = null;
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
        [Microsoft.XLANGs.Core.UserVariableAttribute("BH_IN")]
        internal PortType_1 BH_IN;
        [Microsoft.XLANGs.BaseTypes.LogicalBindingAttribute()]
        [Microsoft.XLANGs.BaseTypes.PortAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        )]
        [Microsoft.XLANGs.Core.UserVariableAttribute("BH_SERVICE")]
        internal ServiceSoap BH_SERVICE;
        [Microsoft.XLANGs.BaseTypes.LogicalBindingAttribute()]
        [Microsoft.XLANGs.BaseTypes.PortAttribute(
            Microsoft.XLANGs.BaseTypes.EXLangSParameter.eUses
        )]
        [Microsoft.XLANGs.Core.UserVariableAttribute("BH_OUT")]
        internal PortType_2 BH_OUT;

        public static Microsoft.XLANGs.Core.PortInfo[] _portInfo = new Microsoft.XLANGs.Core.PortInfo[] {
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {PortType_1.Operation_1},
                                               typeof(ServiceClient).GetField("BH_IN", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.implements,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(ServiceClient), "BH_IN"),
                                               null),
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {ServiceSoap.WSContractsByMemberMPP, ServiceSoap.WSMembersByContractCodeMPP, ServiceSoap.WSMembersByContractApplicationCodeMPP, ServiceSoap.WSMemberInformationByContractCodeMPP, ServiceSoap.WSMemberInformationByContractApplicationCodeMPP, ServiceSoap.WSCollectiveContractsByIntermediaryMPP, ServiceSoap.WSSearchSubContractsMPP, ServiceSoap.WSSubContractsByCollectiveContractMPP, ServiceSoap.WSContractByMemberPOS, ServiceSoap.WSMembersByContractCodePOS, ServiceSoap.WSMemberInformationByContractCodePOS, ServiceSoap.WSCollectiveContractsByEmployerMPP, ServiceSoap.WSMembersByEmployerPOS, ServiceSoap.WSFindContractByCodeMPP, ServiceSoap.WSContractAccountStateHeaderMPP, ServiceSoap.WSContractAccountStateDetailsMPP, ServiceSoap.WSContractAccountStateFooterMPP, ServiceSoap.WSIPSCapitaInformation, ServiceSoap.WSInvoiceInformationMPP, ServiceSoap.WSInvoiceInformationDetailMPP, ServiceSoap.WSContractYearsByClientMPP, ServiceSoap.WSContractsByYearMPP, ServiceSoap.WSRetentionCertificateByContractMPP, ServiceSoap.WSRetentionCertificateByContractDetailMPP, ServiceSoap.WSFindContractsByMemberDocumentMPP, ServiceSoap.WSContractYearsByContractMPP, ServiceSoap.WSPaymentYearsByMemberPOS, ServiceSoap.WSEmployersByMemberPOS, ServiceSoap.WSPaymentYearsByEmployerMemberPOS, ServiceSoap.WSPaymentCertificateHeaderPOS, ServiceSoap.WSPaymentCertificateDetailForUPCPOS, ServiceSoap.WSPaymentCertificateDetailPOS, ServiceSoap.WSNoveltyOrNoteDetailMPP, ServiceSoap.WSPersonOrInstitutionExists, ServiceSoap.WSPortfolioBalanceByMemberDocumentAndProduct, ServiceSoap.WSIncentivesAdministrationSystem},
                                               typeof(ServiceClient).GetField("BH_SERVICE", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.uses,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(ServiceClient), "BH_SERVICE"),
                                               null),
            new Microsoft.XLANGs.Core.PortInfo(new Microsoft.XLANGs.Core.OperationInfo[] {PortType_2.Operation_1},
                                               typeof(ServiceClient).GetField("BH_OUT", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance),
                                               Microsoft.XLANGs.BaseTypes.Polarity.uses,
                                               false,
                                               Microsoft.XLANGs.Core.HashHelper.HashPort(typeof(ServiceClient), "BH_OUT"),
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
            new Microsoft.XLANGs.RuntimeTypes.Location(1, "68313f8a-a7df-49d8-9fc3-562de1ba5747", 1, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(2, "68313f8a-a7df-49d8-9fc3-562de1ba5747", 1, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(3, "e2b90d7c-74cf-4868-b1b1-4be6171fc817", 1, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(4, "00000000-0000-0000-0000-000000000000", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(5, "2228e690-82cb-4dd5-92e9-bb223161de12", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(6, "2228e690-82cb-4dd5-92e9-bb223161de12", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(7, "663c87ee-8afb-4fd9-84a7-a84100225c91", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(8, "663c87ee-8afb-4fd9-84a7-a84100225c91", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(9, "7462a32d-d421-41ba-a09d-9ab82eb5bdfd", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(10, "7462a32d-d421-41ba-a09d-9ab82eb5bdfd", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(11, "bca39419-f249-4e43-95b2-106e8e81c7b8", 2, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(12, "bca39419-f249-4e43-95b2-106e8e81c7b8", 2, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(13, "92dac415-2aa2-4d8b-994b-0be67ece83ce", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(14, "8717c1e4-248f-4b69-a0f9-9ca0b6c53d46", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(15, "8717c1e4-248f-4b69-a0f9-9ca0b6c53d46", 3, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(16, "01fa43e9-7650-4f01-83b0-e394663ca9bf", 3, true),
            new Microsoft.XLANGs.RuntimeTypes.Location(17, "92dac415-2aa2-4d8b-994b-0be67ece83ce", 3, false),
            new Microsoft.XLANGs.RuntimeTypes.Location(18, "e2b90d7c-74cf-4868-b1b1-4be6171fc817", 1, false),
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
        public static int[] __progressLocation2 = new int[] { 5,5,5,5,5,5,5,6,7,7,8,9,9,10,11,11,11,12,12,12,12,};
        public static int[] __progressLocation3 = new int[] { 13,13,14,14,15,16,16,17,17,};

        public static int[][] __progressLocations = new int[4] [] {__progressLocation0,__progressLocation1,__progressLocation2,__progressLocation3};
        public override int[][] ProgressLocations {get {return __progressLocations;} }

        public Microsoft.XLANGs.Core.StopConditions segment0(Microsoft.XLANGs.Core.StopConditions stopOn)
        {
            Microsoft.XLANGs.Core.Segment __seg__ = _segments[0];
            Microsoft.XLANGs.Core.Context __ctx__ = (Microsoft.XLANGs.Core.Context)_stateMgrs[0];
            __ServiceClient_1 __ctx1__ = (__ServiceClient_1)_stateMgrs[1];
            __ServiceClient_root_0 __ctx0__ = (__ServiceClient_root_0)_stateMgrs[0];

            switch (__seg__.Progress)
            {
            case 0:
                BH_SERVICE = new ServiceSoap(1, this);
                BH_OUT = new PortType_2(2, this);
                BH_IN = new PortType_1(0, this);
                __ctx__.PrologueCompleted = true;
                __ctx0__.__subWrapper0 = new Microsoft.XLANGs.Core.SubscriptionWrapper(ActivationSubGuids[0], BH_IN, this);
                if ( !PostProgressInc( __seg__, __ctx__, 1 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.Initialized) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.Initialized;
                goto case 1;
            case 1:
                __ctx1__ = new __ServiceClient_1(this);
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
            __ServiceClient_1 __ctx1__ = (__ServiceClient_1)_stateMgrs[1];
            ____scope36_2 __ctx2__ = (____scope36_2)_stateMgrs[2];
            __ServiceClient_root_0 __ctx0__ = (__ServiceClient_root_0)_stateMgrs[0];

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
                if (!BH_IN.GetMessageId(__ctx0__.__subWrapper0.getSubscription(this), __seg__, __ctx1__, out __msgEnv__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if (__ctx1__.__WsRequestBH != null)
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestBH);
                __ctx1__.__WsRequestBH = new WSIncentivesAdministrationSystemSoapIn("WsRequestBH", __ctx1__);
                __ctx1__.RefMessage(__ctx1__.__WsRequestBH);
                BH_IN.ReceiveMessage(0, __msgEnv__, __ctx1__.__WsRequestBH, null, (Microsoft.XLANGs.Core.Context)_stateMgrs[1], __seg__);
                if (BH_IN != null)
                {
                    BH_IN.Close(__ctx1__, __seg__);
                    BH_IN = null;
                }
                if ( !PostProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 4;
            case 4:
                if ( !PreProgressInc( __seg__, __ctx__, 5 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Receive);
                    __edata.Messages.Add(__ctx1__.__WsRequestBH);
                    __edata.PortName = @"BH_IN";
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
                __ctx2__ = new ____scope36_2(this);
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
                if (__ctx1__ != null && __ctx1__.__WsRequestBH != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsRequestBH);
                    __ctx1__.__WsRequestBH = null;
                }
                if (BH_OUT != null)
                {
                    BH_OUT.Close(__ctx1__, __seg__);
                    BH_OUT = null;
                }
                if (BH_SERVICE != null)
                {
                    BH_SERVICE.Close(__ctx1__, __seg__);
                    BH_SERVICE = null;
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
            __ServiceClient_1 __ctx1__ = (__ServiceClient_1)_stateMgrs[1];
            ____scope36_2 __ctx2__ = (____scope36_2)_stateMgrs[2];
            __ServiceClient_root_0 __ctx0__ = (__ServiceClient_root_0)_stateMgrs[0];

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
                if (__ctx2__.LockRead(0, _segments[2]) == false)  // __ServiceClient_1.__WsRequestBH
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 3 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 3;
            case 3:
                if (__ctx2__.LockWrite(1, _segments[2]) == false)  // __ServiceClient_1.__WsResponseBH
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 4 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 4;
            case 4:
                if (__ctx2__.LockWrite(2, _segments[2]) == false)  // .WSIncentivesAdministrationSystem
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 5 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 5;
            case 5:
                if (!__ctx2__.PrepareToPendingCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 6 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 6;
            case 6:
                if ( !PreProgressInc( __seg__, __ctx__, 7 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                BH_SERVICE.SendMessage(35, __ctx1__.__WsRequestBH, null, null, out __ctx0__.__subWrapper1, __ctx2__, __seg__ );
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.OutgoingRqst) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.OutgoingRqst;
                goto case 7;
            case 7:
                if ( !PreProgressInc( __seg__, __ctx__, 8 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Send);
                    __edata.Messages.Add(__ctx1__.__WsRequestBH);
                    __edata.PortName = @"BH_SERVICE";
                    Tracker.FireEvent(__eventLocations[6],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 8;
            case 8:
                if ( !PreProgressInc( __seg__, __ctx__, 9 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[7],__eventData[4],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 9;
            case 9:
                System.Diagnostics.Trace.WriteLine("Inicia llamado a wsIncentivesAdministration");
                if ( !PostProgressInc( __seg__, __ctx__, 10 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 10;
            case 10:
                if ( !PreProgressInc( __seg__, __ctx__, 11 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[8],__eventData[5],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 11;
            case 11:
                if ( !PreProgressInc( __seg__, __ctx__, 12 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[9],__eventData[1],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 12;
            case 12:
                if (!BH_SERVICE.GetMessageId(__ctx0__.__subWrapper1.getSubscription(this), __seg__, __ctx1__, out __msgEnv__, _locations[0]))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if (__ctx0__ != null && __ctx0__.__subWrapper1 != null)
                {
                    __ctx0__.__subWrapper1.Destroy(this, __ctx0__);
                    __ctx0__.__subWrapper1 = null;
                }
                if (__ctx1__.__WsResponseBH != null)
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseBH);
                __ctx1__.__WsResponseBH = new WSIncentivesAdministrationSystemSoapOut("WsResponseBH", __ctx1__);
                __ctx1__.RefMessage(__ctx1__.__WsResponseBH);
                BH_SERVICE.ReceiveMessage(35, __msgEnv__, __ctx1__.__WsResponseBH, null, (Microsoft.XLANGs.Core.Context)_stateMgrs[2], __seg__);
                if ( !PostProgressInc( __seg__, __ctx__, 13 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 13;
            case 13:
                if ( !PreProgressInc( __seg__, __ctx__, 14 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Receive);
                    __edata.Messages.Add(__ctx1__.__WsResponseBH);
                    __edata.PortName = @"BH_SERVICE";
                    Tracker.FireEvent(__eventLocations[10],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 14;
            case 14:
                if ( !PreProgressInc( __seg__, __ctx__, 15 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                Tracker.FireEvent(__eventLocations[11],__eventData[3],_stateMgrs[2].TrackDataStream );
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 15;
            case 15:
                if (!__ctx2__.PrepareToPendingCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 16 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 16;
            case 16:
                if ( !PreProgressInc( __seg__, __ctx__, 17 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                BH_OUT.SendMessage(0, __ctx1__.__WsResponseBH, null, null, __ctx2__, __seg__ , Microsoft.XLANGs.Core.ActivityFlags.NextActivityPersists );
                if ((stopOn & Microsoft.XLANGs.Core.StopConditions.OutgoingRqst) != 0)
                    return Microsoft.XLANGs.Core.StopConditions.OutgoingRqst;
                goto case 17;
            case 17:
                if ( !PreProgressInc( __seg__, __ctx__, 18 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                {
                    Microsoft.XLANGs.RuntimeTypes.EventData __edata = new Microsoft.XLANGs.RuntimeTypes.EventData(Microsoft.XLANGs.RuntimeTypes.Operation.End | Microsoft.XLANGs.RuntimeTypes.Operation.Send);
                    __edata.Messages.Add(__ctx1__.__WsResponseBH);
                    __edata.PortName = @"BH_OUT";
                    Tracker.FireEvent(__eventLocations[12],__edata,_stateMgrs[2].TrackDataStream );
                }
                if (__ctx1__ != null && __ctx1__.__WsResponseBH != null)
                {
                    __ctx1__.UnrefMessage(__ctx1__.__WsResponseBH);
                    __ctx1__.__WsResponseBH = null;
                }
                if (IsDebugged)
                    return Microsoft.XLANGs.Core.StopConditions.InBreakpoint;
                goto case 18;
            case 18:
                if (!__ctx2__.CleanupAndPrepareToCommit(__seg__))
                    return Microsoft.XLANGs.Core.StopConditions.Blocked;
                if ( !PostProgressInc( __seg__, __ctx__, 19 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                goto case 19;
            case 19:
                if ( !PreProgressInc( __seg__, __ctx__, 20 ) )
                    return Microsoft.XLANGs.Core.StopConditions.Paused;
                __ctx2__.OnCommit();
                goto case 20;
            case 20:
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
            ____scope36_2 __ctx2__ = (____scope36_2)_stateMgrs[2];

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
                System.Diagnostics.Trace.WriteLine("Respuesta BH");
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
            new Microsoft.XLANGs.Core.CachedObject(new System.Guid("{B6A91996-85A2-41DF-8650-D8B2A9BE872A}"))
        };

    }

    [Microsoft.XLANGs.BaseTypes.BPELExportableAttribute(false)]
    sealed public class _MODULE_PROXY_ { }
}
