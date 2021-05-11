<%-- 
    Document   : index
    Created on : 4 may. 2021, 19:19:48
    Author     : PIERO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form  action="Login_srv" method="POST">
            Usuario: <input type="text" name="user" required><br>
            Contraseña : <input type="password" name="pass" required><br>
            <input type="submit" value="Ingresar" name="accion">        
        </form>  
    </body>
</html>
