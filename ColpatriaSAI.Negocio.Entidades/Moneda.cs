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
    [KnownType(typeof(BaseMoneda))]
    [KnownType(typeof(LiquidacionMoneda))]
    [KnownType(typeof(MaestroMonedaxNegocio))]
    [KnownType(typeof(UnidadMedida))]
    [KnownType(typeof(Segmento))]
    [KnownType(typeof(MonedaxNegocio))]
    [KnownType(typeof(ExcepcionesGenerale))]
    public partial class Moneda: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> unidadmedida_id
        {
            get { return _unidadmedida_id; }
            set
            {
                if (_unidadmedida_id != value)
                {
                    ChangeTracker.RecordOriginalValue("unidadmedida_id", _unidadmedida_id);
                    if (!IsDeserializing)
                    {
                        if (UnidadMedida != null && UnidadMedida.id != value)
                        {
                            UnidadMedida = null;
                        }
                    }
                    _unidadmedida_id = value;
                    OnPropertyChanged("unidadmedida_id");
                }
            }
        }
        private Nullable<int> _unidadmedida_id;
    
        [DataMember]
        public Nullable<int> segmento_id
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
        private Nullable<int> _segmento_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public TrackableCollection<BaseMoneda> BaseMonedas
        {
            get
            {
                if (_baseMonedas == null)
                {
                    _baseMonedas = new TrackableCollection<BaseMoneda>();
                    _baseMonedas.CollectionChanged += FixupBaseMonedas;
                }
                return _baseMonedas;
            }
            set
            {
                if (!ReferenceEquals(_baseMonedas, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_baseMonedas != null)
                    {
                        _baseMonedas.CollectionChanged -= FixupBaseMonedas;
                    }
                    _baseMonedas = value;
                    if (_baseMonedas != null)
                    {
                        _baseMonedas.CollectionChanged += FixupBaseMonedas;
                    }
                    OnNavigationPropertyChanged("BaseMonedas");
                }
            }
        }
        private TrackableCollection<BaseMoneda> _baseMonedas;
    
        [DataMember]
        public TrackableCollection<LiquidacionMoneda> LiquidacionMonedas
        {
            get
            {
                if (_liquidacionMonedas == null)
                {
                    _liquidacionMonedas = new TrackableCollection<LiquidacionMoneda>();
                    _liquidacionMonedas.CollectionChanged += FixupLiquidacionMonedas;
                }
                return _liquidacionMonedas;
            }
            set
            {
                if (!ReferenceEquals(_liquidacionMonedas, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_liquidacionMonedas != null)
                    {
                        _liquidacionMonedas.CollectionChanged -= FixupLiquidacionMonedas;
                    }
                    _liquidacionMonedas = value;
                    if (_liquidacionMonedas != null)
                    {
                        _liquidacionMonedas.CollectionChanged += FixupLiquidacionMonedas;
                    }
                    OnNavigationPropertyChanged("LiquidacionMonedas");
                }
            }
        }
        private TrackableCollection<LiquidacionMoneda> _liquidacionMonedas;
    
        [DataMember]
        public TrackableCollection<MaestroMonedaxNegocio> MaestroMonedaxNegocios
        {
            get
            {
                if (_maestroMonedaxNegocios == null)
                {
                    _maestroMonedaxNegocios = new TrackableCollection<MaestroMonedaxNegocio>();
                    _maestroMonedaxNegocios.CollectionChanged += FixupMaestroMonedaxNegocios;
                }
                return _maestroMonedaxNegocios;
            }
            set
            {
                if (!ReferenceEquals(_maestroMonedaxNegocios, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_maestroMonedaxNegocios != null)
                    {
                        _maestroMonedaxNegocios.CollectionChanged -= FixupMaestroMonedaxNegocios;
                    }
                    _maestroMonedaxNegocios = value;
                    if (_maestroMonedaxNegocios != null)
                    {
                        _maestroMonedaxNegocios.CollectionChanged += FixupMaestroMonedaxNegocios;
                    }
                    OnNavigationPropertyChanged("MaestroMonedaxNegocios");
                }
            }
        }
        private TrackableCollection<MaestroMonedaxNegocio> _maestroMonedaxNegocios;
    
        [DataMember]
        public UnidadMedida UnidadMedida
        {
            get { return _unidadMedida; }
            set
            {
                if (!ReferenceEquals(_unidadMedida, value))
                {
                    var previousValue = _unidadMedida;
                    _unidadMedida = value;
                    FixupUnidadMedida(previousValue);
                    OnNavigationPropertyChanged("UnidadMedida");
                }
            }
        }
        private UnidadMedida _unidadMedida;
    
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
    
        [DataMember]
        public TrackableCollection<MonedaxNegocio> MonedaxNegocios
        {
            get
            {
                if (_monedaxNegocios == null)
                {
                    _monedaxNegocios = new TrackableCollection<MonedaxNegocio>();
                    _monedaxNegocios.CollectionChanged += FixupMonedaxNegocios;
                }
                return _monedaxNegocios;
            }
            set
            {
                if (!ReferenceEquals(_monedaxNegocios, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_monedaxNegocios != null)
                    {
                        _monedaxNegocios.CollectionChanged -= FixupMonedaxNegocios;
                    }
                    _monedaxNegocios = value;
                    if (_monedaxNegocios != null)
                    {
                        _monedaxNegocios.CollectionChanged += FixupMonedaxNegocios;
                    }
                    OnNavigationPropertyChanged("MonedaxNegocios");
                }
            }
        }
        private TrackableCollection<MonedaxNegocio> _monedaxNegocios;
    
        [DataMember]
        public TrackableCollection<ExcepcionesGenerale> ExcepcionesGenerales
        {
            get
            {
                if (_excepcionesGenerales == null)
                {
                    _excepcionesGenerales = new TrackableCollection<ExcepcionesGenerale>();
                    _excepcionesGenerales.CollectionChanged += FixupExcepcionesGenerales;
                }
                return _excepcionesGenerales;
            }
            set
            {
                if (!ReferenceEquals(_excepcionesGenerales, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_excepcionesGenerales != null)
                    {
                        _excepcionesGenerales.CollectionChanged -= FixupExcepcionesGenerales;
                    }
                    _excepcionesGenerales = value;
                    if (_excepcionesGenerales != null)
                    {
                        _excepcionesGenerales.CollectionChanged += FixupExcepcionesGenerales;
                    }
                    OnNavigationPropertyChanged("ExcepcionesGenerales");
                }
            }
        }
        private TrackableCollection<ExcepcionesGenerale> _excepcionesGenerales;

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
            BaseMonedas.Clear();
            LiquidacionMonedas.Clear();
            MaestroMonedaxNegocios.Clear();
            UnidadMedida = null;
            Segmento = null;
            MonedaxNegocios.Clear();
            ExcepcionesGenerales.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void FixupUnidadMedida(UnidadMedida previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Monedas.Contains(this))
            {
                previousValue.Monedas.Remove(this);
            }
    
            if (UnidadMedida != null)
            {
                if (!UnidadMedida.Monedas.Contains(this))
                {
                    UnidadMedida.Monedas.Add(this);
                }
    
                unidadmedida_id = UnidadMedida.id;
            }
            else if (!skipKeys)
            {
                unidadmedida_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("UnidadMedida")
                    && (ChangeTracker.OriginalValues["UnidadMedida"] == UnidadMedida))
                {
                    ChangeTracker.OriginalValues.Remove("UnidadMedida");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("UnidadMedida", previousValue);
                }
                if (UnidadMedida != null && !UnidadMedida.ChangeTracker.ChangeTrackingEnabled)
                {
                    UnidadMedida.StartTracking();
                }
            }
        }
    
        private void FixupSegmento(Segmento previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Monedas.Contains(this))
            {
                previousValue.Monedas.Remove(this);
            }
    
            if (Segmento != null)
            {
                if (!Segmento.Monedas.Contains(this))
                {
                    Segmento.Monedas.Add(this);
                }
    
                segmento_id = Segmento.id;
            }
            else if (!skipKeys)
            {
                segmento_id = null;
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
    
        private void FixupBaseMonedas(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (BaseMoneda item in e.NewItems)
                {
                    item.Moneda = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("BaseMonedas", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (BaseMoneda item in e.OldItems)
                {
                    if (ReferenceEquals(item.Moneda, this))
                    {
                        item.Moneda = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("BaseMonedas", item);
                    }
                }
            }
        }
    
        private void FixupLiquidacionMonedas(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (LiquidacionMoneda item in e.NewItems)
                {
                    item.Moneda = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("LiquidacionMonedas", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (LiquidacionMoneda item in e.OldItems)
                {
                    if (ReferenceEquals(item.Moneda, this))
                    {
                        item.Moneda = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("LiquidacionMonedas", item);
                    }
                }
            }
        }
    
        private void FixupMaestroMonedaxNegocios(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (MaestroMonedaxNegocio item in e.NewItems)
                {
                    item.Moneda = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("MaestroMonedaxNegocios", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (MaestroMonedaxNegocio item in e.OldItems)
                {
                    if (ReferenceEquals(item.Moneda, this))
                    {
                        item.Moneda = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("MaestroMonedaxNegocios", item);
                    }
                }
            }
        }
    
        private void FixupMonedaxNegocios(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (MonedaxNegocio item in e.NewItems)
                {
                    item.Moneda = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("MonedaxNegocios", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (MonedaxNegocio item in e.OldItems)
                {
                    if (ReferenceEquals(item.Moneda, this))
                    {
                        item.Moneda = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("MonedaxNegocios", item);
                    }
                }
            }
        }
    
        private void FixupExcepcionesGenerales(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (ExcepcionesGenerale item in e.NewItems)
                {
                    item.Moneda = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("ExcepcionesGenerales", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (ExcepcionesGenerale item in e.OldItems)
                {
                    if (ReferenceEquals(item.Moneda, this))
                    {
                        item.Moneda = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("ExcepcionesGenerales", item);
                    }
                }
            }
        }

        #endregion
    }
}
