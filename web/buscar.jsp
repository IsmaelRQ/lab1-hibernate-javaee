<%@page import="com.udea.hb.Empresa"%>
<%@page import="com.udea.logica.*" %>
<%@page import="java.util.List"  %>
<%@page import="java.util.Iterator"  %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Empresas</title>
</head>
<body>

<h1>LISTADO DE EMPRESAS</h1>

<!-- BOTONES DE NAVEGACIÓN -->
<a href="Guardar.jsp"><button>Insertar Nueva Empresa</button></a>
<a href="Modificar.jsp"><button>Modificar Empresa</button></a>
<a href="Borrar.jsp"><button>Eliminar Empresa</button></a>

<br><br>

<!-- FORMULARIO DE BÚSQUEDA -->
<form method="post">
    Buscar por:
    <select name="criterio">
        <option value="rut">RUT</option>
        <option value="nombre">Nombre</option>
    </select>
    <input type="text" name="valor"/>
    <input type="submit" value="Buscar"/>
</form>

<br><br>

<%
    consulta_empresa con = new consulta_empresa();
    List em = null;

    String criterio = request.getParameter("criterio");
    String valor = request.getParameter("valor");

    if (valor != null && !valor.trim().equals("")) {
        em = con.buscarEmpresa(criterio, valor);
    } else {
        em = con.getEmpresa();
    }

    if (em != null) {
    Iterator it = em.iterator();

    out.println("<TABLE Border=1 CellPadding=5>");
    out.println("<TR><th>RUT</th><th>NOMBRE</th><th>DIRECCION</th><th>ACCIONES</th></TR>");

    while(it.hasNext()) {
        Empresa e = (Empresa) it.next();
        out.println("<TR>");
        out.println("<TD>" + e.getRut() + "</TD>");
        out.println("<TD>" + e.getNombre() + "</TD>");
        out.println("<TD>" + e.getDireccion() + "</TD>");
        out.println("<TD>");
        out.println("<a href='Modificar.jsp?rut=" + e.getRut() + "'>Modificar</a> | ");
        out.println("<a href='Borrar.jsp?rut=" + e.getRut() + "'>Eliminar</a>");
        out.println("</TD>");
        out.println("</TR>");
    }
    }
    out.println("</TABLE>");
%>

</body>
</html>
