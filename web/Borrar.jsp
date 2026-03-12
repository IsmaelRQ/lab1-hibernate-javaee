<%@page import="com.udea.hb.Empresa"%>
<%@page import="com.udea.logica.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Empresa</title>
</head>
<body>

<h1>ELIMINAR EMPRESA</h1>

<%
    String mensaje = "";
    String accion = request.getParameter("accion");
    String rut = request.getParameter("rut");

    consulta_empresa con = new consulta_empresa();

    if (accion != null && accion.equals("eliminar")) {
        boolean resultado = con.eliminarEmpresa(rut.trim());
        if (resultado) {
            response.sendRedirect("Respuesta.jsp?msg=Empresa eliminada correctamente&tipo=ok");
            return;
        } else {
            mensaje = "Error al eliminar la empresa.";
        }
    }

    Empresa empresa = null;
    if (rut != null && !rut.trim().equals("") && (accion == null || !accion.equals("eliminar"))) {
        empresa = con.obtenerEmpresaPorRut(rut.trim());
        if (empresa == null) {
            mensaje = "No se encontró una empresa con el RUT: " + rut;
        }
    }
%>

<% if (!mensaje.equals("")) { %>
    <p style="color:red;"><b><%= mensaje %></b></p>
<% } %>

<% if (empresa == null) { %>
    <!-- Formulario para buscar la empresa a eliminar -->
    <form method="get">
        <table>
            <tr>
                <td><b>Ingrese el RUT de la empresa a eliminar:</b></td>
                <td><input type="text" name="rut" required/></td>
                <td><input type="submit" value="Buscar"/></td>
            </tr>
        </table>
    </form>
<% } else { %>
    <!-- Confirmación de eliminación -->
    <p>¿Está seguro de que desea eliminar la siguiente empresa?</p>
    <table border="1" cellpadding="5">
        <tr>
            <th>RUT</th>
            <th>NOMBRE</th>
            <th>DIRECCION</th>
        </tr>
        <tr>
            <td><%= empresa.getRut() %></td>
            <td><%= empresa.getNombre() %></td>
            <td><%= empresa.getDireccion() %></td>
        </tr>
    </table>
    <br>
    <form method="post">
        <input type="hidden" name="accion" value="eliminar"/>
        <input type="hidden" name="rut" value="<%= empresa.getRut() %>"/>
        <input type="submit" value="Confirmar Eliminación"/>
    </form>
<% } %>

<br>
<a href="buscar.jsp">Volver al listado</a>

</body>
</html>
