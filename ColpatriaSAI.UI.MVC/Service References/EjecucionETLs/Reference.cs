﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ColpatriaSAI.UI.MVC.EjecucionETLs {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.CollectionDataContractAttribute(Name="ExtendedPropertiesDictionary", Namespace="http://schemas.datacontract.org/2004/07/ColpatriaSAI.Negocio.Entidades", ItemName="ExtendedProperties", KeyName="Name", ValueName="ExtendedProperty")]
    [System.SerializableAttribute()]
    public class ExtendedPropertiesDictionary : System.Collections.Generic.Dictionary<string, object> {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.CollectionDataContractAttribute(Name="ObjectsAddedToCollectionProperties", Namespace="http://schemas.datacontract.org/2004/07/ColpatriaSAI.Negocio.Entidades", ItemName="AddedObjectsForProperty", KeyName="CollectionPropertyName", ValueName="AddedObjects")]
    [System.SerializableAttribute()]
    public class ObjectsAddedToCollectionProperties : System.Collections.Generic.Dictionary<string, ColpatriaSAI.UI.MVC.EjecucionETLs.ObjectList> {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.CollectionDataContractAttribute(Name="ObjectList", Namespace="http://schemas.datacontract.org/2004/07/ColpatriaSAI.Negocio.Entidades", ItemName="ObjectValue")]
    [System.SerializableAttribute()]
    public class ObjectList : System.Collections.Generic.List<object> {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.CollectionDataContractAttribute(Name="ObjectsRemovedFromCollectionProperties", Namespace="http://schemas.datacontract.org/2004/07/ColpatriaSAI.Negocio.Entidades", ItemName="DeletedObjectsForProperty", KeyName="CollectionPropertyName", ValueName="DeletedObjects")]
    [System.SerializableAttribute()]
    public class ObjectsRemovedFromCollectionProperties : System.Collections.Generic.Dictionary<string, ColpatriaSAI.UI.MVC.EjecucionETLs.ObjectList> {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.CollectionDataContractAttribute(Name="OriginalValuesDictionary", Namespace="http://schemas.datacontract.org/2004/07/ColpatriaSAI.Negocio.Entidades", ItemName="OriginalValues", KeyName="Name", ValueName="OriginalValue")]
    [System.SerializableAttribute()]
    public class OriginalValuesDictionary : System.Collections.Generic.Dictionary<string, object> {
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="EjecucionETLs.IEjecucionETLs")]
    public interface IEjecucionETLs {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEjecucionETLs/ListarTiposETLRemota", ReplyAction="http://tempuri.org/IEjecucionETLs/ListarTiposETLRemotaResponse")]
        ColpatriaSAI.Negocio.Entidades.TipoETLRemota[] ListarTiposETLRemota();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEjecucionETLs/ListarETLsRemotas", ReplyAction="http://tempuri.org/IEjecucionETLs/ListarETLsRemotasResponse")]
        ColpatriaSAI.Negocio.Entidades.ETLRemota[] ListarETLsRemotas();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEjecucionETLs/ObtenerETLRemotaporId", ReplyAction="http://tempuri.org/IEjecucionETLs/ObtenerETLRemotaporIdResponse")]
        ColpatriaSAI.Negocio.Entidades.ETLRemota ObtenerETLRemotaporId(int id);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IEjecucionETLs/ListarETLsRemotasporTipo", ReplyAction="http://tempuri.org/IEjecucionETLs/ListarETLsRemotasporTipoResponse")]
        ColpatriaSAI.Negocio.Entidades.ETLRemota[] ListarETLsRemotasporTipo(int tipoETLRemota_id);
        
        [System.ServiceModel.OperationContractAttribute(IsOneWay=true, Action="http://tempuri.org/IEjecucionETLs/EjecutarETL")]
        void EjecutarETL(ColpatriaSAI.Negocio.Entidades.ETLRemota eTLRemota, System.Collections.Generic.Dictionary<string, object> parametros, ColpatriaSAI.Negocio.Entidades.Informacion.InfoAplicacion info);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IEjecucionETLsChannel : ColpatriaSAI.UI.MVC.EjecucionETLs.IEjecucionETLs, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class EjecucionETLsClient : System.ServiceModel.ClientBase<ColpatriaSAI.UI.MVC.EjecucionETLs.IEjecucionETLs>, ColpatriaSAI.UI.MVC.EjecucionETLs.IEjecucionETLs {
        
        public EjecucionETLsClient() {
        }
        
        public EjecucionETLsClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public EjecucionETLsClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public EjecucionETLsClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public EjecucionETLsClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public ColpatriaSAI.Negocio.Entidades.TipoETLRemota[] ListarTiposETLRemota() {
            return base.Channel.ListarTiposETLRemota();
        }
        
        public ColpatriaSAI.Negocio.Entidades.ETLRemota[] ListarETLsRemotas() {
            return base.Channel.ListarETLsRemotas();
        }
        
        public ColpatriaSAI.Negocio.Entidades.ETLRemota ObtenerETLRemotaporId(int id) {
            return base.Channel.ObtenerETLRemotaporId(id);
        }
        
        public ColpatriaSAI.Negocio.Entidades.ETLRemota[] ListarETLsRemotasporTipo(int tipoETLRemota_id) {
            return base.Channel.ListarETLsRemotasporTipo(tipoETLRemota_id);
        }
        
        public void EjecutarETL(ColpatriaSAI.Negocio.Entidades.ETLRemota eTLRemota, System.Collections.Generic.Dictionary<string, object> parametros, ColpatriaSAI.Negocio.Entidades.Informacion.InfoAplicacion info) {
            base.Channel.EjecutarETL(eTLRemota, parametros, info);
        }
    }
}
