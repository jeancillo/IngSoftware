<%-- 
    Document   : login.jsp
    Created on : 1 jun. 2021, 11:50:52
    Author     : PIERO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>VILLA FLASH NET</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Clean Login Form Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />

        <!-- css files -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <!-- /css files -->

        <!-- online fonts -->
        <link href="//fonts.googleapis.com/css?family=Sirin+Stencil" rel="stylesheet">
        <!-- online fonts -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="sweetalert2/dist/sweetalert2.all.min.js"></script>
    </head>
    <body>
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
                                    <input type="password" name="pass" placeholder="Password" required="" />
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
