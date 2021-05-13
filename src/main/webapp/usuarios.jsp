<%@page import="dao.Personaldao"%>
<%@page import="modelo.Personal"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Usuario"%>
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
            if (us == null) {
                response.sendRedirect("index.jsp");
            }%><%else {

                    Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
        %>
        <div class="header">
            <div class="header_top">
                <div class="wrap">		
                    <div class="logo">
                        <a href="principal.jsp"><img src="images/villa flash.png" alt="" /></a>
                    </div>	
                    <div class="menu">
                        <ul>
                            <li><a href="principal.jsp">Home</a></li>
                            <li><a href="#">Domains</a></li>
                            <li class="active"><a href="Usuarios_srv?menu=Usuarios&accion=Listar">Usuarios</a></li>
                            <li><a href="#">Support</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="CerrarSesion_srv">Cerrar Sesion</a></li>
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="content_bottom" id="account">
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nuevo usuario</p>
                    <form action="Usuarios_srv?menu=Usuarios" method="POST"> 
                        <input name="us" type="text" placeholder="Username" class="field" required>
                        <input name="pas" type="text" placeholder="Password" class="field" required> 
                        <select id="country" name="cmbo_tps" onchange="change_country(this.value)" class="frm-field required">
                            <c:forEach var="tip" items="${tipos}">
                                <option value=${tip.getIdTipoUser()}>${tip.getTipoUser()}</option>      
                            </c:forEach>
                        </select>
                        <select id="country" name="cmbo_prs" onchange="change_country(this.value)" class="frm-field required">

                            <c:forEach var="prs" items="${personal}">
                                <option value=${prs.getIdPersonal()}>${prs.getNombre()} ${prs.getApellido()}</option>     
                            </c:forEach>
                        </select>
                        <div class="login"><input type="submit" name="accion" value="Agregar"></div>
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
        <div class="main">
            <div class="wrap">
                <div class="plans">
                    <h3>Usuarios Registrados</h3>
                    <div class="plans_table">
                        <table width="100%" cellspacing="0" class="compare_plan">
                            <thead>
                                <tr>
                                    <th class="plans-list"><h3>Nombre</h3></th>
                                    <th class="plans-list"><h3>Tipo</h3></th>
                                    <th class="plans-list"><h3>Estado</h3></th>
                                    <th class="plans-list"><h3>Acciones</h3></th>
                                </tr>
                            </thead>		
                            <tbody>
                                <c:forEach var="us" items="${user}">
                                    <tr>
                                        <td class="plan_list_title">${us.getUser()}</td>
                                        <td class="price_body">${us.getIdTipoUser()}</td>
                                        <td class="price_body">${us.getEstado()}</td>
                                        <td>
                                            <a class="btn btn-warning" href="Usuarios_srv?menu=Usuarios&accion=Editar&id=${us.getIdUsuario()}" ><i class="fas fa-edit"></i></a>
                                            <a class="btn btn-warning" href="Usuarios_srv?menu=Usuarios&accion=Estado&id=${us.getIdUsuario()}" ><i class="fas fa-user-times"></i></a>

                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody></table>
                    </div> 			 
                </div>
            </div>
        </div> 
    </div>
    <div class="copy_right">
        <p> &copy; 2013 Retail_hosting. All rights reserved |  <%=p.getNombre()%> <%=p.getApellido()%> <a href="CerrarSesion_srv">Salir</a></p>
    </div>
    <%}
    %>
</body>
</html>

