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
    [KnownType(typeof(Canal))]
    [KnownType(typeof(JerarquiaDetalle))]
    [KnownType(typeof(Compania))]
    public partial class ParticipacionDirector: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<System.DateTime> fechaIni
        {
            get { return _fechaIni; }
            set
            {
                if (_fechaIni != value)
                {
                    _fechaIni = value;
                    OnPropertyChanged("fechaIni");
                }
            }
        }
        private Nullable<System.DateTime> _fechaIni;
    
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
        public Nullable<int> jerarquiaDetalle_id
        {
            get { return _jerarquiaDetalle_id; }
            set
            {
                if (_jerarquiaDetalle_id != value)
                {
                    ChangeTracker.RecordOriginalValue("jerarquiaDetalle_id", _jerarquiaDetalle_id);
                    if (!IsDeserializing)
                    {
                        if (JerarquiaDetalle != null && JerarquiaDetalle.id != value)
                        {
                            JerarquiaDetalle = null;
                        }
                    }
                    _jerarquiaDetalle_id = value;
                    OnPropertyChanged("jerarquiaDetalle_id");
                }
            }
        }
        private Nullable<int> _jerarquiaDetalle_id;
    
        [DataMember]
        public Nullable<double> porcentaje
        {
            get { return _porcentaje; }
            set
            {
                if (_porcentaje != value)
                {
                    _porcentaje = value;
                    OnPropertyChanged("porcentaje");
                }
            }
        }
        private Nullable<double> _porcentaje;
    
        [DataMember]
        public Nullable<int> canal_id
        {
            get { return _canal_id; }
            set
            {
                if (_canal_id != value)
                {
                    ChangeTracker.RecordOriginalValue("canal_id", _canal_id);
                    if (!IsDeserializing)
                    {
                        if (Canal != null && Canal.id != value)
                        {
                            Canal = null;
                        }
                    }
                    _canal_id = value;
                    OnPropertyChanged("canal_id");
                }
            }
        }
        private Nullable<int> _canal_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Canal Canal
        {
            get { return _canal; }
            set
            {
                if (!ReferenceEquals(_canal, value))
                {
                    var previousValue = _canal;
                    _canal = value;
                    FixupCanal(previousValue);
                    OnNavigationPropertyChanged("Canal");
                }
            }
        }
        private Canal _canal;
    
        [DataMember]
        public JerarquiaDetalle JerarquiaDetalle
        {
            get { return _jerarquiaDetalle; }
            set
            {
                if (!ReferenceEquals(_jerarquiaDetalle, value))
                {
                    var previousValue = _jerarquiaDetalle;
                    _jerarquiaDetalle = value;
                    FixupJerarquiaDetalle(previousValue);
                    OnNavigationPropertyChanged("JerarquiaDetalle");
                }
            }
        }
        private JerarquiaDetalle _jerarquiaDetalle;
    
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
            Canal = null;
            JerarquiaDetalle = null;
            Compania = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupCanal(Canal previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ParticipacionDirectors.Contains(this))
            {
                previousValue.ParticipacionDirectors.Remove(this);
            }
    
            if (Canal != null)
            {
                if (!Canal.ParticipacionDirectors.Contains(this))
                {
                    Canal.ParticipacionDirectors.Add(this);
                }
    
                canal_id = Canal.id;
            }
            else if (!skipKeys)
            {
                canal_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Canal")
                    && (ChangeTracker.OriginalValues["Canal"] == Canal))
                {
                    ChangeTracker.OriginalValues.Remove("Canal");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Canal", previousValue);
                }
                if (Canal != null && !Canal.ChangeTracker.ChangeTrackingEnabled)
                {
                    Canal.StartTracking();
                }
            }
        }
    
        private void FixupJerarquiaDetalle(JerarquiaDetalle previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ParticipacionDirectors.Contains(this))
            {
                previousValue.ParticipacionDirectors.Remove(this);
            }
    
            if (JerarquiaDetalle != null)
            {
                if (!JerarquiaDetalle.ParticipacionDirectors.Contains(this))
                {
                    JerarquiaDetalle.ParticipacionDirectors.Add(this);
                }
    
                jerarquiaDetalle_id = JerarquiaDetalle.id;
            }
            else if (!skipKeys)
            {
                jerarquiaDetalle_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("JerarquiaDetalle")
                    && (ChangeTracker.OriginalValues["JerarquiaDetalle"] == JerarquiaDetalle))
                {
                    ChangeTracker.OriginalValues.Remove("JerarquiaDetalle");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("JerarquiaDetalle", previousValue);
                }
                if (JerarquiaDetalle != null && !JerarquiaDetalle.ChangeTracker.ChangeTrackingEnabled)
                {
                    JerarquiaDetalle.StartTracking();
                }
            }
        }
    
        private void FixupCompania(Compania previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ParticipacionDirectors.Contains(this))
            {
                previousValue.ParticipacionDirectors.Remove(this);
            }
    
            if (Compania != null)
            {
                if (!Compania.ParticipacionDirectors.Contains(this))
                {
                    Compania.ParticipacionDirectors.Add(this);
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
