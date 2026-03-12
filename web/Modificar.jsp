<%@page import="com.udea.hb.Empresa"%>
<%@page import="com.udea.logica.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modificar Empresa</title>
</head>
<body>

<h1>MODIFICAR EMPRESA</h1>

<%
    String mensaje = "";
    String accion = request.getParameter("accion");
    String rut = request.getParameter("rut");
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");

    consulta_empresa con = new consulta_empresa();

    if (accion != null && accion.equals("actualizar")) {
        boolean resultado = con.actualizarEmpresa(rut.trim(), nombre.trim(), direccion.trim());
        if (resultado) {
            response.sendRedirect("Respuesta.jsp?msg=Empresa actualizada correctamente&tipo=ok");
            return;
        } else {
            mensaje = "Error al actualizar la empresa. Verifique los datos.";
        }
    }

    Empresa empresa = null;
    if (rut != null && !rut.trim().equals("") && (accion == null || !accion.equals("actualizar"))) {
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
    <!-- Formulario para buscar la empresa a modificar -->
    <form method="get">
        <table>
            <tr>
                <td><b>Ingrese el RUT de la empresa a modificar:</b></td>
                <td><input type="text" name="rut" required/></td>
                <td><input type="submit" value="Buscar"/></td>
            </tr>
        </table>
    </form>
<% } else { %>
    <!-- Formulario de edición con datos precargados -->
    <form method="post">
        <input type="hidden" name="accion" value="actualizar"/>
        <table>
            <tr>
                <td><b>RUT:</b></td>
                <td><input type="text" name="rut" value="<%= empresa.getRut() %>" readonly/></td>
            </tr>
            <tr>
                <td><b>Nombre:</b></td>
                <td><input type="text" name="nombre" value="<%= empresa.getNombre() %>" required/></td>
            </tr>
            <tr>
                <td><b>Dirección:</b></td>
                <td><input type="text" name="direccion" value="<%= empresa.getDireccion() %>" required/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Actualizar"/>
                </td>
            </tr>
        </table>
    </form>
<% } %>

<br>
<a href="buscar.jsp">Volver al listado</a>

</body>
</html>
