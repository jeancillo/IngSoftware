<%-- 
    Document   : usuarios
    Created on : 5 may. 2021, 19:45:06
    Author     : PIERO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link href=WEB-INF/css/style.css rel="stylesheet" >
        <script src="https://kit.fontawesome.com/a881412379.js" crossorigin="anonymous"></script>s
        <title>JSP Page</title>
    </head>
    <body>

        <%
            String msg = (String)request.getAttribute("msg");
            ArrayList<Usuario> lista = (ArrayList) request.getAttribute("user");
        %>
        <div class="text-center" >
            <h1>Usuarios Registrados</h1>
        </div><br>

        <div class="d-flex ">
            <div class="col-sm-8" style="border: 5px outset black; text-align: center;">
                <% if (lista.size() != 0) { %> 
                <table id="tab" class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Nombre</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${user}" var="us">
                            <tr>
                                <td>${us.getUser()}</td>
                                <td>${us.getIdTipoUser()}</td>
                                <td>${us.getEstado()}</td>
                                <td>
                                    <a class="btn btn-warning" href="Usuarios_srv?menu=Usuarios&accion=Editar&id=${us.getIdUsuario()}" ><i class="fas fa-edit"></i></a>
                                    <a class="btn btn-warning" href="Usuarios_srv?menu=Usuarios&accion=Estado&id=${us.getIdUsuario()}" ><i class="fas fa-user-times"></i></a>
                                    <a class="btn btn-danger" href="Usuarios_srv?menu=Usuarios&accion=Delete&id=${us.getIdUsuario()}" ><i class="far fa-trash-alt"></i></a>
                                </td>
                            </tr> 
                        </c:forEach>
                    </tbody>
                </table>
                <%} else {%>
                <h3 >No hay usuarios registrados</h3>
                <%}%>
            </div>



            <div class="card col-sm-4" >
                <div class="card-body">
                    <form action="Usuarios_srv?menu=Usuarios" method="POST">
                        <div class="form-group">
                            <div align="center">
                                <h2 style="color:red">USUARIOS</h2>
                            </div>  
                            <label>Usuario</label>
                            <input type="text" name="us" class="form-control" required value=${usuario.getUser()}>

                        </div> 
                        <div class="form-group">
                            <label>Contraseña</label>
                            <input type="text"  name="pas" class="form-control" required value=${usuario.getPassword()}>
                        </div> 
                        <div class="form-group">
                            <label>Tipo Usuario</label>
                            <select name="cmbo_tps">
                                <c:forEach var="tip" items="${tipos}">
                                <option value=${tip.getIdTipoUser()}>${tip.getTipoUser()}</option>      
                                </c:forEach>
                            </select>
                        </div> 
                        <div class="form-group">
                            <label>Personal</label>
                            <select name="cmbo_prs">
                                <c:forEach var="prs" items="${personal}">
                                <option value=${prs.getIdPersonal()}>${prs.getNombre()} ${prs.getApellido()}</option>     
                                </c:forEach>
                                  
                            </select>
                        </div>
                        <input type="submit" name="accion" value="Agregar" class="btn btn-info btn-block">
                        <input type="submit" name="accion" value="Actualizar" class="btn btn-success btn-block">
                        <div>
                        <label style="font-size: 12px; color: red">
                        <!--- mensaje  de error-->
                        <span class="msg"><%=msg!= null ? msg : ""%></span>
                        </label>  
                </div>
                    </form>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
    </body>
</html>
