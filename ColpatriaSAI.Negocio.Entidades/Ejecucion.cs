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
    [KnownType(typeof(Presupuesto))]
    [KnownType(typeof(EjecucionDetalle))]
    public partial class Ejecucion: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<System.DateTime> fecha_calculo
        {
            get { return _fecha_calculo; }
            set
            {
                if (_fecha_calculo != value)
                {
                    _fecha_calculo = value;
                    OnPropertyChanged("fecha_calculo");
                }
            }
        }
        private Nullable<System.DateTime> _fecha_calculo;
    
        [DataMember]
        public Nullable<int> presupuesto_id
        {
            get { return _presupuesto_id; }
            set
            {
                if (_presupuesto_id != value)
                {
                    ChangeTracker.RecordOriginalValue("presupuesto_id", _presupuesto_id);
                    if (!IsDeserializing)
                    {
                        if (Presupuesto != null && Presupuesto.id != value)
                        {
                            Presupuesto = null;
                        }
                    }
                    _presupuesto_id = value;
                    OnPropertyChanged("presupuesto_id");
                }
            }
        }
        private Nullable<int> _presupuesto_id;
    
        [DataMember]
        public Nullable<int> anio
        {
            get { return _anio; }
            set
            {
                if (_anio != value)
                {
                    _anio = value;
                    OnPropertyChanged("anio");
                }
            }
        }
        private Nullable<int> _anio;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Presupuesto Presupuesto
        {
            get { return _presupuesto; }
            set
            {
                if (!ReferenceEquals(_presupuesto, value))
                {
                    var previousValue = _presupuesto;
                    _presupuesto = value;
                    FixupPresupuesto(previousValue);
                    OnNavigationPropertyChanged("Presupuesto");
                }
            }
        }
        private Presupuesto _presupuesto;
    
        [DataMember]
        public TrackableCollection<EjecucionDetalle> EjecucionDetalles
        {
            get
            {
                if (_ejecucionDetalles == null)
                {
                    _ejecucionDetalles = new TrackableCollection<EjecucionDetalle>();
                    _ejecucionDetalles.CollectionChanged += FixupEjecucionDetalles;
                }
                return _ejecucionDetalles;
            }
            set
            {
                if (!ReferenceEquals(_ejecucionDetalles, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_ejecucionDetalles != null)
                    {
                        _ejecucionDetalles.CollectionChanged -= FixupEjecucionDetalles;
                    }
                    _ejecucionDetalles = value;
                    if (_ejecucionDetalles != null)
                    {
                        _ejecucionDetalles.CollectionChanged += FixupEjecucionDetalles;
                    }
                    OnNavigationPropertyChanged("EjecucionDetalles");
                }
            }
        }
        private TrackableCollection<EjecucionDetalle> _ejecucionDetalles;

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
            Presupuesto = null;
            EjecucionDetalles.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void FixupPresupuesto(Presupuesto previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Ejecucions.Contains(this))
            {
                previousValue.Ejecucions.Remove(this);
            }
    
            if (Presupuesto != null)
            {
                if (!Presupuesto.Ejecucions.Contains(this))
                {
                    Presupuesto.Ejecucions.Add(this);
                }
    
                presupuesto_id = Presupuesto.id;
            }
            else if (!skipKeys)
            {
                presupuesto_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Presupuesto")
                    && (ChangeTracker.OriginalValues["Presupuesto"] == Presupuesto))
                {
                    ChangeTracker.OriginalValues.Remove("Presupuesto");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Presupuesto", previousValue);
                }
                if (Presupuesto != null && !Presupuesto.ChangeTracker.ChangeTrackingEnabled)
                {
                    Presupuesto.StartTracking();
                }
            }
        }
    
        private void FixupEjecucionDetalles(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (EjecucionDetalle item in e.NewItems)
                {
                    item.Ejecucion = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("EjecucionDetalles", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (EjecucionDetalle item in e.OldItems)
                {
                    if (ReferenceEquals(item.Ejecucion, this))
                    {
                        item.Ejecucion = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("EjecucionDetalles", item);
                    }
                }
            }
        }

        #endregion
    }
}
