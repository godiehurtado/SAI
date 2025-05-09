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
    [KnownType(typeof(FactorxNota))]
    [KnownType(typeof(ModeloxMeta))]
    [KnownType(typeof(ModeloxNodo))]
    public partial class Modelo: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public string descripcion
        {
            get { return _descripcion; }
            set
            {
                if (_descripcion != value)
                {
                    _descripcion = value;
                    OnPropertyChanged("descripcion");
                }
            }
        }
        private string _descripcion;
    
        [DataMember]
        public Nullable<int> factorxnota_id
        {
            get { return _factorxnota_id; }
            set
            {
                if (_factorxnota_id != value)
                {
                    ChangeTracker.RecordOriginalValue("factorxnota_id", _factorxnota_id);
                    if (!IsDeserializing)
                    {
                        if (FactorxNota != null && FactorxNota.id != value)
                        {
                            FactorxNota = null;
                        }
                    }
                    _factorxnota_id = value;
                    OnPropertyChanged("factorxnota_id");
                }
            }
        }
        private Nullable<int> _factorxnota_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public FactorxNota FactorxNota
        {
            get { return _factorxNota; }
            set
            {
                if (!ReferenceEquals(_factorxNota, value))
                {
                    var previousValue = _factorxNota;
                    _factorxNota = value;
                    FixupFactorxNota(previousValue);
                    OnNavigationPropertyChanged("FactorxNota");
                }
            }
        }
        private FactorxNota _factorxNota;
    
        [DataMember]
        public TrackableCollection<ModeloxMeta> ModeloxMetas
        {
            get
            {
                if (_modeloxMetas == null)
                {
                    _modeloxMetas = new TrackableCollection<ModeloxMeta>();
                    _modeloxMetas.CollectionChanged += FixupModeloxMetas;
                }
                return _modeloxMetas;
            }
            set
            {
                if (!ReferenceEquals(_modeloxMetas, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_modeloxMetas != null)
                    {
                        _modeloxMetas.CollectionChanged -= FixupModeloxMetas;
                    }
                    _modeloxMetas = value;
                    if (_modeloxMetas != null)
                    {
                        _modeloxMetas.CollectionChanged += FixupModeloxMetas;
                    }
                    OnNavigationPropertyChanged("ModeloxMetas");
                }
            }
        }
        private TrackableCollection<ModeloxMeta> _modeloxMetas;
    
        [DataMember]
        public TrackableCollection<ModeloxNodo> ModeloxNodoes
        {
            get
            {
                if (_modeloxNodoes == null)
                {
                    _modeloxNodoes = new TrackableCollection<ModeloxNodo>();
                    _modeloxNodoes.CollectionChanged += FixupModeloxNodoes;
                }
                return _modeloxNodoes;
            }
            set
            {
                if (!ReferenceEquals(_modeloxNodoes, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_modeloxNodoes != null)
                    {
                        _modeloxNodoes.CollectionChanged -= FixupModeloxNodoes;
                    }
                    _modeloxNodoes = value;
                    if (_modeloxNodoes != null)
                    {
                        _modeloxNodoes.CollectionChanged += FixupModeloxNodoes;
                    }
                    OnNavigationPropertyChanged("ModeloxNodoes");
                }
            }
        }
        private TrackableCollection<ModeloxNodo> _modeloxNodoes;

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
            FactorxNota = null;
            ModeloxMetas.Clear();
            ModeloxNodoes.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void FixupFactorxNota(FactorxNota previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Modeloes.Contains(this))
            {
                previousValue.Modeloes.Remove(this);
            }
    
            if (FactorxNota != null)
            {
                if (!FactorxNota.Modeloes.Contains(this))
                {
                    FactorxNota.Modeloes.Add(this);
                }
    
                factorxnota_id = FactorxNota.id;
            }
            else if (!skipKeys)
            {
                factorxnota_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("FactorxNota")
                    && (ChangeTracker.OriginalValues["FactorxNota"] == FactorxNota))
                {
                    ChangeTracker.OriginalValues.Remove("FactorxNota");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("FactorxNota", previousValue);
                }
                if (FactorxNota != null && !FactorxNota.ChangeTracker.ChangeTrackingEnabled)
                {
                    FactorxNota.StartTracking();
                }
            }
        }
    
        private void FixupModeloxMetas(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (ModeloxMeta item in e.NewItems)
                {
                    item.Modelo = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("ModeloxMetas", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (ModeloxMeta item in e.OldItems)
                {
                    if (ReferenceEquals(item.Modelo, this))
                    {
                        item.Modelo = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("ModeloxMetas", item);
                    }
                }
            }
        }
    
        private void FixupModeloxNodoes(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (ModeloxNodo item in e.NewItems)
                {
                    item.Modelo = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("ModeloxNodoes", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (ModeloxNodo item in e.OldItems)
                {
                    if (ReferenceEquals(item.Modelo, this))
                    {
                        item.Modelo = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("ModeloxNodoes", item);
                    }
                }
            }
        }

        #endregion
    }
}
