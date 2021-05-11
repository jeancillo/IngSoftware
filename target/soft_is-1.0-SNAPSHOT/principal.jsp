<%-- 
    Document   : principal
    Created on : 5 may. 2021, 11:16:55
    Author     : PIERO
--%>

<%@page import="dao.Personaldao"%>
<%@page import="modelo.Personal"%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link href=WEB-INF/css/style.css rel="stylesheet" >
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession s = request.getSession();
            Usuario us = (Usuario) s.getAttribute("us");
            if (us == null) {
                response.sendRedirect("Error_srv");
            }%><%else {
                    
                Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
        %>
        <div class="container-fluid">
            <div class="row min-vh-100 flex-column flex-md-row">
                <aside class="col-12 col-md-3 col-xl-2 p-0 bg-dark flex-shrink-1">
                    <nav class="navbar navbar-expand-md navbar-dark bd-dark flex-md-column flex-row align-items-center py-2 text-center sticky-top" id="sidebar">
                        <div class="text-center p-3">
                            <img src="imagenes/<%=p.getImg()%>" alt="profile picture" class="img-fluid rounded-circle my-4 p-1 d-none d-md-block shadow">

                            <a href="#" class="navbar-brand mx-0 font-weight-bold text-nowrap">Bienvenido <%=us.getUser()%></a>
                        </div>
                        <button type="button" class="navbar-toggler border-0 order-1" data-toggler="collapse" data-target="#nav" aria-controls="nav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>    
                        </button>
                        <div class="collapse navbar-collapse prder-last" id="nav">
                            <ul class="navbar-nav flex-column w-100 justify-content-center">
                                <li class="nav-item">
                                    <a href="Usuarios_srv?menu=Usuarios&accion=Listar" class="nav-link active" target="myFrame">Usuarios</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link active">Edit Profile</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link active">Edit Profile</a>
                                </li>
                                <li class="nav-item">
                                     <a href="CerrarSesion_srv" class="nav-link active">Cerrar Sesion</a>
                                </li>
                            </ul>
                            <ul class="nav justify-content-center">
                                <li class="nav-item">
                                   
                                </li>    
                            </ul>
                        </div>
                    </nav> 
                </aside>    
                <div class="col px-0 flex-grow-1  " style="height: 650px;">
                    <iframe  name="myFrame" style="height: 100%;width: 100%; border: none">
                    </iframe>
                </div>      

            </div>
        </div>

        <%}
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
    </body>
</html>
