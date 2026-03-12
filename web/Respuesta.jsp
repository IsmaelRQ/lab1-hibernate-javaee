<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Respuesta</title>
</head>
<body>

<%
    String msg = request.getParameter("msg");
    String tipo = request.getParameter("tipo");

    if (msg == null) {
        msg = "Operación realizada.";
    }
    if (tipo == null) {
        tipo = "ok";
    }
%>

<h1>RESULTADO DE LA OPERACIÓN</h1>

<% if (tipo.equals("ok")) { %>
    <p style="color:green; font-size:16px;"><b><%= msg %></b></p>
<% } else { %>
    <p style="color:red; font-size:16px;"><b><%= msg %></b></p>
<% } %>

<br>
<a href="buscar.jsp">Ver listado de empresas</a> |
<a href="Guardar.jsp">Insertar otra empresa</a>

</body>
</html>
