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
    [KnownType(typeof(CPRO_ProcesosExtraccion))]
    public partial class CPRO_HistorialEjecucionProceso: IObjectWithChangeTracker, INotifyPropertyChanged
    {
        #region Primitive Properties
    
        [DataMember]
        public int id
        {
            get { return _id; }
            set
            {
                if (_id != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'id' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    _id = value;
                    OnPropertyChanged("id");
                }
            }
        }
        private int _id;
    
        [DataMember]
        public byte procesoExtraccion_id
        {
            get { return _procesoExtraccion_id; }
            set
            {
                if (_procesoExtraccion_id != value)
                {
                    ChangeTracker.RecordOriginalValue("procesoExtraccion_id", _procesoExtraccion_id);
                    if (!IsDeserializing)
                    {
                        if (CPRO_ProcesosExtraccion != null && CPRO_ProcesosExtraccion.id != value)
                        {
                            CPRO_ProcesosExtraccion = null;
                        }
                    }
                    _procesoExtraccion_id = value;
                    OnPropertyChanged("procesoExtraccion_id");
                }
            }
        }
        private byte _procesoExtraccion_id;
    
        [DataMember]
        public System.DateTime fecha
        {
            get { return _fecha; }
            set
            {
                if (_fecha != value)
                {
                    _fecha = value;
                    OnPropertyChanged("fecha");
                }
            }
        }
        private System.DateTime _fecha;
    
        [DataMember]
        public string usuario
        {
            get { return _usuario; }
            set
            {
                if (_usuario != value)
                {
                    _usuario = value;
                    OnPropertyChanged("usuario");
                }
            }
        }
        private string _usuario;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public CPRO_ProcesosExtraccion CPRO_ProcesosExtraccion
        {
            get { return _cPRO_ProcesosExtraccion; }
            set
            {
                if (!ReferenceEquals(_cPRO_ProcesosExtraccion, value))
                {
                    var previousValue = _cPRO_ProcesosExtraccion;
                    _cPRO_ProcesosExtraccion = value;
                    FixupCPRO_ProcesosExtraccion(previousValue);
                    OnNavigationPropertyChanged("CPRO_ProcesosExtraccion");
                }
            }
        }
        private CPRO_ProcesosExtraccion _cPRO_ProcesosExtraccion;

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
            CPRO_ProcesosExtraccion = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupCPRO_ProcesosExtraccion(CPRO_ProcesosExtraccion previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.CPRO_HistorialEjecucionProceso.Contains(this))
            {
                previousValue.CPRO_HistorialEjecucionProceso.Remove(this);
            }
    
            if (CPRO_ProcesosExtraccion != null)
            {
                if (!CPRO_ProcesosExtraccion.CPRO_HistorialEjecucionProceso.Contains(this))
                {
                    CPRO_ProcesosExtraccion.CPRO_HistorialEjecucionProceso.Add(this);
                }
    
                procesoExtraccion_id = CPRO_ProcesosExtraccion.id;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("CPRO_ProcesosExtraccion")
                    && (ChangeTracker.OriginalValues["CPRO_ProcesosExtraccion"] == CPRO_ProcesosExtraccion))
                {
                    ChangeTracker.OriginalValues.Remove("CPRO_ProcesosExtraccion");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("CPRO_ProcesosExtraccion", previousValue);
                }
                if (CPRO_ProcesosExtraccion != null && !CPRO_ProcesosExtraccion.ChangeTracker.ChangeTrackingEnabled)
                {
                    CPRO_ProcesosExtraccion.StartTracking();
                }
            }
        }

        #endregion
    }
}
