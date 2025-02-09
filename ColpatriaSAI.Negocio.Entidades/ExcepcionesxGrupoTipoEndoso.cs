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
    [KnownType(typeof(GrupoEndoso))]
    [KnownType(typeof(TipoEndoso))]
    [KnownType(typeof(Compania))]
    public partial class ExcepcionesxGrupoTipoEndoso: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> grupoEndoso_id
        {
            get { return _grupoEndoso_id; }
            set
            {
                if (_grupoEndoso_id != value)
                {
                    ChangeTracker.RecordOriginalValue("grupoEndoso_id", _grupoEndoso_id);
                    if (!IsDeserializing)
                    {
                        if (GrupoEndoso != null && GrupoEndoso.id != value)
                        {
                            GrupoEndoso = null;
                        }
                    }
                    _grupoEndoso_id = value;
                    OnPropertyChanged("grupoEndoso_id");
                }
            }
        }
        private Nullable<int> _grupoEndoso_id;
    
        [DataMember]
        public Nullable<int> tipoEndoso_id
        {
            get { return _tipoEndoso_id; }
            set
            {
                if (_tipoEndoso_id != value)
                {
                    ChangeTracker.RecordOriginalValue("tipoEndoso_id", _tipoEndoso_id);
                    if (!IsDeserializing)
                    {
                        if (TipoEndoso != null && TipoEndoso.id != value)
                        {
                            TipoEndoso = null;
                        }
                    }
                    _tipoEndoso_id = value;
                    OnPropertyChanged("tipoEndoso_id");
                }
            }
        }
        private Nullable<int> _tipoEndoso_id;
    
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
        public string estado
        {
            get { return _estado; }
            set
            {
                if (_estado != value)
                {
                    _estado = value;
                    OnPropertyChanged("estado");
                }
            }
        }
        private string _estado;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public GrupoEndoso GrupoEndoso
        {
            get { return _grupoEndoso; }
            set
            {
                if (!ReferenceEquals(_grupoEndoso, value))
                {
                    var previousValue = _grupoEndoso;
                    _grupoEndoso = value;
                    FixupGrupoEndoso(previousValue);
                    OnNavigationPropertyChanged("GrupoEndoso");
                }
            }
        }
        private GrupoEndoso _grupoEndoso;
    
        [DataMember]
        public TipoEndoso TipoEndoso
        {
            get { return _tipoEndoso; }
            set
            {
                if (!ReferenceEquals(_tipoEndoso, value))
                {
                    var previousValue = _tipoEndoso;
                    _tipoEndoso = value;
                    FixupTipoEndoso(previousValue);
                    OnNavigationPropertyChanged("TipoEndoso");
                }
            }
        }
        private TipoEndoso _tipoEndoso;
    
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
            GrupoEndoso = null;
            TipoEndoso = null;
            Compania = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupGrupoEndoso(GrupoEndoso previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ExcepcionesxGrupoTipoEndosoes.Contains(this))
            {
                previousValue.ExcepcionesxGrupoTipoEndosoes.Remove(this);
            }
    
            if (GrupoEndoso != null)
            {
                if (!GrupoEndoso.ExcepcionesxGrupoTipoEndosoes.Contains(this))
                {
                    GrupoEndoso.ExcepcionesxGrupoTipoEndosoes.Add(this);
                }
    
                grupoEndoso_id = GrupoEndoso.id;
            }
            else if (!skipKeys)
            {
                grupoEndoso_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("GrupoEndoso")
                    && (ChangeTracker.OriginalValues["GrupoEndoso"] == GrupoEndoso))
                {
                    ChangeTracker.OriginalValues.Remove("GrupoEndoso");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("GrupoEndoso", previousValue);
                }
                if (GrupoEndoso != null && !GrupoEndoso.ChangeTracker.ChangeTrackingEnabled)
                {
                    GrupoEndoso.StartTracking();
                }
            }
        }
    
        private void FixupTipoEndoso(TipoEndoso previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ExcepcionesxGrupoTipoEndosoes.Contains(this))
            {
                previousValue.ExcepcionesxGrupoTipoEndosoes.Remove(this);
            }
    
            if (TipoEndoso != null)
            {
                if (!TipoEndoso.ExcepcionesxGrupoTipoEndosoes.Contains(this))
                {
                    TipoEndoso.ExcepcionesxGrupoTipoEndosoes.Add(this);
                }
    
                tipoEndoso_id = TipoEndoso.id;
            }
            else if (!skipKeys)
            {
                tipoEndoso_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("TipoEndoso")
                    && (ChangeTracker.OriginalValues["TipoEndoso"] == TipoEndoso))
                {
                    ChangeTracker.OriginalValues.Remove("TipoEndoso");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("TipoEndoso", previousValue);
                }
                if (TipoEndoso != null && !TipoEndoso.ChangeTracker.ChangeTrackingEnabled)
                {
                    TipoEndoso.StartTracking();
                }
            }
        }
    
        private void FixupCompania(Compania previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ExcepcionesxGrupoTipoEndosoes.Contains(this))
            {
                previousValue.ExcepcionesxGrupoTipoEndosoes.Remove(this);
            }
    
            if (Compania != null)
            {
                if (!Compania.ExcepcionesxGrupoTipoEndosoes.Contains(this))
                {
                    Compania.ExcepcionesxGrupoTipoEndosoes.Add(this);
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
