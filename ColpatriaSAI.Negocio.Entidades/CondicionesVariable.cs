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
    public partial class CondicionesVariable: IObjectWithChangeTracker, INotifyPropertyChanged
    {
        #region Primitive Properties
    
        [DataMember]
        public int condicion_id
        {
            get { return _condicion_id; }
            set
            {
                if (_condicion_id != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'condicion_id' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    _condicion_id = value;
                    OnPropertyChanged("condicion_id");
                }
            }
        }
        private int _condicion_id;
    
        [DataMember]
        public Nullable<int> variable_id
        {
            get { return _variable_id; }
            set
            {
                if (_variable_id != value)
                {
                    _variable_id = value;
                    OnPropertyChanged("variable_id");
                }
            }
        }
        private Nullable<int> _variable_id;
    
        [DataMember]
        public Nullable<int> operador_id
        {
            get { return _operador_id; }
            set
            {
                if (_operador_id != value)
                {
                    _operador_id = value;
                    OnPropertyChanged("operador_id");
                }
            }
        }
        private Nullable<int> _operador_id;
    
        [DataMember]
        public string valor
        {
            get { return _valor; }
            set
            {
                if (_valor != value)
                {
                    _valor = value;
                    OnPropertyChanged("valor");
                }
            }
        }
        private string _valor;
    
        [DataMember]
        public Nullable<int> subregla_id
        {
            get { return _subregla_id; }
            set
            {
                if (_subregla_id != value)
                {
                    _subregla_id = value;
                    OnPropertyChanged("subregla_id");
                }
            }
        }
        private Nullable<int> _subregla_id;
    
        [DataMember]
        public string seleccion
        {
            get { return _seleccion; }
            set
            {
                if (_seleccion != value)
                {
                    _seleccion = value;
                    OnPropertyChanged("seleccion");
                }
            }
        }
        private string _seleccion;
    
        [DataMember]
        public string textoSeleccion
        {
            get { return _textoSeleccion; }
            set
            {
                if (_textoSeleccion != value)
                {
                    _textoSeleccion = value;
                    OnPropertyChanged("textoSeleccion");
                }
            }
        }
        private string _textoSeleccion;
    
        [DataMember]
        public Nullable<System.DateTime> fecha
        {
            get { return _fecha; }
            set
            {
                if (_fecha != value)
                {
                    _fecha = value;
                    OnPropertyChanged("fecha");
                }
            }
        }
        private Nullable<System.DateTime> _fecha;
    
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
        public Nullable<int> tipoVariable_id
        {
            get { return _tipoVariable_id; }
            set
            {
                if (_tipoVariable_id != value)
                {
                    _tipoVariable_id = value;
                    OnPropertyChanged("tipoVariable_id");
                }
            }
        }
        private Nullable<int> _tipoVariable_id;
    
        [DataMember]
        public Nullable<int> tabla_id
        {
            get { return _tabla_id; }
            set
            {
                if (_tabla_id != value)
                {
                    _tabla_id = value;
                    OnPropertyChanged("tabla_id");
                }
            }
        }
        private Nullable<int> _tabla_id;
    
        [DataMember]
        public Nullable<bool> agregacion
        {
            get { return _agregacion; }
            set
            {
                if (_agregacion != value)
                {
                    _agregacion = value;
                    OnPropertyChanged("agregacion");
                }
            }
        }
        private Nullable<bool> _agregacion;
    
        [DataMember]
        public string columnaTablaMaestra
        {
            get { return _columnaTablaMaestra; }
            set
            {
                if (_columnaTablaMaestra != value)
                {
                    _columnaTablaMaestra = value;
                    OnPropertyChanged("columnaTablaMaestra");
                }
            }
        }
        private string _columnaTablaMaestra;
    
        [DataMember]
        public string tipoDato
        {
            get { return _tipoDato; }
            set
            {
                if (_tipoDato != value)
                {
                    _tipoDato = value;
                    OnPropertyChanged("tipoDato");
                }
            }
        }
        private string _tipoDato;
    
        [DataMember]
        public Nullable<int> operacionAgregacion_id
        {
            get { return _operacionAgregacion_id; }
            set
            {
                if (_operacionAgregacion_id != value)
                {
                    _operacionAgregacion_id = value;
                    OnPropertyChanged("operacionAgregacion_id");
                }
            }
        }
        private Nullable<int> _operacionAgregacion_id;
    
        [DataMember]
        public string nombreExpresion
        {
            get { return _nombreExpresion; }
            set
            {
                if (_nombreExpresion != value)
                {
                    _nombreExpresion = value;
                    OnPropertyChanged("nombreExpresion");
                }
            }
        }
        private string _nombreExpresion;
    
        [DataMember]
        public string expresion
        {
            get { return _expresion; }
            set
            {
                if (_expresion != value)
                {
                    _expresion = value;
                    OnPropertyChanged("expresion");
                }
            }
        }
        private string _expresion;
    
        [DataMember]
        public Nullable<bool> logico
        {
            get { return _logico; }
            set
            {
                if (_logico != value)
                {
                    _logico = value;
                    OnPropertyChanged("logico");
                }
            }
        }
        private Nullable<bool> _logico;
    
        [DataMember]
        public string simboloSQL
        {
            get { return _simboloSQL; }
            set
            {
                if (_simboloSQL != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'simboloSQL' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    _simboloSQL = value;
                    OnPropertyChanged("simboloSQL");
                }
            }
        }
        private string _simboloSQL;

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
        }

        #endregion
    }
}
