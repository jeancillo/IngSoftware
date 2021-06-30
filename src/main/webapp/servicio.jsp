<%-- 
    Document   : servicio.jsp
    Created on : 23 jun. 2021, 14:58:48
    Author     : PIERO
--%>

<%@page import="modelo.MarcaAntena"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="modelo.Personal"%>
<%@page import="dao.Personaldao"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.EstadoClientedao"%>
<%@page import="modelo.EstadoCliente"%>
<%@page import="modelo.Antena"%>
<%@page import="dao.Antenadao"%>
<%@page import="dao.Clientedao"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Servicio"%>
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
                    String banda = (String) s.getAttribute("banda");
                    String frec = (String) s.getAttribute("frec");
                    Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
                    Servicio servi = (Servicio) request.getAttribute("servi");
                    ArrayList<Servicio> lista = (ArrayList) request.getAttribute("servicios");
                    ArrayList<Antena> lista_antena = (ArrayList) request.getAttribute("antenas");
                    ArrayList<MarcaAntena> lista_marcas = (ArrayList) request.getAttribute("marcas");
                    ArrayList<String> lista_bandas = (ArrayList) request.getAttribute("bandas");
                    ArrayList<String> lista_frecuencia = (ArrayList) request.getAttribute("frecuencia");
                    ArrayList<String> lista_mac = (ArrayList) request.getAttribute("mac");
                    ArrayList<String> lista_ip = (ArrayList) request.getAttribute("ip");
        %>
        <c:if test="${not empty msg}">
            <c:if test="${msg=='Insert'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Servicio registrado correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='Delete'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Servicio eliminado correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='Edit'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Buen trabajo',
                        text: 'Servicio modicado correctamente',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='InsertNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Servicio con ese cliente ya esta registrado',
                    })
                </script>

            </c:if>
            <c:if test="${msg=='DeleteNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se puede eliminar servicio',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='EditNull'}">
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se puede editar los datos del servicio',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='buscarTrue'}">
                <script>
                    Swal.fire({
                        icon: 'info',
                        title: 'Cliente encontrado',
                        text: 'El cliente ya cuenta con un servicio',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='buscarNull'}">
                <script>
                    Swal.fire({
                        icon: 'info',
                        title: 'Cliente encontrado',
                        text: 'Cliente nuevo proceda a registrar el servicio',
                    })
                </script>
            </c:if>
            <c:if test="${msg=='InsertCliente'}">
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Cliente registrado correctamente',
                        text: 'Proceda a registrar servicio',
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
                                    <a class="dropdown-item active" href="Servicio_srv?menu=Servicio&accion=Listar">Servicio</a>
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
        <%if (servi == null) {%>
        <div class = "content_bottom" id = "account" >
            <div class="wrap">
                <div class="register_account">
                    <h3>Registro</h3>
                    <p>Registrar nuevo servicio</p>
                    <form action="Servicio_srv?menu=Servicio" name="formRegistro" method="POST"> 
                        <div class="d-flex">
                            <input name="codCliente" style="width:100px;" type="text" placeholder="Codigo" value="${cliente.getIdCliente()}${regCliente.getIdCliente()}"class="field" required>
                            <div class="login"><input type="submit" name="accion"  value="Buscar"></div>
                        </div>
                        <div class="d-flex">
                            <input name="nomCliente" style="width:400px;" type="text" placeholder="Cliente"  value="${cliente.getNombre()} ${cliente.getApellidoPaterno()}${regCliente.getNombre()} ${regCliente.getApellidoPaterno()}"class="field">
                        </div><br>
                        <span style="color: #666; font-size:0.8em;">Inicio: </span><input name="fechaInicio" type="date"  value="${f_inicio}${f_inicioClt}"class="field">
                        <span style="color: #666; font-size:0.8em;">Vencimiento: </span><input name="fechaFin" type="date"  value="${f_final}${f_finalClt}"class="field" >
                        <span style="color: #666; font-size:0.8em;"> Corte: </span> <input name="fechaCorte" type="date" value="${f_corte}${f_corteClt}" class="field" ><br>
                        <br><select id="country" name="cmbo_ip" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_ip.size(); i++) {%>
                            <option value="<%=lista_ip.get(i)%>"><%=lista_ip.get(i)%></option>  
                            <%}%>
                        </select> 
                        <select id="country" name="cmbo_mac" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_mac.size(); i++) {%>
                            <option value="<%=lista_mac.get(i)%>"><%=lista_mac.get(i)%></option>  
                            <%}%>
                        </select>
                        <% String result = null;%>
                        <select id="country" name="cmbo_frecuencia" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_frecuencia.size(); i++) {%>
                            <option 
                                <%
                                    if (lista_frecuencia.get(i).equals(frec)) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %> 
                                <%=result%> value="<%=lista_frecuencia.get(i)%>"><%=lista_frecuencia.get(i)%></option>  
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_anchoBanda" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_bandas.size(); i++) {%>
                            <option 
                                <%
                                    if (lista_bandas.get(i).equals(banda)) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %> 
                                <%=result%>  value="<%=lista_bandas.get(i)%>"><%=lista_bandas.get(i)%></option>  
                            <%}%>
                        </select>

                        <select id="country" name="cmbo_antena" onchange="change_country(this.value)" class="frm-field required">
                            <c:forEach var="an" items="${antenas}">
                                <option value=${an.getIdAntena()}>${an.getNombreAntena()}</option>
                            </c:forEach>
                        </select>
                        <select id="country" name="cmbo_marca" onchange="change_country(this.value)" class="frm-field required">
                            <%for (MarcaAntena lista_marca : lista_marcas) {%>
                            <option value=<%=lista_marca.getIdMarca()%>><%=lista_marca.getMarca()%></option>
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_condicion" onchange="change_country(this.value)" class="frm-field required">
                            <option value="Propia">Propia</option>  
                            <option value="Alquilada">Alquilada</option>     
                        </select>  

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
                    <p>Modificar datos de servicio</p>
                    <form action="Servicio_srv?menu=Servicio" method="POST"> 
                        <div class="d-flex">
                            <input style="width:100px;" name="codCliente" type="text" placeholder="Codigo" value="${servi.getIdCliente()}"class="field" required>
                            <div class="login"><input type="submit" name="accion"  value="Buscar"></div>
                        </div>
                        <div class="d-flex">
                            <input name="nomCliente" style="width:400px;" type="text" placeholder="Cliente" value="${cte.getNombre()} ${cte.getApellidoPaterno()}"class="field" disabled>
                        </div><br>
                        <span style="color: #666; font-size:0.8em;">Inicio: </span> <input name="fechaInicio" type="date"  value="${servi.getF_inicio()}"class="field" >
                        <span style="color: #666; font-size:0.8em;">Vencimiento: </span> <input name="fechaFin" type="date"  value="${servi.getF_vencimiento()}"class="field" >
                        <span style="color: #666; font-size:0.8em;">Corte: </span><input name="fechaCorte" type="date" value="${servi.getF_corte()}" class="field" ><br>
                        <% String result = null;
                        %>
                        <br><select id="country" name="cmbo_ip" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_ip.size(); i++) {%>
                            <option 
                                <%
                                    if (servi.getIp().equals(lista_ip.get(i))) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %>
                                <%=result%>value="<%=lista_ip.get(i)%>"><%=lista_ip.get(i)%></option>  
                            <%}%>
                        </select> 
                        <select id="country" name="cmbo_mac" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_mac.size(); i++) {%>
                            <option 
                                <%
                                    if (servi.getMac().equals(lista_mac.get(i))) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %>
                                <%=result%> value="<%=lista_mac.get(i)%>"><%=lista_mac.get(i)%></option>  
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_frecuencia" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_frecuencia.size(); i++) {%>
                            <option 
                                <%
                                    if (servi.getFrecuencia().equals(lista_frecuencia.get(i))) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %>
                                <%=result%> value="<%=lista_frecuencia.get(i)%>"><%=lista_frecuencia.get(i)%></option>  
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_anchoBanda" onchange="change_country(this.value)" class="frm-field required">
                            <%for (int i = 0; i < lista_bandas.size(); i++) {%>
                            <option 
                                <%
                                    if (servi.getAnchoBanda().equals(lista_bandas.get(i))) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }

                                %>
                                <%=result%> value="<%=lista_bandas.get(i)%>"><%=lista_bandas.get(i)%></option>  
                            <%}%>
                        </select>

                        <select id="country" name="cmbo_antena" onchange="change_country(this.value)" class="frm-field required">
                            <%for (Antena antena : lista_antena) { %>
                            <option   <%
                                if (servi.getIdAntena() == antena.getIdAntena()) {
                                    result = "selected";
                                } else {
                                    result = "";
                                }
                                %>
                                <%=result%>
                                value=<%=antena.getIdAntena()%>><%=antena.getNombreAntena()%></option>
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_marca" onchange="change_country(this.value)" class="frm-field required">
                            <%for (MarcaAntena lista_marca : lista_marcas) {%>
                            <option 
                                <%
                                    if (servi.getIdMarca() == lista_marca.getIdMarca()) {
                                        result = "selected";
                                    } else {
                                        result = "";
                                    }
                                %>
                                <%=result%> value=<%=lista_marca.getIdMarca()%>><%=lista_marca.getMarca()%></option>
                            <%}%>
                        </select>
                        <select id="country" name="cmbo_condicion" onchange="change_country(this.value)" class="frm-field required">
                            <option value="Propia">Propia</option>  
                            <option value="Alquilada">Alquilada</option>     
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
                    <h3>Servicios Registrados   </h3>
                    <div class="plans_table">
                        <table id="tab" width="100%" cellspacing="0" class="compare_plan">
                            <thead>
                                <tr>
                                    <th class="plans-list"><h3>#</h3></th>
                                    <th class="plans-list"><h3>Cliente</h3></th>
                                    <th class="plans-list"><h3>Antena</h3></th>
                                    <th class="plans-list"><h3>Tarifa</h3></th>
                                    <th class="plans-list"><h3>Frecuencia</h3></th>
                                    <th class="plans-list"><h3>Ancho Banda</h3></th>
                                    <th class="plans-list"><h3>Estado</h3></th>
                                    <th class="plans-list"><h3>Acciones</h3></th>
                                </tr>
                            </thead>		
                            <tbody>
                                <%
                                    int i = 0;
                                    for (Servicio ser : lista) {%>
                                <tr>
                                    <%

                                        Cliente cl = Clientedao.listarClienteId(ser.getIdCliente());
                                        Antena an = Antenadao.listarAntenasId(ser.getIdAntena());
                                        EstadoCliente est = EstadoClientedao.listarEstadoClienteId(ser.getIdEstado());

                                        i++;
                                    %>
                                    <td class="plan_list_title"><%=i%></td>
                                    <td class="plan_list_title"><%=cl.getNombre()%> <%=cl.getApellidoPaterno()%></td>
                                    <td class="plan_list_title"><%=an.getNombreAntena()%></td>
                                    <td class="plan_list_title"><%=ser.getTarifa()%></td>
                                    <td class="plan_list_title"><%=ser.getFrecuencia()%></td>
                                    <td class="plan_list_title"><%=ser.getAnchoBanda()%></td>
                                    <td class="plan_list_title"><%=est.getDescripcion()%></td>

                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Seleccione Accion
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                                                <a class="dropdown-item" href="Servicio_srv?menu=Servicio&accion=Editar&id=<%=ser.getIdServicio()%>" title="Editar">Editar</a>
                                                <a class="dropdown-item" href="Servicio_srv?menu=Servicio&accion=Delete&id=<%=ser.getIdServicio()%>" title="Eliminar">Eliminar</a>

                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }%>
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
