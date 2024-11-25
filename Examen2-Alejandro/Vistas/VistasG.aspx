 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VistasG.aspx.cs" Inherits="Examen2_Alejandro.Vistas.Vistas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="mt-4 text-center">Gestión de Usuarios</h2>

            
            <div class="card mt-4">
                <div class="card-body">
                    <h4 class="card-title">Agregar Nuevo Usuario</h4>
                    <div class="form-group">
                        <label for="txtNombre">Nombre:</label>
                        <asp:TextBox ID="txtNombre" runat="server" class="form-control" aria-label="Nombre del usuario"></asp:TextBox>
                    </div>
                    <div class="form-group mt-2">
                        <label for="txtCorreo">Correo:</label>
                        <asp:TextBox ID="txtCorreo" runat="server" class="form-control" aria-label="Correo del usuario"></asp:TextBox>
                    </div>
                    <div class="form-group mt-2">
                        <label for="txtContraseña">Contraseña:</label>
                        <asp:TextBox ID="txtContraseña" runat="server" TextMode="Password" class="form-control" aria-label="Contraseña del usuario"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Usuario" OnClick="btnAgregar_Click" CssClass="btn btn-primary mt-3" />
                </div>
            </div>

           
            <h3 class="mt-4">Usuarios Registrados</h3>
            <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="False"
                          OnRowEditing="gvUsuarios_RowEditing" OnRowDeleting="gvUsuarios_RowDeleting"
                          OnRowUpdating="gvUsuarios_RowUpdating" OnPageIndexChanging="gvUsuarios_PageIndexChanging"
                          CssClass="table table-bordered table-hover mt-4" DataKeyNames="UsuarioID" AllowPaging="True" PageSize="5">
                <Columns>
                    
                    <asp:BoundField DataField="UsuarioID" HeaderText="ID" ReadOnly="True" SortExpression="UsuarioID" />

                   
                    <asp:TemplateField HeaderText="Nombre">
                        <ItemTemplate>
                            <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Nombre") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditNombre" runat="server" Text='<%# Bind("Nombre") %>' class="form-control" aria-label="Editar Nombre"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Correo">
                        <ItemTemplate>
                            <asp:Label ID="lblCorreo" runat="server" Text='<%# Eval("Correo") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCorreo" runat="server" Text='<%# Bind("Correo") %>' class="form-control" aria-label="Editar Correo"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Contraseña">
                        <ItemTemplate>
                            <asp:Label ID="lblContraseña" runat="server" Text='<%# Eval("Contraseña") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditContraseña" runat="server" Text='<%# Bind("Contraseña") %>' TextMode="Password" class="form-control" aria-label="Editar Contraseña"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>

                
                <PagerSettings Mode="NextPrevious" NextPageText="Siguiente" PreviousPageText="Anterior" />
                <PagerStyle CssClass="pagination" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </form>
</body>
</html>
