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
    [KnownType(typeof(AUT_Proceso))]
    public partial class AUT_Proceso_Dependencia: IObjectWithChangeTracker, INotifyPropertyChanged
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
                    if (!IsDeserializing)
                    {
                        if (AUT_Proceso != null && AUT_Proceso.id != value)
                        {
                            AUT_Proceso = null;
                        }
                    }
                    _id = value;
                    OnPropertyChanged("id");
                }
            }
        }
        private int _id;
    
        [DataMember]
        public int id_proceso_requerido
        {
            get { return _id_proceso_requerido; }
            set
            {
                if (_id_proceso_requerido != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'id_proceso_requerido' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    if (!IsDeserializing)
                    {
                        if (AUT_Proceso1 != null && AUT_Proceso1.id != value)
                        {
                            AUT_Proceso1 = null;
                        }
                    }
                    _id_proceso_requerido = value;
                    OnPropertyChanged("id_proceso_requerido");
                }
            }
        }
        private int _id_proceso_requerido;
    
        [DataMember]
        public Nullable<int> en_error_proceso_requerido
        {
            get { return _en_error_proceso_requerido; }
            set
            {
                if (_en_error_proceso_requerido != value)
                {
                    _en_error_proceso_requerido = value;
                    OnPropertyChanged("en_error_proceso_requerido");
                }
            }
        }
        private Nullable<int> _en_error_proceso_requerido;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public AUT_Proceso AUT_Proceso
        {
            get { return _aUT_Proceso; }
            set
            {
                if (!ReferenceEquals(_aUT_Proceso, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added && value != null)
                    {
                        // This the dependent end of an identifying relationship, so the principal end cannot be changed if it is already set,
                        // otherwise it can only be set to an entity with a primary key that is the same value as the dependent's foreign key.
                        if (id != value.id)
                        {
                            throw new InvalidOperationException("The principal end of an identifying relationship can only be changed when the dependent end is in the Added state.");
                        }
                    }
                    var previousValue = _aUT_Proceso;
                    _aUT_Proceso = value;
                    FixupAUT_Proceso(previousValue);
                    OnNavigationPropertyChanged("AUT_Proceso");
                }
            }
        }
        private AUT_Proceso _aUT_Proceso;
    
        [DataMember]
        public AUT_Proceso AUT_Proceso1
        {
            get { return _aUT_Proceso1; }
            set
            {
                if (!ReferenceEquals(_aUT_Proceso1, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added && value != null)
                    {
                        // This the dependent end of an identifying relationship, so the principal end cannot be changed if it is already set,
                        // otherwise it can only be set to an entity with a primary key that is the same value as the dependent's foreign key.
                        if (id_proceso_requerido != value.id)
                        {
                            throw new InvalidOperationException("The principal end of an identifying relationship can only be changed when the dependent end is in the Added state.");
                        }
                    }
                    var previousValue = _aUT_Proceso1;
                    _aUT_Proceso1 = value;
                    FixupAUT_Proceso1(previousValue);
                    OnNavigationPropertyChanged("AUT_Proceso1");
                }
            }
        }
        private AUT_Proceso _aUT_Proceso1;

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
    
        // This entity type is the dependent end in at least one association that performs cascade deletes.
        // This event handler will process notifications that occur when the principal end is deleted.
        internal void HandleCascadeDelete(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                this.MarkAsDeleted();
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
            AUT_Proceso = null;
            AUT_Proceso1 = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupAUT_Proceso(AUT_Proceso previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.AUT_Proceso_Dependencia.Contains(this))
            {
                previousValue.AUT_Proceso_Dependencia.Remove(this);
            }
    
            if (AUT_Proceso != null)
            {
                if (!AUT_Proceso.AUT_Proceso_Dependencia.Contains(this))
                {
                    AUT_Proceso.AUT_Proceso_Dependencia.Add(this);
                }
    
                id = AUT_Proceso.id;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("AUT_Proceso")
                    && (ChangeTracker.OriginalValues["AUT_Proceso"] == AUT_Proceso))
                {
                    ChangeTracker.OriginalValues.Remove("AUT_Proceso");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("AUT_Proceso", previousValue);
                }
                if (AUT_Proceso != null && !AUT_Proceso.ChangeTracker.ChangeTrackingEnabled)
                {
                    AUT_Proceso.StartTracking();
                }
            }
        }
    
        private void FixupAUT_Proceso1(AUT_Proceso previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.AUT_Proceso_Dependencia1.Contains(this))
            {
                previousValue.AUT_Proceso_Dependencia1.Remove(this);
            }
    
            if (AUT_Proceso1 != null)
            {
                if (!AUT_Proceso1.AUT_Proceso_Dependencia1.Contains(this))
                {
                    AUT_Proceso1.AUT_Proceso_Dependencia1.Add(this);
                }
    
                id_proceso_requerido = AUT_Proceso1.id;
            }
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("AUT_Proceso1")
                    && (ChangeTracker.OriginalValues["AUT_Proceso1"] == AUT_Proceso1))
                {
                    ChangeTracker.OriginalValues.Remove("AUT_Proceso1");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("AUT_Proceso1", previousValue);
                }
                if (AUT_Proceso1 != null && !AUT_Proceso1.ChangeTracker.ChangeTrackingEnabled)
                {
                    AUT_Proceso1.StartTracking();
                }
            }
        }

        #endregion
    }
}
