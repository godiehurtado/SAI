//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Globalization;
using System.Runtime.Serialization;

namespace ColpatriaSAI.Negocio.Entidades
{
    [DataContract(IsReference = true)]
    [KnownType(typeof(AUT_Proceso))]
    [KnownType(typeof(AUT_Tipo_Servicio))]
    public partial class AUT_Proceso_Extraccion: IObjectWithChangeTracker, INotifyPropertyChanged
    {
        #region Primitive Properties
    
        [DataMember]
        public int id_proceso
        {
            get { return _id_proceso; }
            set
            {
                if (_id_proceso != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'id_proceso' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    if (!IsDeserializing)
                    {
                        if (AUT_Proceso != null && AUT_Proceso.id != value)
                        {
                            AUT_Proceso = null;
                        }
                    }
                    _id_proceso = value;
                    OnPropertyChanged("id_proceso");
                }
            }
        }
        private int _id_proceso;
    
        [DataMember]
        public int id_tipo_servicio
        {
            get { return _id_tipo_servicio; }
            set
            {
                if (_id_tipo_servicio != value)
                {
                    ChangeTracker.RecordOriginalValue("id_tipo_servicio", _id_tipo_servicio);
                    if (!IsDeserializing)
                    {
                        if (AUT_Tipo_Servicio != null && AUT_Tipo_Servicio.id_tipo_servicio != value)
                        {
                            AUT_Tipo_Servicio = null;
                        }
                    }
                    _id_tipo_servicio = value;
                    OnPropertyChanged("id_tipo_servicio");
                }
            }
        }
        private int _id_tipo_servicio;
    
        [DataMember]
        public string data_source
        {
            get { return _data_source; }
            set
            {
                if (_data_source != value)
                {
                    _data_source = value;
                    OnPropertyChanged("data_source");
                }
            }
        }
        private string _data_source;
    
        [DataMember]
        public string company
        {
            get { return _company; }
            set
            {
                if (_company != value)
                {
                    _company = value;
                    OnPropertyChanged("company");
                }
            }
        }
        private string _company;
    
        [DataMember]
        public string program
        {
            get { return _program; }
            set
            {
                if (_program != value)
                {
                    _program = value;
                    OnPropertyChanged("program");
                }
            }
        }
        private string _program;
    
        [DataMember]
        public string library
        {
            get { return _library; }
            set
            {
                if (_library != value)
                {
                    _library = value;
                    OnPropertyChanged("library");
                }
            }
        }
        private string _library;
    
        [DataMember]
        public string parameters
        {
            get { return _parameters; }
            set
            {
                if (_parameters != value)
                {
                    _parameters = value;
                    OnPropertyChanged("parameters");
                }
            }
        }
        private string _parameters;
    
        [DataMember]
        public string user_envio
        {
            get { return _user_envio; }
            set
            {
                if (_user_envio != value)
                {
                    _user_envio = value;
                    OnPropertyChanged("user_envio");
                }
            }
        }
        private string _user_envio;
    
        [DataMember]
        public string archivos
        {
            get { return _archivos; }
            set
            {
                if (_archivos != value)
                {
                    _archivos = value;
                    OnPropertyChanged("archivos");
                }
            }
        }
        private string _archivos;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public AUT_Proceso AUT_Proceso
        {
            get { return _aUT_Proceso; }
            set
            {
                if (!ReferenceEquals(_aUT_Proceso, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added && value != null)
                    {
                        // This the dependent end of an identifying relationship, so the principal end cannot be changed if it is already set,
                        // otherwise it can only be set to an entity with a primary key that is the same value as the dependent's foreign key.
                        if (id_proceso != value.id)
                        {
                            throw new InvalidOperationException("The principal end of an identifying relationship can only be changed when the dependent end is in the Added state.");
                        }
                    }
                    var previousValue = _aUT_Proceso;
                    _aUT_Proceso = value;
                    FixupAUT_Proceso(previousValue);
                    OnNavigationPropertyChanged("AUT_Proceso");
                }
            }
        }
        private AUT_Proceso _aUT_Proceso;
    
        [DataMember]
        public AUT_Tipo_Servicio AUT_Tipo_Servicio
        {
            get { return _aUT_Tipo_Servicio; }
            set
            {
                if (!ReferenceEquals(_aUT_Tipo_Servicio, value))
                {
                    var previousValue = _aUT_Tipo_Servicio;
                    _aUT_Tipo_Servicio = value;
                    FixupAUT_Tipo_Servicio(previousValue);
                    OnNavigationPropertyChanged("AUT_Tipo_Servicio");
                }
            }
        }
        private AUT_Tipo_Servicio _aUT_Tipo_Servicio;

        #endregion
        #region ChangeTracking
    
        protected virtual void OnPropertyChanged(String propertyName)
        {
            if (ChangeTracker.State != ObjectState.Added && ChangeTracker.State != ObjectState.Deleted)
            {
                ChangeTracker.State = ObjectState.Modified;
            }
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        protected virtual void OnNavigationPropertyChanged(String propertyName)
        {
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged{ add { _propertyChanged += value; } remove { _propertyChanged -= value; } }
        private event PropertyChangedEventHandler _propertyChanged;
        private ObjectChangeTracker _changeTracker;
    
        [DataMember]
        public ObjectChangeTracker ChangeTracker
        {
            get
            {
                if (_changeTracker == null)
                {
                    _changeTracker = new ObjectChangeTracker();
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
                return _changeTracker;
            }
            set
            {
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging -= HandleObjectStateChanging;
                }
                _changeTracker = value;
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
            }
        }
    
        private void HandleObjectStateChanging(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                ClearNavigationProperties();
            }
        }
    
        // This entity type is the dependent end in at least one association that performs cascade deletes.
        // This event handler will process notifications that occur when the principal end is deleted.
        internal void HandleCascadeDelete(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                this.MarkAsDeleted();
            }
        }
    
        protected bool IsDeserializing { get; private set; }
    
        [OnDeserializing]
        public void OnDeserializingMethod(StreamingContext context)
        {
            IsDeserializing = true;
        }
    
        [OnDeserialized]
        public void OnDeserializedMethod(StreamingContext context)
        {
            IsDeserializing = false;
            ChangeTracker.ChangeTrackingEnabled = true;
        }
    
        protected virtual void ClearNavigationProperties()
        {
            AUT_Proceso = null;
            AUT_Tipo_Servicio = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupAUT_Proceso(AUT_Proceso previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && ReferenceEquals(previousValue.AUT_Proceso_Extraccion, this))
            {
                previousValue.AUT_Proceso_Extraccion = null;
            }
    
            if (AUT_Proceso != null)
            {
                AUT_Proceso.AUT_Proceso_Extraccion = this;
                id_proceso = AUT_Proceso.id;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("AUT_Proceso")
                    && (ChangeTracker.OriginalValues["AUT_Proceso"] == AUT_Proceso))
                {
                    ChangeTracker.OriginalValues.Remove("AUT_Proceso");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("AUT_Proceso", previousValue);
                }
                if (AUT_Proceso != null && !AUT_Proceso.ChangeTracker.ChangeTrackingEnabled)
                {
                    AUT_Proceso.StartTracking();
                }
            }
        }
    
        private void FixupAUT_Tipo_Servicio(AUT_Tipo_Servicio previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.AUT_Proceso_Extraccion.Contains(this))
            {
                previousValue.AUT_Proceso_Extraccion.Remove(this);
            }
    
            if (AUT_Tipo_Servicio != null)
            {
                if (!AUT_Tipo_Servicio.AUT_Proceso_Extraccion.Contains(this))
                {
                    AUT_Tipo_Servicio.AUT_Proceso_Extraccion.Add(this);
                }
    
                id_tipo_servicio = AUT_Tipo_Servicio.id_tipo_servicio;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("AUT_Tipo_Servicio")
                    && (ChangeTracker.OriginalValues["AUT_Tipo_Servicio"] == AUT_Tipo_Servicio))
                {
                    ChangeTracker.OriginalValues.Remove("AUT_Tipo_Servicio");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("AUT_Tipo_Servicio", previousValue);
                }
                if (AUT_Tipo_Servicio != null && !AUT_Tipo_Servicio.ChangeTracker.ChangeTrackingEnabled)
                {
                    AUT_Tipo_Servicio.StartTracking();
                }
            }
        }

        #endregion
    }
}
