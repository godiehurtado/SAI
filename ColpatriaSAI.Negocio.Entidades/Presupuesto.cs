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
    [KnownType(typeof(DetallePresupuesto))]
    [KnownType(typeof(Ejecucion))]
    [KnownType(typeof(Segmento))]
    public partial class Presupuesto: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<System.DateTime> fechaInicio
        {
            get { return _fechaInicio; }
            set
            {
                if (_fechaInicio != value)
                {
                    _fechaInicio = value;
                    OnPropertyChanged("fechaInicio");
                }
            }
        }
        private Nullable<System.DateTime> _fechaInicio;
    
        [DataMember]
        public Nullable<System.DateTime> fechaFin
        {
            get { return _fechaFin; }
            set
            {
                if (_fechaFin != value)
                {
                    _fechaFin = value;
                    OnPropertyChanged("fechaFin");
                }
            }
        }
        private Nullable<System.DateTime> _fechaFin;
    
        [DataMember]
        public Nullable<System.DateTime> fechaModificacion
        {
            get { return _fechaModificacion; }
            set
            {
                if (_fechaModificacion != value)
                {
                    _fechaModificacion = value;
                    OnPropertyChanged("fechaModificacion");
                }
            }
        }
        private Nullable<System.DateTime> _fechaModificacion;
    
        [DataMember]
        public int segmento_id
        {
            get { return _segmento_id; }
            set
            {
                if (_segmento_id != value)
                {
                    ChangeTracker.RecordOriginalValue("segmento_id", _segmento_id);
                    if (!IsDeserializing)
                    {
                        if (Segmento != null && Segmento.id != value)
                        {
                            Segmento = null;
                        }
                    }
                    _segmento_id = value;
                    OnPropertyChanged("segmento_id");
                }
            }
        }
        private int _segmento_id;
    
        [DataMember]
        public Nullable<bool> calculado
        {
            get { return _calculado; }
            set
            {
                if (_calculado != value)
                {
                    _calculado = value;
                    OnPropertyChanged("calculado");
                }
            }
        }
        private Nullable<bool> _calculado;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public TrackableCollection<DetallePresupuesto> DetallePresupuestoes
        {
            get
            {
                if (_detallePresupuestoes == null)
                {
                    _detallePresupuestoes = new TrackableCollection<DetallePresupuesto>();
                    _detallePresupuestoes.CollectionChanged += FixupDetallePresupuestoes;
                }
                return _detallePresupuestoes;
            }
            set
            {
                if (!ReferenceEquals(_detallePresupuestoes, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_detallePresupuestoes != null)
                    {
                        _detallePresupuestoes.CollectionChanged -= FixupDetallePresupuestoes;
                    }
                    _detallePresupuestoes = value;
                    if (_detallePresupuestoes != null)
                    {
                        _detallePresupuestoes.CollectionChanged += FixupDetallePresupuestoes;
                    }
                    OnNavigationPropertyChanged("DetallePresupuestoes");
                }
            }
        }
        private TrackableCollection<DetallePresupuesto> _detallePresupuestoes;
    
        [DataMember]
        public TrackableCollection<Ejecucion> Ejecucions
        {
            get
            {
                if (_ejecucions == null)
                {
                    _ejecucions = new TrackableCollection<Ejecucion>();
                    _ejecucions.CollectionChanged += FixupEjecucions;
                }
                return _ejecucions;
            }
            set
            {
                if (!ReferenceEquals(_ejecucions, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_ejecucions != null)
                    {
                        _ejecucions.CollectionChanged -= FixupEjecucions;
                    }
                    _ejecucions = value;
                    if (_ejecucions != null)
                    {
                        _ejecucions.CollectionChanged += FixupEjecucions;
                    }
                    OnNavigationPropertyChanged("Ejecucions");
                }
            }
        }
        private TrackableCollection<Ejecucion> _ejecucions;
    
        [DataMember]
        public Segmento Segmento
        {
            get { return _segmento; }
            set
            {
                if (!ReferenceEquals(_segmento, value))
                {
                    var previousValue = _segmento;
                    _segmento = value;
                    FixupSegmento(previousValue);
                    OnNavigationPropertyChanged("Segmento");
                }
            }
        }
        private Segmento _segmento;

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
            DetallePresupuestoes.Clear();
            Ejecucions.Clear();
            Segmento = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupSegmento(Segmento previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Presupuestoes.Contains(this))
            {
                previousValue.Presupuestoes.Remove(this);
            }
    
            if (Segmento != null)
            {
                if (!Segmento.Presupuestoes.Contains(this))
                {
                    Segmento.Presupuestoes.Add(this);
                }
    
                segmento_id = Segmento.id;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Segmento")
                    && (ChangeTracker.OriginalValues["Segmento"] == Segmento))
                {
                    ChangeTracker.OriginalValues.Remove("Segmento");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Segmento", previousValue);
                }
                if (Segmento != null && !Segmento.ChangeTracker.ChangeTrackingEnabled)
                {
                    Segmento.StartTracking();
                }
            }
        }
    
        private void FixupDetallePresupuestoes(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (DetallePresupuesto item in e.NewItems)
                {
                    item.Presupuesto = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("DetallePresupuestoes", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (DetallePresupuesto item in e.OldItems)
                {
                    if (ReferenceEquals(item.Presupuesto, this))
                    {
                        item.Presupuesto = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("DetallePresupuestoes", item);
                    }
                }
            }
        }
    
        private void FixupEjecucions(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (Ejecucion item in e.NewItems)
                {
                    item.Presupuesto = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("Ejecucions", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (Ejecucion item in e.OldItems)
                {
                    if (ReferenceEquals(item.Presupuesto, this))
                    {
                        item.Presupuesto = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("Ejecucions", item);
                    }
                }
            }
        }

        #endregion
    }
}
