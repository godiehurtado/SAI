﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ColpatriaSAI.Negocio.Entidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Topes x Edad - Sistema de Administración de Incentivos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Topes por Edad</h2>

    <script type="text/javascript">
    function mostrarDialog(pagina, titulo, dialog) {
        $("#" + dialog).dialog({
            height: 200, width: 300, modal: true, title: titulo,
            open: function (event, ui) { $(this).load(pagina); },
            close: function (event, ui) { $(this).dialog('destroy'); $(this).dialog("close"); }
        });
    }

    function mostrarDialog1(pagina, titulo, dialog) {
        $("#" + dialog).dialog({
            height: 190, width: 300, modal: true, title: titulo,
            open: function (event, ui) { $(this).load(pagina); },
            close: function (event, ui) { $(this).dialog('destroy'); $(this).dialog("close"); }
        });
    }

    function cerrarDialog(dialog) {
        $("#" + dialog).dialog('destroy'); $("#" + dialog).dialog("close");
    }
    $(document).ready(function () {
        oTable = $('#tablaLista').dataTable({"bJQueryUI": true,"sPaginationType": "full_numbers","bStateSave": true});
        $("#bAnterior").button({ icons: { primary: "ui-icon-circle-arrow-w"} });
        $("#compania_id option").each(function () {
            $(this).attr({ 'title': $.trim($(this).html()) });
        });  
    });    
    </script>

    <%--VALIDATOR--%>
            <script type="text/javascript">
                $.validator.setDefaults({
                    
                });

                $().ready(function () {
                      $("#formTopexEdad").validate();
                   
                    $("#formTopexEdad").validate({
                        rules: {
                            nombre: "required"
                        },                        
                    });  
                });
            </script>

             <script type="text/javascript">
                 $(function () {
                     var companias = $("#compania_id");
                     var ramos = $("#ramo_id");
                     var productos = $("#producto_id");
                     companias.change(function () {
                         ramos.find('option').remove();
                         $("#producto_id").attr("disabled", "disabled");
                         $("<option value='0' selected>Todas</option>").appendTo(productos);
                         $.getJSON('/TopexEdad/getRamos', { compania_id: companias.val() }, function (data) {
                             $("<option value='0' selected>Todas</option>").appendTo(ramos);
                             $(data).each(function () {
                                 $("<option value=" + this.id + ">" + this.nombre + "</option>").appendTo(ramos);
                             });
                         });
                     });
                 });
            </script>

             <script type="text/javascript">
                 $(function () {
                     var ramos = $("#ramo_id");
                     var productos = $("#producto_id");
                     ramos.change(function () {
                         productos.find('option').remove();
                         $("#producto_id").removeAttr("disabled");
                         $.getJSON('/TopexEdad/getProductos', { ramo_id: ramos.val() }, function (data) {
                             $("<option value='0' selected>Todas</option>").appendTo(productos);
                             $(data).each(function () {
                                 $("<option value=" + this.id + ">" + this.nombre + "</option>").appendTo(productos);
                             });
                         });
                     });
                 });
            </script>

            <script type="text/javascript">
                function topeEdadSave() {
                    if ($("#formTopexEdad").valid()) {
                        $("#crear").attr('disabled', true);
                        $("#formTopexEdad").submit();
                        mostrarCargando("Enviando informacion. Espere Por Favor...");
                    }
                }
            </script>

     <script  type="text/javascript">javascript: window.history.forward(1);</script>

       
     <% if (TempData["Mensaje"] != null)
       { %>
        <div id="Mensaje" style="display:none;"><%: TempData["Mensaje"] %></div>
    <% } %>

    <table id="tablaAdmin">
        <tr valign="top">
            <td>
          
                <% using (Html.BeginForm("Crear", "TopexEdad", FormMethod.Post, new { id = "formTopexEdad" }))
                   {
                    Html.ValidationSummary(true); %>
                    <% ColpatriaSAI.UI.MVC.Models.TopexEdadViewModel topexedad = (ColpatriaSAI.UI.MVC.Models.TopexEdadViewModel)ViewData["TopexEdadViewModel"]; %>
                    
                    <fieldset style="border:1px solid gray">
                    <table>
                     <tr>
                        <td><u><%: Html.Label("Compañia")%></u></td>
                        <td><%: Html.DropDownList("compania_id", (SelectList)topexedad.CompaniaList, "Seleccione un Valor", new { style = "width:300px;", @class = "required" })%></td>
                     </tr>
                     <tr>
                        <td><%: Html.Label("Ramo")%></td>
                        <td><%: Html.DropDownList("ramo_id", new List<SelectListItem>(), "Todas", new { style = "width:300px;" })%></td>
                     </tr>
                     <tr>
                        <td><%: Html.Label("Producto")%></td>
                        <td><%: Html.DropDownList("producto_id", new List<SelectListItem>(), "Todas", new { style = "width:300px;" })%></td>
                     </tr>
                     <tr>
                        <td><u><%: Html.Label("Tope") %></u></td>
                        <td><%: Html.TextBox("tope", null, new { @class = "required decimal" })%></td>
                     </tr>
                     <tr>
                        <td><u><%: Html.Label("Edad") %></u></td>
                        <td><%: Html.TextBox("edad", null, new { @class = "required number" })%></td>
                     </tr>               
                    </table>
                    </fieldset>
                      

                    <input type="hidden" id="maestromoneda_id" name="maestromoneda_id" value="<%: ViewData["value"] %>" />
                    <p><input type="button" value="Guardar" id = "crear" onclick="topeEdadSave()" /></p>

                    <table align = "center">
                    <tr>
                        <td><a href="../MaestroMonedaxNegocio" id="bAnterior">Atrás</a></td> 
                    </tr>
                    </table>

                <% } %>

            </td>
        </tr>
    </table>    

     <table id="tablaLista">
                <thead>
                    <tr>
                        <th align = "center">Opciones</th>                       
                        <th align = "center">Compañia</th>
                        <th align = "center">Ramo</th>
                        <th align = "center">Producto</th>
                        <th align = "center">Tope</th>
                        <th align = "center">Edad</th>                 
                    </tr>
                </thead>
                <tbody>
                  <%  string ruta = Request.Url.ToString().Split('?')[0].ToString(); if (!ruta.EndsWith("/")) { ruta = ruta + "/"; } %>
                <% Random random = new Random();
                   int num = random.Next(1, 10000);  %>
                <% foreach (var item in ((IEnumerable<TopexEdad>)ViewData["TopexEdads"]))
                   { %>
                    
                    <tr>
                        <td align= "center">
                            <a href="javascript:mostrarDialog('<%: ruta %>Editar/<%: item.id %>?r=<%: num %>', 'Editar', 'dialogEditar');" style='float:left;' title='Editar Tope'><span class='ui-icon ui-icon-pencil'/></a>
                            <a href="javascript:mostrarDialog1('<%: ruta %>Eliminar/<%: item.id %>?r=<%: num %>', 'Eliminar', 'dialogEliminar');" style='float:right;' title='Eliminar Tope'><span class='ui-icon ui-icon-trash'/></a>
                        </td>
                  
                        <td align = "center"><%: item.Compania.nombre %></td>
                        <td align = "center"><%: item.Ramo.nombre %></td>
                        <td align = "center"><%: item.Producto.nombre %></td>
                        <td align = "center"><%: String.Format("{0:0.00}",item.tope) %></td>                        
                        <td align = "center"><%: item.edad %></td>              
                    </tr>
                <% } %>
                </tbody>
                </table>   

    
    <div id='dialogEditar' style="display:none;"></div>
    <div id='dialogEliminar' style="display:none;"></div>

</asp:Content>
