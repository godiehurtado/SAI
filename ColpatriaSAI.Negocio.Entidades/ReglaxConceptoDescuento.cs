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
    [KnownType(typeof(Regla))]
    [KnownType(typeof(ConceptoDescuento))]
    public partial class ReglaxConceptoDescuento: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> regla_id
        {
            get { return _regla_id; }
            set
            {
                if (_regla_id != value)
                {
                    ChangeTracker.RecordOriginalValue("regla_id", _regla_id);
                    if (!IsDeserializing)
                    {
                        if (Regla != null && Regla.id != value)
                        {
                            Regla = null;
                        }
                    }
                    _regla_id = value;
                    OnPropertyChanged("regla_id");
                }
            }
        }
        private Nullable<int> _regla_id;
    
        [DataMember]
        public Nullable<int> conceptoDescuento_id
        {
            get { return _conceptoDescuento_id; }
            set
            {
                if (_conceptoDescuento_id != value)
                {
                    ChangeTracker.RecordOriginalValue("conceptoDescuento_id", _conceptoDescuento_id);
                    if (!IsDeserializing)
                    {
                        if (ConceptoDescuento != null && ConceptoDescuento.id != value)
                        {
                            ConceptoDescuento = null;
                        }
                    }
                    _conceptoDescuento_id = value;
                    OnPropertyChanged("conceptoDescuento_id");
                }
            }
        }
        private Nullable<int> _conceptoDescuento_id;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Regla Regla
        {
            get { return _regla; }
            set
            {
                if (!ReferenceEquals(_regla, value))
                {
                    var previousValue = _regla;
                    _regla = value;
                    FixupRegla(previousValue);
                    OnNavigationPropertyChanged("Regla");
                }
            }
        }
        private Regla _regla;
    
        [DataMember]
        public ConceptoDescuento ConceptoDescuento
        {
            get { return _conceptoDescuento; }
            set
            {
                if (!ReferenceEquals(_conceptoDescuento, value))
                {
                    var previousValue = _conceptoDescuento;
                    _conceptoDescuento = value;
                    FixupConceptoDescuento(previousValue);
                    OnNavigationPropertyChanged("ConceptoDescuento");
                }
            }
        }
        private ConceptoDescuento _conceptoDescuento;

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
            Regla = null;
            ConceptoDescuento = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupRegla(Regla previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ReglaxConceptoDescuentoes.Contains(this))
            {
                previousValue.ReglaxConceptoDescuentoes.Remove(this);
            }
    
            if (Regla != null)
            {
                if (!Regla.ReglaxConceptoDescuentoes.Contains(this))
                {
                    Regla.ReglaxConceptoDescuentoes.Add(this);
                }
    
                regla_id = Regla.id;
            }
            else if (!skipKeys)
            {
                regla_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Regla")
                    && (ChangeTracker.OriginalValues["Regla"] == Regla))
                {
                    ChangeTracker.OriginalValues.Remove("Regla");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Regla", previousValue);
                }
                if (Regla != null && !Regla.ChangeTracker.ChangeTrackingEnabled)
                {
                    Regla.StartTracking();
                }
            }
        }
    
        private void FixupConceptoDescuento(ConceptoDescuento previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ReglaxConceptoDescuentoes.Contains(this))
            {
                previousValue.ReglaxConceptoDescuentoes.Remove(this);
            }
    
            if (ConceptoDescuento != null)
            {
                if (!ConceptoDescuento.ReglaxConceptoDescuentoes.Contains(this))
                {
                    ConceptoDescuento.ReglaxConceptoDescuentoes.Add(this);
                }
    
                conceptoDescuento_id = ConceptoDescuento.id;
            }
            else if (!skipKeys)
            {
                conceptoDescuento_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("ConceptoDescuento")
                    && (ChangeTracker.OriginalValues["ConceptoDescuento"] == ConceptoDescuento))
                {
                    ChangeTracker.OriginalValues.Remove("ConceptoDescuento");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("ConceptoDescuento", previousValue);
                }
                if (ConceptoDescuento != null && !ConceptoDescuento.ChangeTracker.ChangeTrackingEnabled)
                {
                    ConceptoDescuento.StartTracking();
                }
            }
        }

        #endregion
    }
}
