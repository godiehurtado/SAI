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
    [KnownType(typeof(TipoETLRemota))]
    public partial class ETLRemota: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public string packageFileName
        {
            get { return _packageFileName; }
            set
            {
                if (_packageFileName != value)
                {
                    _packageFileName = value;
                    OnPropertyChanged("packageFileName");
                }
            }
        }
        private string _packageFileName;
    
        [DataMember]
        public string packageConfigFileName
        {
            get { return _packageConfigFileName; }
            set
            {
                if (_packageConfigFileName != value)
                {
                    _packageConfigFileName = value;
                    OnPropertyChanged("packageConfigFileName");
                }
            }
        }
        private string _packageConfigFileName;
    
        [DataMember]
        public string nombre
        {
            get { return _nombre; }
            set
            {
                if (_nombre != value)
                {
                    _nombre = value;
                    OnPropertyChanged("nombre");
                }
            }
        }
        private string _nombre;
    
        [DataMember]
        public int tipoETLRemota_id
        {
            get { return _tipoETLRemota_id; }
            set
            {
                if (_tipoETLRemota_id != value)
                {
                    ChangeTracker.RecordOriginalValue("tipoETLRemota_id", _tipoETLRemota_id);
                    if (!IsDeserializing)
                    {
                        if (TipoETLRemota != null && TipoETLRemota.id != value)
                        {
                            TipoETLRemota = null;
                        }
                    }
                    _tipoETLRemota_id = value;
                    OnPropertyChanged("tipoETLRemota_id");
                }
            }
        }
        private int _tipoETLRemota_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public TipoETLRemota TipoETLRemota
        {
            get { return _tipoETLRemota; }
            set
            {
                if (!ReferenceEquals(_tipoETLRemota, value))
                {
                    var previousValue = _tipoETLRemota;
                    _tipoETLRemota = value;
                    FixupTipoETLRemota(previousValue);
                    OnNavigationPropertyChanged("TipoETLRemota");
                }
            }
        }
        private TipoETLRemota _tipoETLRemota;

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
            TipoETLRemota = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupTipoETLRemota(TipoETLRemota previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ETLRemotas.Contains(this))
            {
                previousValue.ETLRemotas.Remove(this);
            }
    
            if (TipoETLRemota != null)
            {
                if (!TipoETLRemota.ETLRemotas.Contains(this))
                {
                    TipoETLRemota.ETLRemotas.Add(this);
                }
    
                tipoETLRemota_id = TipoETLRemota.id;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("TipoETLRemota")
                    && (ChangeTracker.OriginalValues["TipoETLRemota"] == TipoETLRemota))
                {
                    ChangeTracker.OriginalValues.Remove("TipoETLRemota");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("TipoETLRemota", previousValue);
                }
                if (TipoETLRemota != null && !TipoETLRemota.ChangeTracker.ChangeTrackingEnabled)
                {
                    TipoETLRemota.StartTracking();
                }
            }
        }

        #endregion
    }
}
