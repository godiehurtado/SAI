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
    [KnownType(typeof(Segmento))]
    public partial class UsuarioxSegmento: IObjectWithChangeTracker, INotifyPropertyChanged
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
    
        [DataMember]
        public string userName
        {
            get { return _userName; }
            set
            {
                if (_userName != value)
                {
                    _userName = value;
                    OnPropertyChanged("userName");
                }
            }
        }
        private string _userName;

        #endregion
        #region Navigation Properties
    
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
            Segmento = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupSegmento(Segmento previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.UsuarioxSegmentoes.Contains(this))
            {
                previousValue.UsuarioxSegmentoes.Remove(this);
            }
    
            if (Segmento != null)
            {
                if (!Segmento.UsuarioxSegmentoes.Contains(this))
                {
                    Segmento.UsuarioxSegmentoes.Add(this);
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

        #endregion
    }
}
