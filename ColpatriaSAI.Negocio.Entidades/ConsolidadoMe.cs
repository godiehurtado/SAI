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
    [KnownType(typeof(Amparo))]
    [KnownType(typeof(Categoria))]
    [KnownType(typeof(LineaNegocio))]
    [KnownType(typeof(Localidad))]
    [KnownType(typeof(Plazo))]
    [KnownType(typeof(Zona))]
    [KnownType(typeof(TipoMedida))]
    [KnownType(typeof(Compania))]
    public partial class ConsolidadoMe: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public int compania_id
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
        private int _compania_id;
    
        [DataMember]
        public Nullable<int> ramo_id
        {
            get { return _ramo_id; }
            set
            {
                if (_ramo_id != value)
                {
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
                    _producto_id = value;
                    OnPropertyChanged("producto_id");
                }
            }
        }
        private Nullable<int> _producto_id;
    
        [DataMember]
        public Nullable<int> tipoMedida_id
        {
            get { return _tipoMedida_id; }
            set
            {
                if (_tipoMedida_id != value)
                {
                    ChangeTracker.RecordOriginalValue("tipoMedida_id", _tipoMedida_id);
                    if (!IsDeserializing)
                    {
                        if (TipoMedida != null && TipoMedida.id != value)
                        {
                            TipoMedida = null;
                        }
                    }
                    _tipoMedida_id = value;
                    OnPropertyChanged("tipoMedida_id");
                }
            }
        }
        private Nullable<int> _tipoMedida_id;
    
        [DataMember]
        public Nullable<int> zona_id
        {
            get { return _zona_id; }
            set
            {
                if (_zona_id != value)
                {
                    ChangeTracker.RecordOriginalValue("zona_id", _zona_id);
                    if (!IsDeserializing)
                    {
                        if (Zona != null && Zona.id != value)
                        {
                            Zona = null;
                        }
                    }
                    _zona_id = value;
                    OnPropertyChanged("zona_id");
                }
            }
        }
        private Nullable<int> _zona_id;
    
        [DataMember]
        public Nullable<int> localidad_id
        {
            get { return _localidad_id; }
            set
            {
                if (_localidad_id != value)
                {
                    ChangeTracker.RecordOriginalValue("localidad_id", _localidad_id);
                    if (!IsDeserializing)
                    {
                        if (Localidad != null && Localidad.id != value)
                        {
                            Localidad = null;
                        }
                    }
                    _localidad_id = value;
                    OnPropertyChanged("localidad_id");
                }
            }
        }
        private Nullable<int> _localidad_id;
    
        [DataMember]
        public string clave
        {
            get { return _clave; }
            set
            {
                if (_clave != value)
                {
                    _clave = value;
                    OnPropertyChanged("clave");
                }
            }
        }
        private string _clave;
    
        [DataMember]
        public Nullable<int> participante_id
        {
            get { return _participante_id; }
            set
            {
                if (_participante_id != value)
                {
                    _participante_id = value;
                    OnPropertyChanged("participante_id");
                }
            }
        }
        private Nullable<int> _participante_id;
    
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
        public Nullable<int> plazo_id
        {
            get { return _plazo_id; }
            set
            {
                if (_plazo_id != value)
                {
                    ChangeTracker.RecordOriginalValue("plazo_id", _plazo_id);
                    if (!IsDeserializing)
                    {
                        if (Plazo != null && Plazo.id != value)
                        {
                            Plazo = null;
                        }
                    }
                    _plazo_id = value;
                    OnPropertyChanged("plazo_id");
                }
            }
        }
        private Nullable<int> _plazo_id;
    
        [DataMember]
        public Nullable<int> amparo_id
        {
            get { return _amparo_id; }
            set
            {
                if (_amparo_id != value)
                {
                    ChangeTracker.RecordOriginalValue("amparo_id", _amparo_id);
                    if (!IsDeserializing)
                    {
                        if (Amparo != null && Amparo.id != value)
                        {
                            Amparo = null;
                        }
                    }
                    _amparo_id = value;
                    OnPropertyChanged("amparo_id");
                }
            }
        }
        private Nullable<int> _amparo_id;
    
        [DataMember]
        public Nullable<int> modalidadPago_id
        {
            get { return _modalidadPago_id; }
            set
            {
                if (_modalidadPago_id != value)
                {
                    _modalidadPago_id = value;
                    OnPropertyChanged("modalidadPago_id");
                }
            }
        }
        private Nullable<int> _modalidadPago_id;
    
        [DataMember]
        public Nullable<int> segmento_id
        {
            get { return _segmento_id; }
            set
            {
                if (_segmento_id != value)
                {
                    _segmento_id = value;
                    OnPropertyChanged("segmento_id");
                }
            }
        }
        private Nullable<int> _segmento_id;
    
        [DataMember]
        public Nullable<double> Enero
        {
            get { return _enero; }
            set
            {
                if (_enero != value)
                {
                    _enero = value;
                    OnPropertyChanged("Enero");
                }
            }
        }
        private Nullable<double> _enero;
    
        [DataMember]
        public Nullable<double> Febrero
        {
            get { return _febrero; }
            set
            {
                if (_febrero != value)
                {
                    _febrero = value;
                    OnPropertyChanged("Febrero");
                }
            }
        }
        private Nullable<double> _febrero;
    
        [DataMember]
        public Nullable<double> Marzo
        {
            get { return _marzo; }
            set
            {
                if (_marzo != value)
                {
                    _marzo = value;
                    OnPropertyChanged("Marzo");
                }
            }
        }
        private Nullable<double> _marzo;
    
        [DataMember]
        public Nullable<double> Abril
        {
            get { return _abril; }
            set
            {
                if (_abril != value)
                {
                    _abril = value;
                    OnPropertyChanged("Abril");
                }
            }
        }
        private Nullable<double> _abril;
    
        [DataMember]
        public Nullable<double> Mayo
        {
            get { return _mayo; }
            set
            {
                if (_mayo != value)
                {
                    _mayo = value;
                    OnPropertyChanged("Mayo");
                }
            }
        }
        private Nullable<double> _mayo;
    
        [DataMember]
        public Nullable<double> Junio
        {
            get { return _junio; }
            set
            {
                if (_junio != value)
                {
                    _junio = value;
                    OnPropertyChanged("Junio");
                }
            }
        }
        private Nullable<double> _junio;
    
        [DataMember]
        public Nullable<double> Julio
        {
            get { return _julio; }
            set
            {
                if (_julio != value)
                {
                    _julio = value;
                    OnPropertyChanged("Julio");
                }
            }
        }
        private Nullable<double> _julio;
    
        [DataMember]
        public Nullable<double> Agosto
        {
            get { return _agosto; }
            set
            {
                if (_agosto != value)
                {
                    _agosto = value;
                    OnPropertyChanged("Agosto");
                }
            }
        }
        private Nullable<double> _agosto;
    
        [DataMember]
        public Nullable<double> Septiembre
        {
            get { return _septiembre; }
            set
            {
                if (_septiembre != value)
                {
                    _septiembre = value;
                    OnPropertyChanged("Septiembre");
                }
            }
        }
        private Nullable<double> _septiembre;
    
        [DataMember]
        public Nullable<double> Octubre
        {
            get { return _octubre; }
            set
            {
                if (_octubre != value)
                {
                    _octubre = value;
                    OnPropertyChanged("Octubre");
                }
            }
        }
        private Nullable<double> _octubre;
    
        [DataMember]
        public Nullable<double> Noviembre
        {
            get { return _noviembre; }
            set
            {
                if (_noviembre != value)
                {
                    _noviembre = value;
                    OnPropertyChanged("Noviembre");
                }
            }
        }
        private Nullable<double> _noviembre;
    
        [DataMember]
        public Nullable<double> Diciembre
        {
            get { return _diciembre; }
            set
            {
                if (_diciembre != value)
                {
                    _diciembre = value;
                    OnPropertyChanged("Diciembre");
                }
            }
        }
        private Nullable<double> _diciembre;
    
        [DataMember]
        public Nullable<int> año
        {
            get { return _año; }
            set
            {
                if (_año != value)
                {
                    _año = value;
                    OnPropertyChanged("año");
                }
            }
        }
        private Nullable<int> _año;
    
        [DataMember]
        public Nullable<double> Ene_Mar
        {
            get { return _ene_Mar; }
            set
            {
                if (_ene_Mar != value)
                {
                    _ene_Mar = value;
                    OnPropertyChanged("Ene_Mar");
                }
            }
        }
        private Nullable<double> _ene_Mar;
    
        [DataMember]
        public Nullable<double> Abr_Jun
        {
            get { return _abr_Jun; }
            set
            {
                if (_abr_Jun != value)
                {
                    _abr_Jun = value;
                    OnPropertyChanged("Abr_Jun");
                }
            }
        }
        private Nullable<double> _abr_Jun;
    
        [DataMember]
        public Nullable<double> Jul_Sep
        {
            get { return _jul_Sep; }
            set
            {
                if (_jul_Sep != value)
                {
                    _jul_Sep = value;
                    OnPropertyChanged("Jul_Sep");
                }
            }
        }
        private Nullable<double> _jul_Sep;
    
        [DataMember]
        public Nullable<double> Oct_Dic
        {
            get { return _oct_Dic; }
            set
            {
                if (_oct_Dic != value)
                {
                    _oct_Dic = value;
                    OnPropertyChanged("Oct_Dic");
                }
            }
        }
        private Nullable<double> _oct_Dic;
    
        [DataMember]
        public Nullable<double> Ene_Jun
        {
            get { return _ene_Jun; }
            set
            {
                if (_ene_Jun != value)
                {
                    _ene_Jun = value;
                    OnPropertyChanged("Ene_Jun");
                }
            }
        }
        private Nullable<double> _ene_Jun;
    
        [DataMember]
        public Nullable<double> Jul_Dic
        {
            get { return _jul_Dic; }
            set
            {
                if (_jul_Dic != value)
                {
                    _jul_Dic = value;
                    OnPropertyChanged("Jul_Dic");
                }
            }
        }
        private Nullable<double> _jul_Dic;
    
        [DataMember]
        public Nullable<double> Ene_Dic
        {
            get { return _ene_Dic; }
            set
            {
                if (_ene_Dic != value)
                {
                    _ene_Dic = value;
                    OnPropertyChanged("Ene_Dic");
                }
            }
        }
        private Nullable<double> _ene_Dic;
    
        [DataMember]
        public Nullable<double> Ene_Mar_Total
        {
            get { return _ene_Mar_Total; }
            set
            {
                if (_ene_Mar_Total != value)
                {
                    _ene_Mar_Total = value;
                    OnPropertyChanged("Ene_Mar_Total");
                }
            }
        }
        private Nullable<double> _ene_Mar_Total;
    
        [DataMember]
        public Nullable<double> Abr_Jun_Total
        {
            get { return _abr_Jun_Total; }
            set
            {
                if (_abr_Jun_Total != value)
                {
                    _abr_Jun_Total = value;
                    OnPropertyChanged("Abr_Jun_Total");
                }
            }
        }
        private Nullable<double> _abr_Jun_Total;
    
        [DataMember]
        public Nullable<double> Jul_Sep_Total
        {
            get { return _jul_Sep_Total; }
            set
            {
                if (_jul_Sep_Total != value)
                {
                    _jul_Sep_Total = value;
                    OnPropertyChanged("Jul_Sep_Total");
                }
            }
        }
        private Nullable<double> _jul_Sep_Total;
    
        [DataMember]
        public Nullable<double> Oct_Dic_Total
        {
            get { return _oct_Dic_Total; }
            set
            {
                if (_oct_Dic_Total != value)
                {
                    _oct_Dic_Total = value;
                    OnPropertyChanged("Oct_Dic_Total");
                }
            }
        }
        private Nullable<double> _oct_Dic_Total;
    
        [DataMember]
        public Nullable<double> Etapa_1
        {
            get { return _etapa_1; }
            set
            {
                if (_etapa_1 != value)
                {
                    _etapa_1 = value;
                    OnPropertyChanged("Etapa_1");
                }
            }
        }
        private Nullable<double> _etapa_1;
    
        [DataMember]
        public Nullable<double> Etapa_2
        {
            get { return _etapa_2; }
            set
            {
                if (_etapa_2 != value)
                {
                    _etapa_2 = value;
                    OnPropertyChanged("Etapa_2");
                }
            }
        }
        private Nullable<double> _etapa_2;
    
        [DataMember]
        public Nullable<double> Etapa_3
        {
            get { return _etapa_3; }
            set
            {
                if (_etapa_3 != value)
                {
                    _etapa_3 = value;
                    OnPropertyChanged("Etapa_3");
                }
            }
        }
        private Nullable<double> _etapa_3;
    
        [DataMember]
        public Nullable<double> Etapa_4
        {
            get { return _etapa_4; }
            set
            {
                if (_etapa_4 != value)
                {
                    _etapa_4 = value;
                    OnPropertyChanged("Etapa_4");
                }
            }
        }
        private Nullable<double> _etapa_4;
    
        [DataMember]
        public Nullable<double> Etapa_5
        {
            get { return _etapa_5; }
            set
            {
                if (_etapa_5 != value)
                {
                    _etapa_5 = value;
                    OnPropertyChanged("Etapa_5");
                }
            }
        }
        private Nullable<double> _etapa_5;
    
        [DataMember]
        public Nullable<int> categoria_id
        {
            get { return _categoria_id; }
            set
            {
                if (_categoria_id != value)
                {
                    ChangeTracker.RecordOriginalValue("categoria_id", _categoria_id);
                    if (!IsDeserializing)
                    {
                        if (Categoria != null && Categoria.id != value)
                        {
                            Categoria = null;
                        }
                    }
                    _categoria_id = value;
                    OnPropertyChanged("categoria_id");
                }
            }
        }
        private Nullable<int> _categoria_id;
    
        [DataMember]
        public Nullable<int> FASECOLDA
        {
            get { return _fASECOLDA; }
            set
            {
                if (_fASECOLDA != value)
                {
                    _fASECOLDA = value;
                    OnPropertyChanged("FASECOLDA");
                }
            }
        }
        private Nullable<int> _fASECOLDA;
    
        [DataMember]
        public Nullable<int> LIMRA
        {
            get { return _lIMRA; }
            set
            {
                if (_lIMRA != value)
                {
                    _lIMRA = value;
                    OnPropertyChanged("LIMRA");
                }
            }
        }
        private Nullable<int> _lIMRA;
    
        [DataMember]
        public Nullable<System.DateTime> fechaIngresoAsesor
        {
            get { return _fechaIngresoAsesor; }
            set
            {
                if (_fechaIngresoAsesor != value)
                {
                    _fechaIngresoAsesor = value;
                    OnPropertyChanged("fechaIngresoAsesor");
                }
            }
        }
        private Nullable<System.DateTime> _fechaIngresoAsesor;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Amparo Amparo
        {
            get { return _amparo; }
            set
            {
                if (!ReferenceEquals(_amparo, value))
                {
                    var previousValue = _amparo;
                    _amparo = value;
                    FixupAmparo(previousValue);
                    OnNavigationPropertyChanged("Amparo");
                }
            }
        }
        private Amparo _amparo;
    
        [DataMember]
        public Categoria Categoria
        {
            get { return _categoria; }
            set
            {
                if (!ReferenceEquals(_categoria, value))
                {
                    var previousValue = _categoria;
                    _categoria = value;
                    FixupCategoria(previousValue);
                    OnNavigationPropertyChanged("Categoria");
                }
            }
        }
        private Categoria _categoria;
    
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
        public Localidad Localidad
        {
            get { return _localidad; }
            set
            {
                if (!ReferenceEquals(_localidad, value))
                {
                    var previousValue = _localidad;
                    _localidad = value;
                    FixupLocalidad(previousValue);
                    OnNavigationPropertyChanged("Localidad");
                }
            }
        }
        private Localidad _localidad;
    
        [DataMember]
        public Plazo Plazo
        {
            get { return _plazo; }
            set
            {
                if (!ReferenceEquals(_plazo, value))
                {
                    var previousValue = _plazo;
                    _plazo = value;
                    FixupPlazo(previousValue);
                    OnNavigationPropertyChanged("Plazo");
                }
            }
        }
        private Plazo _plazo;
    
        [DataMember]
        public Zona Zona
        {
            get { return _zona; }
            set
            {
                if (!ReferenceEquals(_zona, value))
                {
                    var previousValue = _zona;
                    _zona = value;
                    FixupZona(previousValue);
                    OnNavigationPropertyChanged("Zona");
                }
            }
        }
        private Zona _zona;
    
        [DataMember]
        public TipoMedida TipoMedida
        {
            get { return _tipoMedida; }
            set
            {
                if (!ReferenceEquals(_tipoMedida, value))
                {
                    var previousValue = _tipoMedida;
                    _tipoMedida = value;
                    FixupTipoMedida(previousValue);
                    OnNavigationPropertyChanged("TipoMedida");
                }
            }
        }
        private TipoMedida _tipoMedida;
    
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
            Amparo = null;
            Categoria = null;
            LineaNegocio = null;
            Localidad = null;
            Plazo = null;
            Zona = null;
            TipoMedida = null;
            Compania = null;
        }

        #endregion
        #region Association Fixup
    
        private void FixupAmparo(Amparo previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Amparo != null)
            {
                if (!Amparo.ConsolidadoMes.Contains(this))
                {
                    Amparo.ConsolidadoMes.Add(this);
                }
    
                amparo_id = Amparo.id;
            }
            else if (!skipKeys)
            {
                amparo_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Amparo")
                    && (ChangeTracker.OriginalValues["Amparo"] == Amparo))
                {
                    ChangeTracker.OriginalValues.Remove("Amparo");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Amparo", previousValue);
                }
                if (Amparo != null && !Amparo.ChangeTracker.ChangeTrackingEnabled)
                {
                    Amparo.StartTracking();
                }
            }
        }
    
        private void FixupCategoria(Categoria previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Categoria != null)
            {
                if (!Categoria.ConsolidadoMes.Contains(this))
                {
                    Categoria.ConsolidadoMes.Add(this);
                }
    
                categoria_id = Categoria.id;
            }
            else if (!skipKeys)
            {
                categoria_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Categoria")
                    && (ChangeTracker.OriginalValues["Categoria"] == Categoria))
                {
                    ChangeTracker.OriginalValues.Remove("Categoria");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Categoria", previousValue);
                }
                if (Categoria != null && !Categoria.ChangeTracker.ChangeTrackingEnabled)
                {
                    Categoria.StartTracking();
                }
            }
        }
    
        private void FixupLineaNegocio(LineaNegocio previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (LineaNegocio != null)
            {
                if (!LineaNegocio.ConsolidadoMes.Contains(this))
                {
                    LineaNegocio.ConsolidadoMes.Add(this);
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
    
        private void FixupLocalidad(Localidad previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Localidad != null)
            {
                if (!Localidad.ConsolidadoMes.Contains(this))
                {
                    Localidad.ConsolidadoMes.Add(this);
                }
    
                localidad_id = Localidad.id;
            }
            else if (!skipKeys)
            {
                localidad_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Localidad")
                    && (ChangeTracker.OriginalValues["Localidad"] == Localidad))
                {
                    ChangeTracker.OriginalValues.Remove("Localidad");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Localidad", previousValue);
                }
                if (Localidad != null && !Localidad.ChangeTracker.ChangeTrackingEnabled)
                {
                    Localidad.StartTracking();
                }
            }
        }
    
        private void FixupPlazo(Plazo previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Plazo != null)
            {
                if (!Plazo.ConsolidadoMes.Contains(this))
                {
                    Plazo.ConsolidadoMes.Add(this);
                }
    
                plazo_id = Plazo.id;
            }
            else if (!skipKeys)
            {
                plazo_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Plazo")
                    && (ChangeTracker.OriginalValues["Plazo"] == Plazo))
                {
                    ChangeTracker.OriginalValues.Remove("Plazo");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Plazo", previousValue);
                }
                if (Plazo != null && !Plazo.ChangeTracker.ChangeTrackingEnabled)
                {
                    Plazo.StartTracking();
                }
            }
        }
    
        private void FixupZona(Zona previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Zona != null)
            {
                if (!Zona.ConsolidadoMes.Contains(this))
                {
                    Zona.ConsolidadoMes.Add(this);
                }
    
                zona_id = Zona.id;
            }
            else if (!skipKeys)
            {
                zona_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Zona")
                    && (ChangeTracker.OriginalValues["Zona"] == Zona))
                {
                    ChangeTracker.OriginalValues.Remove("Zona");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Zona", previousValue);
                }
                if (Zona != null && !Zona.ChangeTracker.ChangeTrackingEnabled)
                {
                    Zona.StartTracking();
                }
            }
        }
    
        private void FixupTipoMedida(TipoMedida previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (TipoMedida != null)
            {
                if (!TipoMedida.ConsolidadoMes.Contains(this))
                {
                    TipoMedida.ConsolidadoMes.Add(this);
                }
    
                tipoMedida_id = TipoMedida.id;
            }
            else if (!skipKeys)
            {
                tipoMedida_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("TipoMedida")
                    && (ChangeTracker.OriginalValues["TipoMedida"] == TipoMedida))
                {
                    ChangeTracker.OriginalValues.Remove("TipoMedida");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("TipoMedida", previousValue);
                }
                if (TipoMedida != null && !TipoMedida.ChangeTracker.ChangeTrackingEnabled)
                {
                    TipoMedida.StartTracking();
                }
            }
        }
    
        private void FixupCompania(Compania previousValue)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.ConsolidadoMes.Contains(this))
            {
                previousValue.ConsolidadoMes.Remove(this);
            }
    
            if (Compania != null)
            {
                if (!Compania.ConsolidadoMes.Contains(this))
                {
                    Compania.ConsolidadoMes.Add(this);
                }
    
                compania_id = Compania.id;
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
