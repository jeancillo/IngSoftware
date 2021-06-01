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
        <%  String msg = (String) request.getAttribute("msg");
            if (msg == null) {
        %>
        <jsp:include page="formLogin.jsp"  flush="true"></jsp:include>
        <%} else if (msg.equals("true")) {%>
        <jsp:include page="formLogin.jsp" flush="true"></jsp:include>
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
        <%} else if (msg.equals("false")) {%>
        <jsp:include page="formLogin.jsp"  flush="true"></jsp:include>
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
        <%} else if (msg.equals("recup")) {%>
        <jsp:include page="formLogin.jsp" flush="true"></jsp:include>
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
        
        <%}else if (msg.equals("codNull")) {%>
        <jsp:include page="formLogin.jsp"  flush="true"></jsp:include>
        <script type="text/javascript">
            Swal.fire({
                title: 'ERROR EN CODIGO DE RECUPERACION',
                icon: 'error',
                text: 'El codigo ingresado no corresponde a ningun usuario de la empresa',
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
        <%}%>
    </body> 
</html>
