<%@page import="dao.Personaldao"%>
<%@page import="modelo.Personal"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Usuario"%>
<%@page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html>
    <head>
        <title>VILLA FLASH NET</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="css/style_1.css" rel="stylesheet" type="text/css" media="all"/>
        <link href='//fonts.googleapis.com/css?family=Electrolize' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/a881412379.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1200);
                });
            });
        </script>
    </head>
    <body>
        <%
            String msg = (String) request.getAttribute("msg");
            HttpSession s = request.getSession();
            Usuario us = (Usuario) s.getAttribute("us");
            Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
            Personal pEdit = (Personal) request.getAttribute("pers");
        %>
        <div class="header">
            <div class="header_top">
                <div class="wrap">		
                    <div class="logo">
                        <a href="principal.jsp"><img src="images/villa flash.png" alt="" /></a>
                    </div>	
                    <div class="menu">
                        <ul>
                            <li><a href="principal.jsp">Inicio</a></li>
                            <li class="active"><a href="Personal_srv?menu=Personal&accion=Listar">Personal</a></li>
                            <li><a href="Usuarios_srv?menu=Usuarios&accion=Listar">Usuarios</a></li>
                            <li><a href="#">Support</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="CerrarSesion_srv?btn=true">Cerrar Sesion</a></li>
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <%if (pEdit == null) {%>
        <div class="content_bottom" id="account">
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nuevo empleado</p>
                    <form action="Personal_srv?menu=Personal" method="POST" enctype="multipart/form-data"> 
                        <input name="nom" type="text" placeholder="Nombre" class="field" value="${pers.getNombre()}" required>
                        <input name="ape" type="text" placeholder="Apellido" class="field" value="${pers.getApellido()}" required> 
                        <input name="dni" type="text" placeholder="DNI" class="field" size="10" maxlength="8" value="${pers.getDni()}" required>
                        <input name="img" type="file"  class="field" value="${pers.getImg()}"required>
                        <div class="clear"></div><br>
                        <div class="login" style="float: right;"><input type="submit" name="accion" value="Agregar"></div>
                        <div>
                            <label style="font-size: 12px; color: red">
                                <!--- mensaje  de error-->
                                <span class="msg"><%=msg != null ? msg : ""%></span>
                            </label>  
                        </div>
                    </form>
                </div>
            </div>              
            <div class="clear"></div>
        </div>
        <%} else {%>
        <div class="content_bottom" id="account">
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nuevo empleado</p>
                    <form action="Personal_srv?menu=Personal" method="POST" enctype="multipart/form-data"> 
                        <input name="nom" type="text" placeholder="Nombre" class="field" value="${pers.getNombre()}" required>
                        <input name="ape" type="text" placeholder="Apellido" class="field" value="${pers.getApellido()}" required> 
                        <input name="dni" type="text" placeholder="DNI" class="field" size="10" maxlength="8" value="${pers.getDni()}" required>
                        <div class="login"><input type="submit" name="accion" value="Actualizar"></div>
                        <div>
                            <label style="font-size: 12px; color: red">
                                <!--- mensaje  de error-->
                                <span class="msg"><%=msg != null ? msg : ""%></span>
                            </label>  
                        </div>
                    </form>
                </div>
            </div>              
            <div class="clear"></div>
        </div>
        <%}%>

        <div class="main">
            <div class="wrap">
                <div class="plans">
                    <h3>Empleados Registrados</h3>
                    <div class="plans_table">
                        <table width="100%" cellspacing="0" class="compare_plan">
                            <thead>
                                <tr>
                                    <th class="plans-list"><h3>Nombre</h3></th>
                                    <th class="plans-list"><h3>Apellido</h3></th>
                                    <th class="plans-list"><h3>DNI</h3></th>
                                    <th class="plans-list"><h3>#</h3></th>
                                    <th class="plans-list"><h3>Acciones</h3></th>
                                </tr>
                            </thead>		
                            <tbody>
                                <%/*<c:forEach var="ps" items="${personal}">
                                    <tr>
                                        <td class="plan_list_title">${ps.getNombre()}</td>
                                        <td class="price_body">${ps.getApellido()}</td>
                                        <td class="price_body">${ps.getDni()}</td>
                                        <td class="price_body"><img src="Img_srv?id=${ps.getIdPersonal()}" width="50" height="50"></td>
                                        <td>
                                            <a class="btn btn-warning" href="Personal_srv?menu=Personal&accion=Editar&id=${ps.getIdPersonal()}" title="Editar"><i class="fas fa-edit"></i></a>


                                        </td>
                                    </tr>
                                </c:forEach>*/%>
                            </tbody></table>
                    </div> 			 
                </div>
            </div>
        </div> 
    </div>
    <div class="copy_right">
        <p> © 2021 VILLA FLASH NET . All rights reserved |  <%=p.getNombre()%> <%=p.getApellido()%> <a href="CerrarSesion_srv?btn=true">Salir</a></p>
    </div>
</body>
</html>

