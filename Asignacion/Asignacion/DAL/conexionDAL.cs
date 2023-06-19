using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Asignacion.DAL
{
    internal class conexionDAL
    {
        private string cadenaConexion = "data source=AZBITS;initial catalog=DB_SISTEMA;integrated security=true";
        SqlConnection conexion;

        public SqlConnection establecerConexion()
        {
            this.conexion = new SqlConnection(this.cadenaConexion);
            return this.conexion;

        }
        /* Metodos INSERT, UPDATE, DELETE */
        public bool ejecutarComandoSinRetornoDatos(string strComando)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.CommandText = strComando;
                comando.Connection = this.establecerConexion();
                conexion.Open();
                comando.ExecuteNonQuery();
                conexion.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }
        /* SELECT (Retorno Datos) */
    }
}
