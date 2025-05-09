﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ColpatriaSAI.Negocio.Entidades" %>

<asp:Content ID="Content3" ContentPlaceHolderID="TitleContent" runat="server">
	Tipo de Premios
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Tipo de Premios</h2>

    <script type="text/javascript">
        function mostrarDialog(pagina, titulo, dialog) {
            $("#" + dialog).dialog({
                height: 230, width: 350, modal: true, title: titulo,
                open: function (event, ui) { $(this).load(pagina); },
                close: function (event, ui) { $(this).dialog('destroy'); $(this).dialog("close"); }
            });
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
                    $("#formTipoPremio").validate({
                        rules: {
                            nombre: "required",
                            codigoCore: "required"
                        },
                        submitHandler: function (form) {
                            $("#crear").attr('disabled', true);
                            form.submit();
                        }
                    });

                });
            </script>

            <script  type="text/javascript">javascript: window.history.forward(1);</script>
            
    <% if (TempData["Mensaje"] != null)
       { %>
        <div id="Mensaje" style="display:none;"><%: TempData["Mensaje"] %></div>
    <% } %>

    <table id="tablaAdmin">
        <tr valign="top">
            <td>

                <% Html.EnableClientValidation(); %>
                <% using (Html.BeginForm("Crear", "TipoPremio", FormMethod.Post, new { id = "formTipoPremio" }))
                   {
                    Html.ValidationSummary(true); %>
                    <% ColpatriaSAI.UI.MVC.Models.TipoPremioViewModel tipopremio =
                           (ColpatriaSAI.UI.MVC.Models.TipoPremioViewModel)ViewData["TipoPremioViewModel"]; %>
                    <table>
                       <tr>
                       <td>
                           <%: Html.Label("Nombre") %>
                       </td>
                       <td>
                            <%: Html.TextBox("nombre", null, new { @class = "required" })%>
                            <%: Html.ValidationMessageFor(Model => tipopremio.TipoPremioView.nombre)%>
                       </td>                   
                       </tr> 
                       <tr>
                       <td> 
                            <%: Html.Label("Unidad de Medida")%>
                       </td>
                       <td>
                            <%: Html.DropDownList("unidadmedida_id", (SelectList)tipopremio.UnidadMedidaList, "Seleccione un valor", new { @class = "required" })%>
                       </td>
                       </tr>
                       <tr>
                       <td>
                            <%: Html.Label("Genera Pago")%>
                       </td>
                       <td>
                            <%: Html.DropDownList("generapago", (SelectList)tipopremio.PagoList, "Seleccione un valor", new { @class = "required" })%>
                       </td>
                       </tr>
                       </table>
                            
                       <p><input type="submit" value="Guardar" id="crear" /></p>
                            
                        <p><a href="../Premio">Atrás</a></p>  
                <% } %>
       

                <table  id="tablaLista">
                     <thead>
                    <tr>
                        <th>Opciones</th>
                        <th>Nombre</th>
                        <th>Unidad de Medida</th>
                        <th>Genera Pago</th>
                        
                    </tr>
                <%  string ruta = Request.Url.ToString();  if (!ruta.EndsWith("/")) { ruta = Request.Url + "/"; } %>
                 </thead>
      <tbody>
      <% Random random = new Random();
                   int num = random.Next(1, 10000);  %>
                <% foreach (var item in ((IEnumerable<TipoPremio>)ViewData["TipoPremios"]))
                   { %>
                    <tr>
                        <td align=center>
                           <a href="javascript:mostrarDialog('<%: ruta %>Editar/<%: item.id %>?r=<%: num %>', 'Editar', 'dialogEditar');">Editar</a> |
                            <a href="javascript:mostrarDialog('<%: ruta %>Eliminar/<%: item.id %>?r=<%: num %>', 'Eliminar', 'dialogEliminar');">Eliminar</a>
                        </td>
                        
                        <td align="center"><%: item.nombre %></td>
                        <td align="center"><%: item.UnidadMedida.nombre %></td>
                        <td align="center"><%: (item.generapago == "Si") ? "Si" : "No" %></td>
                        
                    </tr>
                <% } %>

                  </tbody>

        </tfoot>--%>
                </table>

            </td>
        </tr>
    </table>

    <div id='dialogEditar' style="display:none;"></div>
    <div id='dialogEliminar' style="display:none;"></div>
</asp:Content>
