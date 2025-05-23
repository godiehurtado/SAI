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
    [KnownType(typeof(PeriodoFactorxNota))]
    public partial class FactorxNotaDetalle: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> periodofactorxnota_id
        {
            get { return _periodofactorxnota_id; }
            set
            {
                if (_periodofactorxnota_id != value)
                {
                    ChangeTracker.RecordOriginalValue("periodofactorxnota_id", _periodofactorxnota_id);
                    if (!IsDeserializing)
                    {
                        if (PeriodoFactorxNota != null && PeriodoFactorxNota.id != value)
                        {
                            PeriodoFactorxNota = null;
                        }
                    }
                    _periodofactorxnota_id = value;
                    OnPropertyChanged("periodofactorxnota_id");
                }
            }
        }
        private Nullable<int> _periodofactorxnota_id;
    
        [DataMember]
        public Nullable<double> factor
        {
            get { return _factor; }
            set
            {
                if (_factor != value)
                {
                    _factor = value;
                    OnPropertyChanged("factor");
                }
            }
        }
        private Nullable<double> _factor;
    
        [DataMember]
        public Nullable<double> nota
        {
            get { return _nota; }
            set
            {
                if (_nota != value)
                {
                    _nota = value;
                    OnPropertyChanged("nota");
                }
            }
        }
        private Nullable<double> _nota;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public PeriodoFactorxNota PeriodoFactorxNota
        {
            get { return _periodoFactorxNota; }
            set
            {
                if (!ReferenceEquals(_periodoFactorxNota, value))
                {
                    var previousValue = _periodoFactorxNota;
                    _periodoFactorxNota = value;
                    FixupPeriodoFactorxNota(previousValue);
                    OnNavigationPropertyChanged("PeriodoFactorxNota");
                }
            }
        }
        private PeriodoFactorxNota _periodoFactorxNota;

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
            PeriodoFactorxNota = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupPeriodoFactorxNota(PeriodoFactorxNota previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.FactorxNotaDetalles.Contains(this))
            {
                previousValue.FactorxNotaDetalles.Remove(this);
            }
    
            if (PeriodoFactorxNota != null)
            {
                if (!PeriodoFactorxNota.FactorxNotaDetalles.Contains(this))
                {
                    PeriodoFactorxNota.FactorxNotaDetalles.Add(this);
                }
    
                periodofactorxnota_id = PeriodoFactorxNota.id;
            }
            else if (!skipKeys)
            {
                periodofactorxnota_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("PeriodoFactorxNota")
                    && (ChangeTracker.OriginalValues["PeriodoFactorxNota"] == PeriodoFactorxNota))
                {
                    ChangeTracker.OriginalValues.Remove("PeriodoFactorxNota");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("PeriodoFactorxNota", previousValue);
                }
                if (PeriodoFactorxNota != null && !PeriodoFactorxNota.ChangeTracker.ChangeTrackingEnabled)
                {
                    PeriodoFactorxNota.StartTracking();
                }
            }
        }

        #endregion
    }
}
