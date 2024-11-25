using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Examen2_Alejandro.Vistas
{
    public partial class Vistas : System.Web.UI.Page
    {
        private Usuario usuarioBLL = new Usuario();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            gvUsuarios.DataSource = usuarioBLL.ConsultarUsuarios();
            gvUsuarios.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNombre.Text.Trim();
                string correo = txtCorreo.Text.Trim();
                string contraseña = txtContraseña.Text.Trim();

                if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(correo) || string.IsNullOrEmpty(contraseña))
                {
                    // Mostrar un mensaje al usuario
                    return;
                }

                usuarioBLL.InsertarUsuario(nombre, correo, contraseña);
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                LogError(ex);
            }
        }

        protected void gvUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int usuarioID = Convert.ToInt32(gvUsuarios.DataKeys[e.RowIndex].Values["UsuarioID"]);
                usuarioBLL.EliminarUsuario(usuarioID);
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                LogError(ex);
            }
        }

        protected void gvUsuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsuarios.EditIndex = e.NewEditIndex;
            CargarUsuarios();
        }

        protected void gvUsuarios_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Obtén el ID del usuario desde DataKeys
                int usuarioID = Convert.ToInt32(gvUsuarios.DataKeys[e.RowIndex].Values["UsuarioID"]);

                // Obtén los valores de los controles en la fila de edición
                GridViewRow fila = gvUsuarios.Rows[e.RowIndex];
                string nombre = ((TextBox)fila.FindControl("txtNombre")).Text;
                string correo = ((TextBox)fila.FindControl("txtCorreo")).Text;
                string contraseña = ((TextBox)fila.FindControl("txtContraseña")).Text;

                // Llama a la lógica de negocio para actualizar el usuario
                usuarioBLL.ActualizarUsuario(usuarioID, nombre, correo, contraseña);

                // Restablece el GridView y recarga los datos
                gvUsuarios.EditIndex = -1;
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                LogError(ex);
                throw new Exception("Error al intentar actualizar el usuario.", ex);
            }
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                // Cambia al índice de página seleccionado
                gvUsuarios.PageIndex = e.NewPageIndex;

                // Recarga los datos en el GridView
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                LogError(ex);
            }
        }

        private void LogError(Exception ex)
        {
            // Implementa tu manejo de errores aquí
            Console.WriteLine(ex.Message); // Ejemplo simple
        }
    }

}

