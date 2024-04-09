using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ColpatriaSAI_WS.Entidades
{
    [DataContract]
    public class DetallePremioAsesor
    {
        public DetallePremioAsesor(Nullable<int> codigoPremio, string premio, string gano, string descripcionPremioGanado, Nullable<System.DateTime> fechaCierrePremio, List<DetallePremio> detallesPremio)
        {
            this.codigoPremio = codigoPremio;
            this.premio = premio;
            this.gano = gano;
            this.descripcionPremioGanado = descripcionPremioGanado;
            this.fechaCierrePremio = fechaCierrePremio;
            this.detallesPremio = detallesPremio;
        }

        [DataMember]
        public Nullable<int> codigoPremio
        {
            get { return _codigoPremio; }
            set { _codigoPremio = value; }
        }
        private Nullable<int> _codigoPremio;

        [DataMember]
        public string premio
        {
            get { return _premio; }
            set { _premio = value; }
        }
        private string _premio;

        [DataMember]
        public string gano
        {
            get { return _gano; }
            set { _gano = value; }
        }
        private string _gano;

        [DataMember]
        public string descripcionPremioGanado
        {
            get { return _descripcionPremioGanado; }
            set { _descripcionPremioGanado = value; }
        }
        private string _descripcionPremioGanado;

        [DataMember]
        public Nullable<System.DateTime> fechaCierrePremio
        {
            get { return _fechaCierrePremio; }
            set { _fechaCierrePremio = value; }
        }
        private Nullable<System.DateTime> _fechaCierrePremio;

        [DataMember]
        public List<DetallePremio> detallesPremio
        {
            get { return _detallesPremio; }
            set { _detallesPremio = value; }
        }
        private List<DetallePremio> _detallesPremio;
    }
}