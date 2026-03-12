<%@page import="com.udea.logica.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insertar Empresa</title>
</head>
<body>

<h1>INSERTAR NUEVA EMPRESA</h1>

<%
    String mensaje = "";
    String rut = request.getParameter("rut");
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");

    if (rut != null && !rut.trim().equals("")) {
        consulta_empresa con = new consulta_empresa();
        boolean resultado = con.insertarEmpresa(rut.trim(), nombre.trim(), direccion.trim());
        if (resultado) {
            response.sendRedirect("Respuesta.jsp?msg=Empresa insertada correctamente&tipo=ok");
            return;
        } else {
            mensaje = "Error al insertar la empresa. Verifique que el RUT no exista.";
        }
    }
%>

<% if (!mensaje.equals("")) { %>
    <p style="color:red;"><b><%= mensaje %></b></p>
<% } %>

<form method="post">
    <table>
        <tr>
            <td><b>RUT:</b></td>
            <td><input type="text" name="rut" required/></td>
        </tr>
        <tr>
            <td><b>Nombre:</b></td>
            <td><input type="text" name="nombre" required/></td>
        </tr>
        <tr>
            <td><b>Dirección:</b></td>
            <td><input type="text" name="direccion" required/></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Guardar"/>
            </td>
        </tr>
    </table>
</form>

<br>
<a href="buscar.jsp">Volver al listado</a>

</body>
</html>
