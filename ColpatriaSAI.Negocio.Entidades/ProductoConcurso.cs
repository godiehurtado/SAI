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
    [KnownType(typeof(Concurso))]
    [KnownType(typeof(LineaNegocio))]
    [KnownType(typeof(Producto))]
    [KnownType(typeof(Ramo))]
    [KnownType(typeof(Compania))]
    public partial class ProductoConcurso: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<System.DateTime> fecha_inicio
        {
            get { return _fecha_inicio; }
            set
            {
                if (_fecha_inicio != value)
                {
                    _fecha_inicio = value;
                    OnPropertyChanged("fecha_inicio");
                }
            }
        }
        private Nullable<System.DateTime> _fecha_inicio;
    
        [DataMember]
        public Nullable<System.DateTime> fecha_fin
        {
            get { return _fecha_fin; }
            set
            {
                if (_fecha_fin != value)
                {
                    _fecha_fin = value;
                    OnPropertyChanged("fecha_fin");
                }
            }
        }
        private Nullable<System.DateTime> _fecha_fin;
    
        [DataMember]
        public Nullable<int> producto_id
        {
            get { return _producto_id; }
            set
            {
                if (_producto_id != value)
                {
                    ChangeTracker.RecordOriginalValue("producto_id", _producto_id);
                    if (!IsDeserializing)
                    {
                        if (Producto != null && Producto.id != value)
                        {
                            Producto = null;
                        }
                    }
                    _producto_id = value;
                    OnPropertyChanged("producto_id");
                }
            }
        }
        private Nullable<int> _producto_id;
    
        [DataMember]
        public Nullable<int> concurso_id
        {
            get { return _concurso_id; }
            set
            {
                if (_concurso_id != value)
                {
                    ChangeTracker.RecordOriginalValue("concurso_id", _concurso_id);
                    if (!IsDeserializing)
                    {
                        if (Concurso != null && Concurso.id != value)
                        {
                            Concurso = null;
                        }
                    }
                    _concurso_id = value;
                    OnPropertyChanged("concurso_id");
                }
            }
        }
        private Nullable<int> _concurso_id;
    
        [DataMember]
        public Nullable<int> lineaNegocio_id
        {
            get { return _lineaNegocio_id; }
            set
            {
                if (_lineaNegocio_id != value)
                {
                    ChangeTracker.RecordOriginalValue("lineaNegocio_id", _lineaNegocio_id);
                    if (!IsDeserializing)
                    {
                        if (LineaNegocio != null && LineaNegocio.id != value)
                        {
                            LineaNegocio = null;
                        }
                    }
                    _lineaNegocio_id = value;
                    OnPropertyChanged("lineaNegocio_id");
                }
            }
        }
        private Nullable<int> _lineaNegocio_id;
    
        [DataMember]
        public Nullable<int> compania_id
        {
            get { return _compania_id; }
            set
            {
                if (_compania_id != value)
                {
                    ChangeTracker.RecordOriginalValue("compania_id", _compania_id);
                    if (!IsDeserializing)
                    {
                        if (Compania != null && Compania.id != value)
                        {
                            Compania = null;
                        }
                    }
                    _compania_id = value;
                    OnPropertyChanged("compania_id");
                }
            }
        }
        private Nullable<int> _compania_id;
    
        [DataMember]
        public Nullable<int> ramo_id
        {
            get { return _ramo_id; }
            set
            {
                if (_ramo_id != value)
                {
                    ChangeTracker.RecordOriginalValue("ramo_id", _ramo_id);
                    if (!IsDeserializing)
                    {
                        if (Ramo != null && Ramo.id != value)
                        {
                            Ramo = null;
                        }
                    }
                    _ramo_id = value;
                    OnPropertyChanged("ramo_id");
                }
            }
        }
        private Nullable<int> _ramo_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Concurso Concurso
        {
            get { return _concurso; }
            set
            {
                if (!ReferenceEquals(_concurso, value))
                {
                    var previousValue = _concurso;
                    _concurso = value;
                    FixupConcurso(previousValue);
                    OnNavigationPropertyChanged("Concurso");
                }
            }
        }
        private Concurso _concurso;
    
        [DataMember]
        public LineaNegocio LineaNegocio
        {
            get { return _lineaNegocio; }
            set
            {
                if (!ReferenceEquals(_lineaNegocio, value))
                {
                    var previousValue = _lineaNegocio;
                    _lineaNegocio = value;
                    FixupLineaNegocio(previousValue);
                    OnNavigationPropertyChanged("LineaNegocio");
                }
            }
        }
        private LineaNegocio _lineaNegocio;
    
        [DataMember]
        public Producto Producto
        {
            get { return _producto; }
            set
            {
                if (!ReferenceEquals(_producto, value))
                {
                    var previousValue = _producto;
                    _producto = value;
                    FixupProducto(previousValue);
                    OnNavigationPropertyChanged("Producto");
                }
            }
        }
        private Producto _producto;
    
        [DataMember]
        public Ramo Ramo
        {
            get { return _ramo; }
            set
            {
                if (!ReferenceEquals(_ramo, value))
                {
                    var previousValue = _ramo;
                    _ramo = value;
                    FixupRamo(previousValue);
                    OnNavigationPropertyChanged("Ramo");
                }
            }
        }
        private Ramo _ramo;
    
        [DataMember]
        public Compania Compania
        {
            get { return _compania; }
            set
            {
                if (!ReferenceEquals(_compania, value))
                {
                    var previousValue = _compania;
                    _compania = value;
                    FixupCompania(previousValue);
                    OnNavigationPropertyChanged("Compania");
                }
            }
        }
        private Compania _compania;

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
            Concurso = null;
            LineaNegocio = null;
            Producto = null;
            Ramo = null;
            Compania = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupConcurso(Concurso previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ProductoConcursoes.Contains(this))
            {
                previousValue.ProductoConcursoes.Remove(this);
            }
    
            if (Concurso != null)
            {
                if (!Concurso.ProductoConcursoes.Contains(this))
                {
                    Concurso.ProductoConcursoes.Add(this);
                }
    
                concurso_id = Concurso.id;
            }
            else if (!skipKeys)
            {
                concurso_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Concurso")
                    && (ChangeTracker.OriginalValues["Concurso"] == Concurso))
                {
                    ChangeTracker.OriginalValues.Remove("Concurso");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Concurso", previousValue);
                }
                if (Concurso != null && !Concurso.ChangeTracker.ChangeTrackingEnabled)
                {
                    Concurso.StartTracking();
                }
            }
        }
    
        private void FixupLineaNegocio(LineaNegocio previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ProductoConcursoes.Contains(this))
            {
                previousValue.ProductoConcursoes.Remove(this);
            }
    
            if (LineaNegocio != null)
            {
                if (!LineaNegocio.ProductoConcursoes.Contains(this))
                {
                    LineaNegocio.ProductoConcursoes.Add(this);
                }
    
                lineaNegocio_id = LineaNegocio.id;
            }
            else if (!skipKeys)
            {
                lineaNegocio_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("LineaNegocio")
                    && (ChangeTracker.OriginalValues["LineaNegocio"] == LineaNegocio))
                {
                    ChangeTracker.OriginalValues.Remove("LineaNegocio");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("LineaNegocio", previousValue);
                }
                if (LineaNegocio != null && !LineaNegocio.ChangeTracker.ChangeTrackingEnabled)
                {
                    LineaNegocio.StartTracking();
                }
            }
        }
    
        private void FixupProducto(Producto previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ProductoConcursoes.Contains(this))
            {
                previousValue.ProductoConcursoes.Remove(this);
            }
    
            if (Producto != null)
            {
                if (!Producto.ProductoConcursoes.Contains(this))
                {
                    Producto.ProductoConcursoes.Add(this);
                }
    
                producto_id = Producto.id;
            }
            else if (!skipKeys)
            {
                producto_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Producto")
                    && (ChangeTracker.OriginalValues["Producto"] == Producto))
                {
                    ChangeTracker.OriginalValues.Remove("Producto");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Producto", previousValue);
                }
                if (Producto != null && !Producto.ChangeTracker.ChangeTrackingEnabled)
                {
                    Producto.StartTracking();
                }
            }
        }
    
        private void FixupRamo(Ramo previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ProductoConcursoes.Contains(this))
            {
                previousValue.ProductoConcursoes.Remove(this);
            }
    
            if (Ramo != null)
            {
                if (!Ramo.ProductoConcursoes.Contains(this))
                {
                    Ramo.ProductoConcursoes.Add(this);
                }
    
                ramo_id = Ramo.id;
            }
            else if (!skipKeys)
            {
                ramo_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Ramo")
                    && (ChangeTracker.OriginalValues["Ramo"] == Ramo))
                {
                    ChangeTracker.OriginalValues.Remove("Ramo");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Ramo", previousValue);
                }
                if (Ramo != null && !Ramo.ChangeTracker.ChangeTrackingEnabled)
                {
                    Ramo.StartTracking();
                }
            }
        }
    
        private void FixupCompania(Compania previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ProductoConcursoes.Contains(this))
            {
                previousValue.ProductoConcursoes.Remove(this);
            }
    
            if (Compania != null)
            {
                if (!Compania.ProductoConcursoes.Contains(this))
                {
                    Compania.ProductoConcursoes.Add(this);
                }
    
                compania_id = Compania.id;
            }
            else if (!skipKeys)
            {
                compania_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Compania")
                    && (ChangeTracker.OriginalValues["Compania"] == Compania))
                {
                    ChangeTracker.OriginalValues.Remove("Compania");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Compania", previousValue);
                }
                if (Compania != null && !Compania.ChangeTracker.ChangeTrackingEnabled)
                {
                    Compania.StartTracking();
                }
            }
        }

        #endregion
    }
}
