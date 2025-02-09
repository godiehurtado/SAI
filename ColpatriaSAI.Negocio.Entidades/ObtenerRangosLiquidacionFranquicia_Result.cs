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
    
    public partial class ObtenerRangosLiquidacionFranquicia_Result : INotifyComplexPropertyChanging, INotifyPropertyChanged
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
                    OnComplexPropertyChanging();
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
                    OnComplexPropertyChanging();
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
                    OnComplexPropertyChanging();
                    _ramo_id = value;
                    OnPropertyChanged("ramo_id");
                }
            }
        }
        private Nullable<int> _ramo_id;
    
        [DataMember]
        public Nullable<int> producto_id
        {
            get { return _producto_id; }
            set
            {
                if (_producto_id != value)
                {
                    OnComplexPropertyChanging();
                    _producto_id = value;
                    OnPropertyChanged("producto_id");
                }
            }
        }
        private Nullable<int> _producto_id;
    
        [DataMember]
        public Nullable<double> porcentaje
        {
            get { return _porcentaje; }
            set
            {
                if (_porcentaje != value)
                {
                    OnComplexPropertyChanging();
                    _porcentaje = value;
                    OnPropertyChanged("porcentaje");
                }
            }
        }
        private Nullable<double> _porcentaje;
    
        [DataMember]
        public Nullable<double> rangoinferior
        {
            get { return _rangoinferior; }
            set
            {
                if (_rangoinferior != value)
                {
                    OnComplexPropertyChanging();
                    _rangoinferior = value;
                    OnPropertyChanged("rangoinferior");
                }
            }
        }
        private Nullable<double> _rangoinferior;
    
        [DataMember]
        public Nullable<double> rangosuperior
        {
            get { return _rangosuperior; }
            set
            {
                if (_rangosuperior != value)
                {
                    OnComplexPropertyChanging();
                    _rangosuperior = value;
                    OnPropertyChanged("rangosuperior");
                }
            }
        }
        private Nullable<double> _rangosuperior;
    
        [DataMember]
        public Nullable<int> plan_id
        {
            get { return _plan_id; }
            set
            {
                if (_plan_id != value)
                {
                    OnComplexPropertyChanging();
                    _plan_id = value;
                    OnPropertyChanged("plan_id");
                }
            }
        }
        private Nullable<int> _plan_id;
    
        [DataMember]
        public Nullable<int> lineaNegocio_id
        {
            get { return _lineaNegocio_id; }
            set
            {
                if (_lineaNegocio_id != value)
                {
                    OnComplexPropertyChanging();
                    _lineaNegocio_id = value;
                    OnPropertyChanged("lineaNegocio_id");
                }
            }
        }
        private Nullable<int> _lineaNegocio_id;
    
        [DataMember]
        public int tipoVehiculo_id
        {
            get { return _tipoVehiculo_id; }
            set
            {
                if (_tipoVehiculo_id != value)
                {
                    OnComplexPropertyChanging();
                    _tipoVehiculo_id = value;
                    OnPropertyChanged("tipoVehiculo_id");
                }
            }
        }
        private int _tipoVehiculo_id;
    
        [DataMember]
        public Nullable<int> amparo_id
        {
            get { return _amparo_id; }
            set
            {
                if (_amparo_id != value)
                {
                    OnComplexPropertyChanging();
                    _amparo_id = value;
                    OnPropertyChanged("amparo_id");
                }
            }
        }
        private Nullable<int> _amparo_id;
    
        [DataMember]
        public Nullable<int> part_franquicia_id
        {
            get { return _part_franquicia_id; }
            set
            {
                if (_part_franquicia_id != value)
                {
                    OnComplexPropertyChanging();
                    _part_franquicia_id = value;
                    OnPropertyChanged("part_franquicia_id");
                }
            }
        }
        private Nullable<int> _part_franquicia_id;

        #endregion
        #region ChangeTracking
    
        private void OnComplexPropertyChanging()
        {
            if (_complexPropertyChanging != null)
            {
                _complexPropertyChanging(this, new EventArgs());
            }
        }
    
        event EventHandler INotifyComplexPropertyChanging.ComplexPropertyChanging { add { _complexPropertyChanging += value; } remove { _complexPropertyChanging -= value; } }
        private event EventHandler _complexPropertyChanging;
    
        private void OnPropertyChanged(String propertyName)
        {
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged { add { _propertyChanged += value; } remove { _propertyChanged -= value; } }
        private event PropertyChangedEventHandler _propertyChanged;
    
        public static void RecordComplexOriginalValues(String parentPropertyName, ObtenerRangosLiquidacionFranquicia_Result complexObject, ObjectChangeTracker changeTracker)
        {
            if (String.IsNullOrEmpty(parentPropertyName))
            {
                throw new ArgumentException("String parameter cannot be null or empty.", "parentPropertyName");
            }
    
            if (changeTracker == null)
            {
                throw new ArgumentNullException("changeTracker");
            }
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.id", parentPropertyName), complexObject == null ? null : (object)complexObject.id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.compania_id", parentPropertyName), complexObject == null ? null : (object)complexObject.compania_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.ramo_id", parentPropertyName), complexObject == null ? null : (object)complexObject.ramo_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.producto_id", parentPropertyName), complexObject == null ? null : (object)complexObject.producto_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.porcentaje", parentPropertyName), complexObject == null ? null : (object)complexObject.porcentaje);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.rangoinferior", parentPropertyName), complexObject == null ? null : (object)complexObject.rangoinferior);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.rangosuperior", parentPropertyName), complexObject == null ? null : (object)complexObject.rangosuperior);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.plan_id", parentPropertyName), complexObject == null ? null : (object)complexObject.plan_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.lineaNegocio_id", parentPropertyName), complexObject == null ? null : (object)complexObject.lineaNegocio_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.tipoVehiculo_id", parentPropertyName), complexObject == null ? null : (object)complexObject.tipoVehiculo_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.amparo_id", parentPropertyName), complexObject == null ? null : (object)complexObject.amparo_id);
            changeTracker.RecordOriginalValue(String.Format(CultureInfo.InvariantCulture, "{0}.part_franquicia_id", parentPropertyName), complexObject == null ? null : (object)complexObject.part_franquicia_id);
        }

        #endregion
    }
}
