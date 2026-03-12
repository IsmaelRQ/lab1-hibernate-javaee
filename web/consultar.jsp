<%-- 
    Document   : consultar
    Created on : 14/02/2026, 10:01:49 AM
    Author     : Diego
--%>

<%@page import="com.udea.hb.Empresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.udea.logica.*" %>
<%@page import="java.util.List"  %>
<%@page import="java.util.Iterator"  %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>LISTADO DE EMPRESAS</h1>
        
        <!-- BOTONES DE NAVEGACIÓN -->
        <a href="Guardar.jsp"><button>Insertar Nueva Empresa</button></a>
        <a href="Modificar.jsp"><button>Modificar Empresa</button></a>
        <a href="Borrar.jsp"><button>Eliminar Empresa</button></a>
        <a href="buscar.jsp"><button>Buscar Empresa</button></a>
        
        <br><br>
        
        <% 
          consulta_empresa con = new consulta_empresa();
          List em=con.getEmpresa();
          Iterator it= em.iterator();
          out.println("<TABLE Border=1 CellPadding=5><TR>");
           out.println("<th>RUT</th><th>NOMBRE</th><th>DIRECCION</th><th>ACCIONES</th></TR>");
           while(it.hasNext()){
           
           Empresa e=(Empresa) it.next();
            out.println("<TR>");
             out.println("<TD>" +e.getRut()+"</TD>");
              out.println("<TD>" +e.getNombre()+"</TD>");
               out.println("<TD>" +e.getDireccion()+"</TD>");
               out.println("<TD>");
               out.println("<a href='Modificar.jsp?rut=" + e.getRut() + "'>Modificar</a> | ");
               out.println("<a href='Borrar.jsp?rut=" + e.getRut() + "'>Eliminar</a>");
               out.println("</TD>");
             
              out.println("</TR>");  };
               out.println("</TABLE>");
              
        %>
    </body>
</html>
