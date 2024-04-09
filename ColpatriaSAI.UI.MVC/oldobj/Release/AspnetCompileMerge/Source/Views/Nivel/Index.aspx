<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ColpatriaSAI.Negocio.Entidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Nivel
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        function mostrarDialog(pagina, titulo, dialog) {
            $("#" + dialog).dialog({
                height: 160, width: 350, modal: true, title: titulo,
                open: function (event, ui) { $(this).load(pagina); },
                close: function (event, ui) { $(this).dialog('destroy'); $(this).dialog("close"); }
            });
        }

        function cerrarDialog(dialog) {
            $("#" + dialog).dialog('destroy'); $("#" + dialog).dialog("close");
        }
        $(document).ready(function () {
            oTable = $('#tablaLista').dataTable({
                "bJQueryUI": true,
                "sPaginationType": "full_numbers","bStateSave": true
            });
        });
    </script>

    <%--VALIDATOR--%>
            <script type="text/javascript">
                $().ready(function () {
                    $("#formNivel").validate({
                        rules: {
                            nombre: "required"
                        }
                    });               

                });
            </script>
    <h2>Nivel</h2>
    
    <% if (TempData["Mensaje"] != null)
       { %>
        <div id="Mensaje" style="display:none;"><%: TempData["Mensaje"] %></div>
    <% } %>

    <%  string ruta = Request.Url.ToString();  if (!ruta.EndsWith("/")) { ruta = Request.Url + "/"; } %>

    <table id="tablaAdmin">
        <tr valign="top">
            <td>
                <h4>Crear Nivel</h4>
                <% using (Html.BeginForm("Crear", "Nivel", FormMethod.Post, new { id = "formNivel"}))
                   {
                    Html.ValidationSummary(true); %>
                    <% ColpatriaSAI.UI.MVC.Models.NivelViewModel nivel = (ColpatriaSAI.UI.MVC.Models.NivelViewModel)ViewData["NivelViewModel"]; %>
                    <table>
                        <tr>
                            <td><%: Html.Label("Nombre") %></td>
                            <td>
                                <%: Html.TextBox("nombre", null, new { @class = "required", maxlength = 70 })%>
                                <%: Html.ValidationMessageFor(Model => nivel.NivelView.nombre)%>
                            </td>
                        </tr>
                    </table>

                    <p><input type="submit" value="Crear" id="crear" /></p>
                <% } %>

            </td>
            <td>

                <table id="tablaLista">
                <thead>
                    <tr>
                        <th>Opciones</th>
                        <th>Código</th>
                        <th>Nivel</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% Random random = new Random();
                   int num = random.Next(1, 10000);  %>
                <% foreach (var item in ((IEnumerable<Nivel>)ViewData["Niveles"]))
                   { %>
                    <tr>
                        <td align="center">
                            <a href="javascript:mostrarDialog('<%: ruta %>Editar/<%: item.id %>?r=<%: num %>', 'Editar nivel:  <%: item.nombre %>', 'dialogEditar');">Editar</a> |
                            <a href="javascript:mostrarDialog('<%: ruta %>Eliminar/<%: item.id %>?r=<%: num %>', 'Eliminar nivel:  <%: item.nombre %>', 'dialogEliminar');">Eliminar</a>
                        </td>
                        <td><%: item.id %></td>
                        <td><%: item.nombre %></td>
                        </tr>
                <% } %>
                </tbody>
                </table>

            </td>
        </tr>
    </table>    
    
    <div id='dialogEditar' style="display:none;"></div>
    <div id='dialogEliminar' style="display:none;"></div>
</asp:Content>