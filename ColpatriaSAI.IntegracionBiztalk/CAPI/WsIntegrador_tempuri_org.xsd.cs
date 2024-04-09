namespace BizTalkSai_Project.CAPI {
    using Microsoft.XLANGs.BaseTypes;
    
    
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.BizTalk.Schema.Compiler", "3.0.1.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [SchemaType(SchemaTypeEnum.Document)]
    [System.SerializableAttribute()]
    [SchemaRoots(new string[] {@"AIX_WEB", @"AIX_WEBResponse", @"AIX", @"AIXResponse", @"XML_AIX_WEB", @"XML_AIX_WEBResponse", @"AS4", @"AS4Response", @"XML_AS4", @"XML_AS4Response", @"SQL", @"SQLResponse"})]
    public sealed class WsIntegrador_tempuri_org : Microsoft.XLANGs.BaseTypes.SchemaBase {
        
        [System.NonSerializedAttribute()]
        private static object _rawSchema;
        
        [System.NonSerializedAttribute()]
        private const string _strSchema = @"<?xml version=""1.0"" encoding=""utf-16""?>
<xs:schema xmlns:b=""http://schemas.microsoft.com/BizTalk/2003"" xmlns:tns=""http://tempuri.org/"" elementFormDefault=""qualified"" targetNamespace=""http://tempuri.org/"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"">
  <xs:element name=""AIX_WEB"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataSource"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Company"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Aplication"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataBase"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Parameters"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IpRequest"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""User"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""AIX_WEBResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AIX_WEBResult"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""AIX"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataSource"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Company"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Aplication"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataBase"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Parameters"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IpRequest"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""User"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""AIXResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AIXResult"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""XML_AIX_WEB"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""xml"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""XML_AIX_WEBResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""XML_AIX_WEBResult"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""AS4"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataSource"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Company"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Program"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Library"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Parameters"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IpRequest"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""User"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""AS4Response"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""AS4Result"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""XML_AS4"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Xml"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""XML_AS4Response"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""XML_AS4Result"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""SQL"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataSource"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Company"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""StoredProcedure"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""DataBase"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""Parameters"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""IpRequest"" type=""xs:string"" />
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""User"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name=""SQLResponse"">
    <xs:complexType>
      <xs:sequence>
        <xs:element minOccurs=""0"" maxOccurs=""1"" name=""SQLResult"" type=""xs:string"" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>";
        
        public WsIntegrador_tempuri_org() {
        }
        
        public override string XmlContent {
            get {
                return _strSchema;
            }
        }
        
        public override string[] RootNodes {
            get {
                string[] _RootElements = new string [12];
                _RootElements[0] = "AIX_WEB";
                _RootElements[1] = "AIX_WEBResponse";
                _RootElements[2] = "AIX";
                _RootElements[3] = "AIXResponse";
                _RootElements[4] = "XML_AIX_WEB";
                _RootElements[5] = "XML_AIX_WEBResponse";
                _RootElements[6] = "AS4";
                _RootElements[7] = "AS4Response";
                _RootElements[8] = "XML_AS4";
                _RootElements[9] = "XML_AS4Response";
                _RootElements[10] = "SQL";
                _RootElements[11] = "SQLResponse";
                return _RootElements;
            }
        }
        
        protected override object RawSchema {
            get {
                return _rawSchema;
            }
            set {
                _rawSchema = value;
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AIX_WEB")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AIX_WEB"})]
        public sealed class AIX_WEB : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AIX_WEB() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AIX_WEB";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AIX_WEBResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AIX_WEBResponse"})]
        public sealed class AIX_WEBResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AIX_WEBResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AIX_WEBResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AIX")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AIX"})]
        public sealed class AIX : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AIX() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AIX";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AIXResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AIXResponse"})]
        public sealed class AIXResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AIXResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AIXResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"XML_AIX_WEB")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"XML_AIX_WEB"})]
        public sealed class XML_AIX_WEB : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public XML_AIX_WEB() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "XML_AIX_WEB";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"XML_AIX_WEBResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"XML_AIX_WEBResponse"})]
        public sealed class XML_AIX_WEBResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public XML_AIX_WEBResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "XML_AIX_WEBResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AS4")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AS4"})]
        public sealed class AS4 : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AS4() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AS4";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"AS4Response")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"AS4Response"})]
        public sealed class AS4Response : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public AS4Response() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "AS4Response";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"XML_AS4")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"XML_AS4"})]
        public sealed class XML_AS4 : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public XML_AS4() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "XML_AS4";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"XML_AS4Response")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"XML_AS4Response"})]
        public sealed class XML_AS4Response : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public XML_AS4Response() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "XML_AS4Response";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"SQL")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"SQL"})]
        public sealed class SQL : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public SQL() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "SQL";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
        
        [Schema(@"http://tempuri.org/",@"SQLResponse")]
        [System.SerializableAttribute()]
        [SchemaRoots(new string[] {@"SQLResponse"})]
        public sealed class SQLResponse : Microsoft.XLANGs.BaseTypes.SchemaBase {
            
            [System.NonSerializedAttribute()]
            private static object _rawSchema;
            
            public SQLResponse() {
            }
            
            public override string XmlContent {
                get {
                    return _strSchema;
                }
            }
            
            public override string[] RootNodes {
                get {
                    string[] _RootElements = new string [1];
                    _RootElements[0] = "SQLResponse";
                    return _RootElements;
                }
            }
            
            protected override object RawSchema {
                get {
                    return _rawSchema;
                }
                set {
                    _rawSchema = value;
                }
            }
        }
    }
}
