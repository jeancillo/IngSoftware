<%-- 
    Document   : torre.jsp
    Created on : 22 jun. 2021, 21:20:12
    Author     : PIERO
--%>

<%@page import="modelo.Torre"%>
<%@page import="dao.Torredao"%>
<%@page import="modelo.Personal"%>
<%@page import="dao.Personaldao"%>
<%@page import="modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <link href='images/ordenador-portatil.ico' rel='icon' >
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                    Torre t = (Torre) request.getAttribute("torre");%>

        <c:if test="${not empty msg}">
            <c:if test="${msg=='Insert'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Torre agregada correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='Delete'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Torre eliminada correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='Edit'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Torre modicada correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='InsertNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Torre con ese nombre ya existe',
                    })
                </script>

            </c:if>
            <c:if test="${msg=='DeleteNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se puede eliminar torre',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='EditNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se puede editar los datos de la torre',
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
                            <li><a href="Usuarios_srv?menu=Usuarios&accion=Listar">Usuarios</a></li>
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
                                    <a class="dropdown-item active" href="Torre_srv?menu=Torre&accion=Listar">Torre</a>
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
        <%if (t == null) {%>
        <div class = "content_bottom" id = "account" >
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nueva Torre</p>
                    <form action="Torre_srv?menu=Torre" name="formRegistro" method="POST"> 
                        <input name="nomTorre" type="text" placeholder="Nombre Torre" class="field" required>
                        <input name="dirTorre" type="text" placeholder="Direccion" class="field" required> 
                        <input name="dueLocal" type="text" placeholder="Dueño Local" class="field" required>
                        <input name="telefono" type="text" placeholder="Telefono" class="field" required> 
                        <div class="login"><input type="submit" name="accion"  value="Agregar"></div>
                    </form>
                </div>
            </div>              
            <div class="clear"></div>
        </div>
        <%} else {%>
        <div class="content_bottom" id="account">
            <div class="wrap">
                <div class="register_account">
                    <h3>Edicion de Datos</h3>
                    <p>Modificar datos de Torre</p>
                    <form action="Torre_srv?menu=Torre" method="POST"> 
                        <input name="nomTorre" type="text" placeholder="Nombre Torre" value="${torre.getNombreTorre()}" class="field" required>
                        <input name="dirTorre" type="text" placeholder="Direccion" value="${torre.getDireccion()}" class="field" required> 
                        <input name="dueLocal" type="text" placeholder="Dueño Local" value="${torre.getDueñoLocal()}"class="field" required>
                        <input name="telefono" type="text" placeholder="Telefono" value="${torre.getTelefono()}" class="field" required> 
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
                    <h3>Torres Registrados</h3>
                    <div class="plans_table">
                        <table id="tab" width="100%" cellspacing="0" class="compare_plan">
                            <thead>
                                <tr>
                                    <th class="plans-list"><h3>#</h3></th>
                                    <th class="plans-list"><h3>Nombre Torre</h3></th>
                                    <th class="plans-list"><h3>Direccion </h3></th>
                                    <th class="plans-list"><h3>Dueño Local</h3></th>
                                    <th class="plans-list"><h3>Telefono</h3></th>
                                    <th class="plans-list"><h3>Acciones</h3></th>

                                </tr>
                            </thead>		
                            <tbody>
                                <%
                                    int i = 0;%>

                                <c:forEach var="tr" items="${torres}">
                                    <%i++;%>
                                    <tr>
                                        <td class="plan_list_title"><%=i%></td>
                                        <td class="plan_list_title">${tr.getNombreTorre()}</td>
                                        <td class="price_body">${tr.getDireccion()}</td>
                                        <td class="price_body">${tr.getDueñoLocal()}</td>
                                        <td class="price_body">${tr.getTelefono()}</td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    Seleccione Accion
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                                                    <a class="dropdown-item" href="Torre_srv?menu=Torre&accion=Editar&id=${tr.getIdTorre()}" title="Editar">Editar</a>
                                                    <a class="dropdown-item" href="Torre_srv?menu=Torre&accion=Delete&id=${tr.getIdTorre()}" title="Eliminar">Eliminar</a>

                                                </div>
                                            </div>
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
