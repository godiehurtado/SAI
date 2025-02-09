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
    [KnownType(typeof(Compania))]
    public partial class PeriodoCierre: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> mesCierre
        {
            get { return _mesCierre; }
            set
            {
                if (_mesCierre != value)
                {
                    _mesCierre = value;
                    OnPropertyChanged("mesCierre");
                }
            }
        }
        private Nullable<int> _mesCierre;
    
        [DataMember]
        public Nullable<int> anioCierre
        {
            get { return _anioCierre; }
            set
            {
                if (_anioCierre != value)
                {
                    _anioCierre = value;
                    OnPropertyChanged("anioCierre");
                }
            }
        }
        private Nullable<int> _anioCierre;
    
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
        public Nullable<System.DateTime> fechaCierre
        {
            get { return _fechaCierre; }
            set
            {
                if (_fechaCierre != value)
                {
                    _fechaCierre = value;
                    OnPropertyChanged("fechaCierre");
                }
            }
        }
        private Nullable<System.DateTime> _fechaCierre;
    
        [DataMember]
        public Nullable<int> estado
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
        private Nullable<int> _estado;

        #endregion
        #region Navigation Properties
    
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
            Compania = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupCompania(Compania previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.PeriodoCierres.Contains(this))
            {
                previousValue.PeriodoCierres.Remove(this);
            }
    
            if (Compania != null)
            {
                if (!Compania.PeriodoCierres.Contains(this))
                {
                    Compania.PeriodoCierres.Add(this);
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
