<%@page import="dao.Personaldao"%>
<%@page import="modelo.Personal"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Usuario"%>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style_1.css" rel="stylesheet" type="text/css" media="all"/>
        <link href='//fonts.googleapis.com/css?family=Electrolize' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/modernizr.custom.28468.js"></script>

        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1200);
                });
            });
        </script>
        <script src="js/responsiveslides.min.js"></script>
        <script>
// You can also use "$(window).load(function() {"
            $(function () {
// Slideshow 4
                $("#slider3").responsiveSlides({
                    auto: true,
                    pager: false,
                    nav: false,
                    speed: 500,
                    namespace: "callbacks",
                    before: function () {
                        $('.events').append("<li>before event fired.</li>");
                    },
                    after: function () {
                        $('.events').append("<li>after event fired.</li>");
                    }
                });
            });
        </script>
    </head>
    <body>
        <%
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
                            <li class="active"><a href="principal.jsp">Home</a></li>
                            <li><a href="#">Domains</a></li>
                            <li><a href="Usuarios_srv?menu=Usuarios&accion=Listar">Usuarios</a></li>
                            <li><a href="#">Support</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="CerrarSesion_srv">Cerrar Sesion</a></li>
                            
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="header_bottom">

                <div class="clear"></div>
            </div>
        </div>

        <div class="main">

            <div class="content_data">
                <div class="content">     		
                    <div class="services_heading">
                        <h2>BIENVENIDO</h2>
                        <p><%=p.getNombre()%> <%=p.getApellido()%></p>
                    </div>
                    <div class="wrap">
                        <div class="services">
                            <div class="services_list">
                                <div class="services_grid1">	
                                    <div class="services_img">
                                        <img src="images/service_1.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>Free Email Account</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="services_grid2">	
                                    <div class="services_img">
                                        <img src="images/service_2.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>Privacy Protection</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="services_list">
                                <div class="services_grid1">	
                                    <div class="services_img">
                                        <img src="images/service_3.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>24x7 Live Support</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="services_grid2">	
                                    <div class="services_img">
                                        <img src="images/service_4.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>Domain Forwarding</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="services_list">
                                <div class="services_grid1">	
                                    <div class="services_img">
                                        <img src="images/service_5.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>Bulk Tools</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="services_grid2">	
                                    <div class="services_img">
                                        <img src="images/service_6.png" alt="" />
                                    </div>
                                    <div class="services_desc">
                                        <h4>Easy to use Control Panel</h4>
                                        <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.</p>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>