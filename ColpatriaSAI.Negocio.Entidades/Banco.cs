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
    [KnownType(typeof(BancoDetalle))]
    [KnownType(typeof(MonedaxNegocio))]
    public partial class Banco: IObjectWithChangeTracker, INotifyPropertyChanged
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

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public TrackableCollection<BancoDetalle> BancoDetalles
        {
            get
            {
                if (_bancoDetalles == null)
                {
                    _bancoDetalles = new TrackableCollection<BancoDetalle>();
                    _bancoDetalles.CollectionChanged += FixupBancoDetalles;
                }
                return _bancoDetalles;
            }
            set
            {
                if (!ReferenceEquals(_bancoDetalles, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_bancoDetalles != null)
                    {
                        _bancoDetalles.CollectionChanged -= FixupBancoDetalles;
                    }
                    _bancoDetalles = value;
                    if (_bancoDetalles != null)
                    {
                        _bancoDetalles.CollectionChanged += FixupBancoDetalles;
                    }
                    OnNavigationPropertyChanged("BancoDetalles");
                }
            }
        }
        private TrackableCollection<BancoDetalle> _bancoDetalles;
    
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
            BancoDetalles.Clear();
            MonedaxNegocios.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void FixupBancoDetalles(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (BancoDetalle item in e.NewItems)
                {
                    item.Banco = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("BancoDetalles", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (BancoDetalle item in e.OldItems)
                {
                    if (ReferenceEquals(item.Banco, this))
                    {
                        item.Banco = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("BancoDetalles", item);
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
                    item.Banco = this;
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
                    if (ReferenceEquals(item.Banco, this))
                    {
                        item.Banco = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("MonedaxNegocios", item);
                    }
                }
            }
        }

        #endregion
    }
}
