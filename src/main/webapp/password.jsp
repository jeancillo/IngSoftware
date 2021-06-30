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

    <body>
        <%  String msg = (String) request.getAttribute("msg");
        %>
        <div class="container demo-1">
            <div class="content">
                <div id="large-header" class="large-header">
                    <h1><marquee>Bienvenido a Villa Flash Net</marquee></h1><br><br><br>
                    <div class="main-agileits">
                        <!--form-stars-here-->
                        <div class="form-w3-agile">
                            <h2>Recuperacion de Contraseña</h2>
                            <form action="Password_srv" method="post">
                                <div class="form-sub-w3">
                                    <input type="text" name="codRecuperacion" placeholder="Codigo de Recuperacion" />
                                    <div class="icon-w3">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="form-sub-w3">
                                    <div class="clear"></div>
                                    <div class="icon-w3">
                                        <i class="" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <p class="p-bottom-w3ls"><a class href="#"></a></p>
                                <p class="p-bottom-w3ls1"><a class href="#"></a></p>
                                <div class="clear"></div>
                                <div class="submit-w3l">
                                    <input type="submit" name="accion" value="Recuperar">
                                </div>
                                <div class="submit-w3l">
                                    <input type="submit" name="accion" value="Regresar">
                                </div>
                                <div>
                                    <label style="font-size: 12px; color: red">
                                        <!--- mensaje  de error-->
                                        <span class="msg"><%=msg != null ? msg : ""%></span>
                                    </label>  
                                </div>
                                <div class="clear"></div>
                                <div class="clear"></div>
                            </form><br>
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
