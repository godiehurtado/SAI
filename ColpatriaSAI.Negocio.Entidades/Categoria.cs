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
    [KnownType(typeof(Nivel))]
    [KnownType(typeof(ConsolidadoMe))]
    [KnownType(typeof(ParticipanteConcurso))]
    [KnownType(typeof(CategoriaxRegla))]
    [KnownType(typeof(Participante))]
    public partial class Categoria: IObjectWithChangeTracker, INotifyPropertyChanged
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
        public Nullable<int> nivel_id
        {
            get { return _nivel_id; }
            set
            {
                if (_nivel_id != value)
                {
                    ChangeTracker.RecordOriginalValue("nivel_id", _nivel_id);
                    if (!IsDeserializing)
                    {
                        if (Nivel != null && Nivel.id != value)
                        {
                            Nivel = null;
                        }
                    }
                    _nivel_id = value;
                    OnPropertyChanged("nivel_id");
                }
            }
        }
        private Nullable<int> _nivel_id;
    
        [DataMember]
        public Nullable<int> principal
        {
            get { return _principal; }
            set
            {
                if (_principal != value)
                {
                    _principal = value;
                    OnPropertyChanged("principal");
                }
            }
        }
        private Nullable<int> _principal;
    
        [DataMember]
        public Nullable<int> tipoCategoria
        {
            get { return _tipoCategoria; }
            set
            {
                if (_tipoCategoria != value)
                {
                    _tipoCategoria = value;
                    OnPropertyChanged("tipoCategoria");
                }
            }
        }
        private Nullable<int> _tipoCategoria;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public Nivel Nivel
        {
            get { return _nivel; }
            set
            {
                if (!ReferenceEquals(_nivel, value))
                {
                    var previousValue = _nivel;
                    _nivel = value;
                    FixupNivel(previousValue);
                    OnNavigationPropertyChanged("Nivel");
                }
            }
        }
        private Nivel _nivel;
    
        [DataMember]
        public TrackableCollection<ConsolidadoMe> ConsolidadoMes
        {
            get
            {
                if (_consolidadoMes == null)
                {
                    _consolidadoMes = new TrackableCollection<ConsolidadoMe>();
                    _consolidadoMes.CollectionChanged += FixupConsolidadoMes;
                }
                return _consolidadoMes;
            }
            set
            {
                if (!ReferenceEquals(_consolidadoMes, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_consolidadoMes != null)
                    {
                        _consolidadoMes.CollectionChanged -= FixupConsolidadoMes;
                    }
                    _consolidadoMes = value;
                    if (_consolidadoMes != null)
                    {
                        _consolidadoMes.CollectionChanged += FixupConsolidadoMes;
                    }
                    OnNavigationPropertyChanged("ConsolidadoMes");
                }
            }
        }
        private TrackableCollection<ConsolidadoMe> _consolidadoMes;
    
        [DataMember]
        public TrackableCollection<ParticipanteConcurso> ParticipanteConcursoes
        {
            get
            {
                if (_participanteConcursoes == null)
                {
                    _participanteConcursoes = new TrackableCollection<ParticipanteConcurso>();
                    _participanteConcursoes.CollectionChanged += FixupParticipanteConcursoes;
                }
                return _participanteConcursoes;
            }
            set
            {
                if (!ReferenceEquals(_participanteConcursoes, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_participanteConcursoes != null)
                    {
                        _participanteConcursoes.CollectionChanged -= FixupParticipanteConcursoes;
                    }
                    _participanteConcursoes = value;
                    if (_participanteConcursoes != null)
                    {
                        _participanteConcursoes.CollectionChanged += FixupParticipanteConcursoes;
                    }
                    OnNavigationPropertyChanged("ParticipanteConcursoes");
                }
            }
        }
        private TrackableCollection<ParticipanteConcurso> _participanteConcursoes;
    
        [DataMember]
        public TrackableCollection<CategoriaxRegla> CategoriaxReglas
        {
            get
            {
                if (_categoriaxReglas == null)
                {
                    _categoriaxReglas = new TrackableCollection<CategoriaxRegla>();
                    _categoriaxReglas.CollectionChanged += FixupCategoriaxReglas;
                }
                return _categoriaxReglas;
            }
            set
            {
                if (!ReferenceEquals(_categoriaxReglas, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_categoriaxReglas != null)
                    {
                        _categoriaxReglas.CollectionChanged -= FixupCategoriaxReglas;
                    }
                    _categoriaxReglas = value;
                    if (_categoriaxReglas != null)
                    {
                        _categoriaxReglas.CollectionChanged += FixupCategoriaxReglas;
                    }
                    OnNavigationPropertyChanged("CategoriaxReglas");
                }
            }
        }
        private TrackableCollection<CategoriaxRegla> _categoriaxReglas;
    
        [DataMember]
        public TrackableCollection<Participante> Participantes
        {
            get
            {
                if (_participantes == null)
                {
                    _participantes = new TrackableCollection<Participante>();
                    _participantes.CollectionChanged += FixupParticipantes;
                }
                return _participantes;
            }
            set
            {
                if (!ReferenceEquals(_participantes, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_participantes != null)
                    {
                        _participantes.CollectionChanged -= FixupParticipantes;
                    }
                    _participantes = value;
                    if (_participantes != null)
                    {
                        _participantes.CollectionChanged += FixupParticipantes;
                    }
                    OnNavigationPropertyChanged("Participantes");
                }
            }
        }
        private TrackableCollection<Participante> _participantes;

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
            Nivel = null;
            ConsolidadoMes.Clear();
            ParticipanteConcursoes.Clear();
            CategoriaxReglas.Clear();
            Participantes.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void FixupNivel(Nivel previousValue, bool skipKeys = false)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (previousValue != null && previousValue.Categorias.Contains(this))
            {
                previousValue.Categorias.Remove(this);
            }
    
            if (Nivel != null)
            {
                if (!Nivel.Categorias.Contains(this))
                {
                    Nivel.Categorias.Add(this);
                }
    
                nivel_id = Nivel.id;
            }
            else if (!skipKeys)
            {
                nivel_id = null;
            }
    
            if (ChangeTracker.ChangeTrackingEnabled)
            {
                if (ChangeTracker.OriginalValues.ContainsKey("Nivel")
                    && (ChangeTracker.OriginalValues["Nivel"] == Nivel))
                {
                    ChangeTracker.OriginalValues.Remove("Nivel");
                }
                else
                {
                    ChangeTracker.RecordOriginalValue("Nivel", previousValue);
                }
                if (Nivel != null && !Nivel.ChangeTracker.ChangeTrackingEnabled)
                {
                    Nivel.StartTracking();
                }
            }
        }
    
        private void FixupConsolidadoMes(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (ConsolidadoMe item in e.NewItems)
                {
                    item.Categoria = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("ConsolidadoMes", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (ConsolidadoMe item in e.OldItems)
                {
                    if (ReferenceEquals(item.Categoria, this))
                    {
                        item.Categoria = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("ConsolidadoMes", item);
                    }
                }
            }
        }
    
        private void FixupParticipanteConcursoes(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (ParticipanteConcurso item in e.NewItems)
                {
                    item.Categoria = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("ParticipanteConcursoes", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (ParticipanteConcurso item in e.OldItems)
                {
                    if (ReferenceEquals(item.Categoria, this))
                    {
                        item.Categoria = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("ParticipanteConcursoes", item);
                    }
                }
            }
        }
    
        private void FixupCategoriaxReglas(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (CategoriaxRegla item in e.NewItems)
                {
                    item.Categoria = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("CategoriaxReglas", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (CategoriaxRegla item in e.OldItems)
                {
                    if (ReferenceEquals(item.Categoria, this))
                    {
                        item.Categoria = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("CategoriaxReglas", item);
                    }
                }
            }
        }
    
        private void FixupParticipantes(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (Participante item in e.NewItems)
                {
                    item.Categoria = this;
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("Participantes", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (Participante item in e.OldItems)
                {
                    if (ReferenceEquals(item.Categoria, this))
                    {
                        item.Categoria = null;
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("Participantes", item);
                    }
                }
            }
        }

        #endregion
    }
}
