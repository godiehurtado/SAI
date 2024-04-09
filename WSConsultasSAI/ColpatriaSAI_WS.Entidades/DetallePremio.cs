using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ColpatriaSAI_WS.Entidades
{
    [DataContract]
    public class DetallePremio
    {
        public DetallePremio(string condicion, string meta, Nullable<double> ejecutado, Nullable<double> faltante)
        {
            this.condicion = condicion;
            this.meta = meta;
            this.ejecutado = ejecutado;
            this.faltante = faltante;
        }

        [DataMember]
        public string condicion
        {
            get { return _condicion; }
            set { _condicion = value; }
        }
        private string _condicion;

        [DataMember]
        public string meta
        {
            get { return _meta; }
            set { _meta = value; }
        }
        private string _meta;

        [DataMember]
        public Nullable<double> ejecutado
        {
            get { return _ejecutado; }
            set { _ejecutado = value; }
        }
        private Nullable<double> _ejecutado;

        [DataMember]
        public Nullable<double> faltante
        {
            get { return _faltante; }
            set { _faltante = value; }
        }
        private Nullable<double> _faltante;
    }
}