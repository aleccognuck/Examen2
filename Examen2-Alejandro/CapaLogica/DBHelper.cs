using System;
using System.Data;
using System.Data.SqlClient;

public class DBHelper
{
    private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["GestionEquiposDB"].ConnectionString;

    public void EjecutarComando(string consulta, SqlParameter[] parametros = null)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(consulta, conn))
                {
                    if (parametros != null)
                    {
                        cmd.Parameters.AddRange(parametros);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al ejecutar el comando SQL: " + consulta, ex);
            }
        }
    }

    public void EliminarUsuario(int usuarioID)
    {
        string consulta = "EXEC EliminarUsuario @UsuarioID";
        SqlParameter[] parametros = new SqlParameter[]
        {
            new SqlParameter("@UsuarioID", SqlDbType.Int) { Value = usuarioID }
        };

        try
        {
            EjecutarComando(consulta, parametros);
        }
        catch (Exception ex)
        {
            throw new Exception("Error al eliminar el usuario con ID: " + usuarioID, ex);
        }
    }

    public DataTable ObtenerDatos(string consulta, SqlParameter[] parametros = null)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(consulta, conn))
                {
                    if (parametros != null)
                    {
                        cmd.Parameters.AddRange(parametros);
                    }

                    conn.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener datos de la base de datos", ex);
            }
        }
    }
}
