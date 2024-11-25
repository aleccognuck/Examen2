using System;
using System.Data;
using System.Data.SqlClient;

public class Usuario
{
    private DBHelper dbHelper = new DBHelper();

    public void InsertarUsuario(string nombre, string correo, string contraseña)
    {
        string consulta = "INSERT INTO Usuarios (Nombre, Correo, Contraseña) VALUES (@Nombre, @Correo, @Contraseña)";

        
        SqlParameter[] parametros = new SqlParameter[]
        {
        new SqlParameter("@Nombre", nombre),
        new SqlParameter("@Correo", correo),
        new SqlParameter("@Contraseña", contraseña)
        };

        
        DBHelper dbHelper = new DBHelper();
        dbHelper.EjecutarComando(consulta, parametros);
    }


    public DataTable ConsultarUsuarios()
    {
        return dbHelper.ObtenerDatos("ConsultarUsuarios");
    }

    
    public void ActualizarUsuario(int usuarioID, string nombre, string correo, string contraseña)
    {
        SqlParameter[] parametros = {
            new SqlParameter("@UsuarioID", usuarioID),
            new SqlParameter("@Nombre", nombre),
            new SqlParameter("@Correo", correo),
            new SqlParameter("@Contraseña", contraseña)
        };
        dbHelper.EjecutarComando("ActualizarUsuario", parametros);
    }

 
    public void EliminarUsuario(int usuarioID)
    {
        
        SqlParameter[] parametros = new SqlParameter[] {
        new SqlParameter("@UsuarioID", SqlDbType.Int) { Value = usuarioID }
    };

        
        dbHelper.EjecutarComando("EliminarUsuario", parametros);
    }
}
