<%@page import="modelo.TipoUsuario"%>
<%@page import="dao.TipoUsuariodao"%>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="sweetalert2/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href='images/ordenador-portatil.ico' rel='icon' >
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1200);
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#tab').DataTable({
                    responsive: true,
                    autoWidth: false,
                    language: {
                        "decimal": "",
                        "emptyTable": "No hay    información",
                        "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
                        "infoEmpty": "Mostrando 0 to 0 of 0 Entradas",
                        "infoFiltered": "(Filtrado de _MAX_ total entradas)",
                        "infoPostFix": "",
                        "thousands": ",",
                        "lengthMenu": "Mostrar _MENU_ Entradas",
                        "loadingRecords": "Cargando...",
                        "processing": "Procesando...",
                        "search": "Buscar:",
                        "zeroRecords": "Sin resultados encontrados",
                        "paginate": {
                            "first": "Primero",
                            "last": "Ultimo",
                            "next": "Siguiente",
                            "previous": "Anterior"
                        }
                    },
                });
            });
        </script>
    </head>
    <body>
        <style type="text/css">
            ul.dropdown-menu {
                background-color: gray;
            }
            label {
                display: inline-block;
                margin-bottom: .5rem;
                color:white;
            }
            .dataTables_wrapper .dataTables_filter input {
                border: 1px solid #aaa;
                border-radius: 3px;
                padding: 5px;
                background-color: transparent;
                margin-left: 3px;
                color:white;
            }
            .dataTables_wrapper .dataTables_length select {
                border: 1px solid #aaa;
                border-radius: 3px;
                padding: 5px;
                background-color: white;
                padding: 4px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button.disabled, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:hover, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:active {
                cursor: default;
                color: white !important;
                border: 1px solid transparent;
                background: transparent;
                box-shadow: none;
            }
            .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing, .dataTables_wrapper .dataTables_paginate {
                color: white;
            }
            tbody, td {
                margin: 0;
                padding: 0;
                border: 0;
                font-size: 100%;
                font: inherit;
                vertical-align: baseline;
                background-image: url("images/background.png");	
                color: white;

            }
            thead, tr {
                margin: 0;
                padding: 0;
                border: 0;
                font-size: 100%;
                font: inherit;
                vertical-align: baseline;
                background: black;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button.current, .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
                color: #333 !important;
                border: 1px solid #979797;
                background-color: #DFD428;
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, white), color-stop(100%, #dcdcdc));
                background: -webkit-linear-gradient(top, white 0%, #dcdcdc 100%);
                background: -moz-linear-gradient(top, white 0%, #dcdcdc 100%);
                background: -ms-linear-gradient(top, white 0%, #dcdcdc 100%);
                background: -o-linear-gradient(top, white 0%, #dcdcdc 100%);
                background: linear-gradient(to bottom, white 0%, #dcdcdc 100%);
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                box-sizing: border-box;
                display: inline-block;
                min-width: 1.5em;
                padding: 0.5em 1em;
                margin-left: 2px;
                text-align: center;
                text-decoration: none !important;
                cursor: pointer;
                *cursor: hand;
                color: white !important;
                border: 1px solid transparent;
                border-radius: 2px;
            }
        </style>
        <%
            HttpSession s = request.getSession();
            Usuario us = (Usuario) s.getAttribute("us");
            if (us == null) {
                s.invalidate();
                response.sendRedirect("index.jsp");
            }%><%else {
                    Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
                    Usuario uEdit = (Usuario) request.getAttribute("usuario");
                    ArrayList<Usuario> lista = (ArrayList) request.getAttribute("user");
                    ArrayList<TipoUsuario> lista_tipos = (ArrayList) request.getAttribute("tipos");
                    ArrayList<Personal> lista_personal = (ArrayList) request.getAttribute("personal");
        %>
        <c:if test="${not empty msg}">
            <c:if test="${msg=='usNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Usuario con ese nombre ya existe',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usNullD'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Usuario no se puede eliminar',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usDelete'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Usuario eliminado correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usInsert'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Usuario ingresado correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usDes'}">
                <script>
                    Swal.fire({
                        icon: 'info',
                        title: 'Usuario Desconectado',
                        text: 'El usuario se encuentra inactivo',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usConec'}">
                <script>
                    Swal.fire({
                        icon: 'info',
                        title: 'Usuario Conectado',
                        text: 'El usuario se encuentra activo',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='sesionTerminada'}">
                <script type="text/javascript">
                    Swal.fire({
                        title: 'Usuario inactivo',
                        text: 'Sesion Finalizada',
                        icon: 'warning',
                        showDenyButton: false,
                        showCancelButton: false,
                        confirmButtonText: `OK`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            window.location = 'CerrarSesion_srv?btn=true';
                        }
                    })
                </script>
            </c:if>
            <c:if test="${msg=='usUpdate'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Usuario Modificado',
                        text: 'Los datos del usuario han sido modificados correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='EditNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Los datos del usuario no se pueden modificar',
                    })
                </script>
            </c:if>
        </c:if>

        <div class = "header" >
            <div class="header_top">
                <div class="wrap">		
                    <div class="logo">
                        <a href="principal.jsp"><img src="images/villa flash.png" alt="" /></a>
                    </div>	
                    <div class="menu">
                        <ul>
                            <li><a href="principal.jsp">Inicio</a></li>
                            <li><a href="Personal_srv?menu=Personal&accion=Listar">Personal</a></li>
                            <li class="active"><a href="Usuarios_srv?menu=Usuarios&accion=Listar">Usuarios</a></li>
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Registro
                                </a>
                                <ul class="dropdown-menu">
                                    <a class="dropdown-item" href="Cliente_srv?menu=Cliente&accion=Listar">Cliente</a>
                                    <a class="dropdown-item" href="Servicio_srv?menu=Servicio&accion=Listar">Servicio</a>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Mantenimiento
                                </a>
                                <ul class="dropdown-menu">
                                    <a class="dropdown-item" href="Torre_srv?menu=Torre&accion=Listar">Torre</a>
                                    <a class="dropdown-item" href="Servidor_srv?menu=Servidor&accion=Listar">Servidor</a>
                                    <a class="dropdown-item" href="Antena_srv?menu=Antena&accion=Listar">Antena</a>
                                </ul>
                            </li>
                            <li><a href="CerrarSesion_srv?btn=true">Cerrar Sesion</a></li>
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>  
        <%if (uEdit == null) {%>
        <div class = "content_bottom" id = "account" >
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nuevo usuario</p>
                    <form action="Usuarios_srv?menu=Usuarios" name="formRegistro" method="POST"> 
                        <input name="us" type="text" placeholder="Username" class="field" required><br>
                        <input name="pas" type="password"  placeholder="Password" class="field" required> <br>
                        <select id="country" name="cmbo_tps" onchange="change_country(this.value)" class="frm-field required">
                            <c:forEach var="tip" items="${tipos}">
                                <option value=${tip.getIdTipoUser()}>${tip.getTipoUser()}</option>      
                            </c:forEach>
                        </select>
                        <select id="country" name="cmbo_prs" onchange="change_country(this.value)" class="frm-field required">
                            <c:forEach var="prs" items="${personal}">
                                <option value=${prs.getIdPersonal()}>${prs.getNombre()} ${prs.getApellidoPaterno()}</option>     
                            </c:forEach>
                        </select><br>
                        <div class="login"><input type="submit" name="accion"  value="Agregar"></div>
                    </form>
                </div>
            </div>              
            <div class="clear"></div>
        </div>
        <%} else {%>
        <div class="content_bottom" id="accountEdit">
            <div class="wrap">
                <div class="register_account">
                    <h3>Edicion de Datos</h3>
                    <p>Modificar datos de usuario</p>
                    <form action="Usuarios_srv?menu=Usuarios" method="POST"> 
                        <input name="us" type="text" placeholder="Username" class="field" value="${usuario.getUser()}" required>
                        <input name="pas" type="password" placeholder="Password" class="field" value="${usuario.getPassword()}" required> 
                        <% String result = null;%>
                        <select id="country" name="cmbo_tps" onchange="change_country(this.value)" class="frm-field required">
                            <%for (TipoUsuario tipos : lista_tipos) {%>
                            <option 
                                <%
                                    if (uEdit.getIdTipoUser() == tipos.getIdTipoUser()) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }
                                %>
                                <%=result%> value=<%=tipos.getIdTipoUser()%>><%=tipos.getTipoUser()%></option>      
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_prs" onchange="change_country(this.value)" class="frm-field required">

                            <%for (Personal personal : lista_personal) {%>
                            <option 
                                <%

                                    if (uEdit.getIdPersonal() == personal.getIdPersonal()) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }
                                %>
                                <%=result%> value=<%=personal.getIdPersonal()%>><%=personal.getNombre()%> <%=personal.getApellidoPaterno()%></option>     
                            <%}%>
                        </select>
                        <div class="login"><input type="submit" name="accion" value="Actualizar"></div>

                    </form>
                </div>
            </div>              
            <div class="clear"></div>
        </div>
        <%}%>
        <div class="main">
            <div class="wrap">
                <div class="plans">
                    <h3 class="h3">Usuarios Registrados</h3>
                    <div class="plans_table">
                        <table id="tab" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th class="plans-list"><h3>#</h3></th>
                                    <th class="plans-list"><h3>Nombre</h3></th>
                                    <th class="plans-list"><h3>Tipo</h3></th>
                                    <th class="plans-list"><h3>Estado</h3></th>
                                    <th class="plans-list"><h3>Acciones</h3></th>

                                </tr>
                            </thead>		
                            <tbody>
                                <%
                                    int i = 1;
                                    for (Usuario user : lista) {%>
                                <tr>
                                    <%
                                        TipoUsuario tp = TipoUsuariodao.listarTiposXId(user.getIdTipoUser());
                                        String estado = user.getEstado();
                                        String nomEst = null;
                                        if (estado.equals("A")) {
                                            nomEst = "ACTIVO";
                                        } else if (estado.equals("I")) {
                                            nomEst = "INACTIVO";
                                        }
                                    %>
                                    <td ><%=i%></td>
                                    <td ><%=user.getUser()%></td>
                                    <td ><%=tp.getTipoUser().toUpperCase()%></td>
                                    <td ><%=nomEst%></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Seleccione Accion
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                                                <% if (us.getIdUsuario() == user.getIdUsuario()) {%>
                                                <a class="dropdown-item"  href="Usuarios_srv?menu=Usuarios&accion=Editar&id=<%=user.getIdUsuario()%>" title="Editar">Editar</a>
                                                <%} else {%>
                                                <a class="dropdown-item" href="Usuarios_srv?menu=Usuarios&accion=Estado&id=<%=user.getIdUsuario()%>" title="Cambiar Estado">Cambiar Estado</a>
                                                <a class="dropdown-item" href="Usuarios_srv?menu=Usuarios&accion=Editar&id=<%=user.getIdUsuario()%>" title="Editar">Editar</a>
                                                <a class="dropdown-item" href="Usuarios_srv?menu=Usuarios&accion=Delete&id=<%=user.getIdUsuario()%>" title="Eliminar">Eliminar</a>
                                                <%}%>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <% i++;
                                    }%>
                            </tbody></table>
                    </div> 			 
                </div>
            </div>
        </div> 
        <div class="copy_right">
            <p> © 2021 VILLA FLASH NET . All rights reserved|  <%=p.getNombre()%> <%=p.getApellidoPaterno()%> <a href="CerrarSesion_srv?btn=true">Salir</a></p>
        </div>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <%}%>
    </body>
</html>

