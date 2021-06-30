<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="modelo.Usuario"%>
<!--Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>VILLA FLASH NET</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Clean Login Form Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />

        <!-- css files -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <!-- /css files -->
        <link href='images/ordenador-portatil.ico' rel='icon' >
        <!-- online fonts -->
        <link href="//fonts.googleapis.com/css?family=Sirin+Stencil" rel="stylesheet">
        <!-- online fonts -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="sweetalert2/dist/sweetalert2.all.min.js"></script>

    <body>
        
        <script>
            //funcion para no volver al index
            window.onload = function () {
                window.location.hash = "";
                window.location.hash = "Again-No-back-button"

                window.onhashchange = function () {
                    window.location.hash = ""
                }
            }
        </script>
        <c:if test="${not empty msg}">
            <c:if test="${msg==true}">
                <script type="text/javascript">
                    Swal.fire({
                        title: 'USUARIO IDENTIFICADO CORRECTAMENTE',
                        icon: 'success',
                        text: 'Los datos ingresados son correctos',
                        showCancelButton: true,
                        showCancelButton: false,
                        confirmButtonText: `OK`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            window.location = 'principal.jsp';
                        }
                    })
                </script>  
            </c:if>
            <c:if test="${msg==false}">
                <script type="text/javascript">
                    Swal.fire({
                        title: 'USUARIO INCORRECTO',
                        text: 'Los datos ingresados son incorrectos',
                        icon: 'error',
                        showCancelButton: true,
                        showCancelButton: false,
                        confirmButtonText: `OK`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            window.location = 'index.jsp';
                        }
                    })
                </script>
            </c:if>
            <c:if test="${msg=='recup'}">
                <script type="text/javascript">
                    Swal.fire({
                        title: 'DATOS DE RECUPERACION',
                        icon: 'info',
                        text: 'La contraseña se ha reestablecido a sus datos de fabrica',
                        showCancelButton: true,
                        showCancelButton: false,
                        confirmButtonText: `OK`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            window.location = 'index.jsp';
                        }
                    })
                </script>
            </c:if>
            <c:if test="${msg=='codNull'}">
                <script type="text/javascript">
                    Swal.fire({
                        title: 'ERROR EN CODIGO DE RECUPERACION',
                        icon: 'error',
                        text: 'El codigo ingresado no corresponde a ningun usuario',
                        showCancelButton: true,
                        showCancelButton: false,
                        confirmButtonText: `OK`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            window.location = 'index.jsp';
                        }
                    })
                </script>
            </c:if>
        </c:if>
        <div class="container demo-1">
            <div class="content">
                <div id="large-header" class="large-header">
                    <h1><marquee>Bienvenido a Villa Flash Net</marquee></h1><br><br> 
                    <div class="main-agileits">
                        <!--form-stars-here-->
                        <div class="form-w3-agile">
                            <h2>Iniciar Sesion</h2>
                            <form action="Login_srv" method="post">
                                <div class="form-sub-w3">
                                    <input type="text" name="user" placeholder="Username " required="" />
                                    <div class="icon-w3">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="form-sub-w3">
                                    <input id = "pas" type="password" name="pass" placeholder="Password" required="" />
                                    <div class="icon-w3">
                                        <i class="fa fa-unlock-alt" aria-hidden="true"></i>
                                    </div>
                                </div>
                               
                                <div class="clear"></div>
                                <p class="p-bottom-w3ls">¿Has olvidado tu contraseña?<a class href="Password_srv?accion=Formulario">  Click Aqui</a></p>
                                <p class="p-bottom-w3ls1"><a class href="#"></a></p>
                                <div class="clear"></div>
                                <div class="submit-w3l">
                                    <input type="submit" name="accion" value="Login">
                                </div>
                                <div class="clear"></div>
                            </form>
                        </div>
                        <!--//form-ends-here-->
                    </div><!-- copyright -->
                    <div class="copyright w3-agile">
                        <p> © 2021 VILLA FLASH NET . All rights reserved</p>
                    </div>
                    <!-- //copyright --> 
                </div>
            </div>
        </div>	
    </body> 
</html>
