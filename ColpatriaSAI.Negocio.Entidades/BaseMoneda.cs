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
    [KnownType(typeof(Moneda))]
    public partial class BaseMoneda: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<System.DateTime> fecha_inicioVigencia
        {
            get { return _fecha_inicioVigencia; }
            set
            {
                if (_fecha_inicioVigencia != value)
                {
                    _fecha_inicioVigencia = value;
                    OnPropertyChanged("fecha_inicioVigencia");
                }
            }
        }
        private Nullable<System.DateTime> _fecha_inicioVigencia;
    
        [DataMember]
        public Nullable<System.DateTime> fecha_finVigencia
        {
            get { return _fecha_finVigencia; }
            set
            {
                if (_fecha_finVigencia != value)
                {
                    _fecha_finVigencia = value;
                    OnPropertyChanged("fecha_finVigencia");
                }
            }
        }
        private Nullable<System.DateTime> _fecha_finVigencia;
    
        [DataMember]
        public Nullable<double> @base
        {
            get { return _base; }
            set
            {
                if (_base != value)
                {
                    _base = value;
                    OnPropertyChanged("base");
                }
            }
        }
        private Nullable<double> _base;
    
        [DataMember]
        public Nullable<int> moneda_id
        {
            get { return _moneda_id; }
            set
            {
                if (_moneda_id != value)
                {
                    ChangeTracker.RecordOriginalValue("moneda_id", _moneda_id);
                    if (!IsDeserializing)
                    {
                        if (Moneda != null && Moneda.id != value)
                        {
                            Moneda = null;
                        }
                    }
                    _moneda_id = value;
                    OnPropertyChanged("moneda_id");
                }
            }
        }
        private Nullable<int> _moneda_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Moneda Moneda
        {
            get { return _moneda; }
            set
            {
                if (!ReferenceEquals(_moneda, value))
                {
                    var previousValue = _moneda;
                    _moneda = value;
                    FixupMoneda(previousValue);
                    OnNavigationPropertyChanged("Moneda");
                }
            }
        }
        private Moneda _moneda;

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
            Moneda = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupMoneda(Moneda previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.BaseMonedas.Contains(this))
            {
                previousValue.BaseMonedas.Remove(this);
            }
    
            if (Moneda != null)
            {
                if (!Moneda.BaseMonedas.Contains(this))
                {
                    Moneda.BaseMonedas.Add(this);
                }
    
                moneda_id = Moneda.id;
            }
            else if (!skipKeys)
            {
                moneda_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Moneda")
                    && (ChangeTracker.OriginalValues["Moneda"] == Moneda))
                {
                    ChangeTracker.OriginalValues.Remove("Moneda");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Moneda", previousValue);
                }
                if (Moneda != null && !Moneda.ChangeTracker.ChangeTrackingEnabled)
                {
                    Moneda.StartTracking();
                }
            }
        }

        #endregion
    }
}
