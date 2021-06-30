/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.Antenadao;
import dao.Clientedao;
import dao.MarcaAntenadao;
import dao.Personaldao;
import dao.Serviciodao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Antena;
import modelo.Cliente;
import modelo.Fecha;
import modelo.MarcaAntena;
import modelo.Personal;
import modelo.Servicio;
import modelo.Usuario;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Servicio_srv", urlPatterns = {"/Servicio_srv"})
public class Servicio_srv extends HttpServlet {

    int id;
    Servicio ser = new Servicio();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        if (menu.equals("Servicio")) {
            switch (accion) {
                case "Listar":
                    ArrayList<String> lista_banda = new ArrayList<>();
                    lista_banda.add("512 Kbps");
                    lista_banda.add("1 Mbps");
                    lista_banda.add("2 Mbps");
                    ArrayList<String> lista_frecuencia = new ArrayList<>();
                    lista_frecuencia.add("2.4 GHz");
                    lista_frecuencia.add("5.8 GHz");
                    ArrayList<String> lista_mac = new ArrayList<>();
                    lista_mac.add("C0:3F:D5:4B:E3:E");
                    lista_mac.add("00:23:CD:20:0E:4");
                    lista_mac.add("F8:D1:11:7D:A0:C");
                    lista_mac.add("64:66:B3:7A:F8:D");
                    ArrayList<String> lista_ip = new ArrayList<>();
                    for (int i = 10; i <= 30; i++) {
                        lista_ip.add("192.168." + i);
                    }
                    String dni = request.getParameter("dni");
                    Cliente regCliente = Clientedao.validarCliente(dni);
                    if (regCliente != null) {
                        String f_inicioClt = Fecha.fecha_actual();
                        String f_finalClt= Fecha.fecha_vencimiento();
                        String f_corteClt = Fecha.fecha_corte();
                         request.setAttribute("regCliente", regCliente);
                        request.setAttribute("f_inicioClt", f_inicioClt);
                        request.setAttribute("f_finalClt", f_finalClt);
                        request.setAttribute("f_corteClt", f_corteClt);
                    }
                    ArrayList<Servicio> lista_servicio = Serviciodao.listarServicios();
                    ArrayList<MarcaAntena> lista_marca = MarcaAntenadao.listarMarcaAntena();
                    ArrayList<Antena> lista_antena = Antenadao.listarAntenas();
                    request.setAttribute("bandas", lista_banda);
                    request.setAttribute("frecuencia", lista_frecuencia);
                    request.setAttribute("mac", lista_mac);
                    request.setAttribute("ip", lista_ip);
                    request.setAttribute("marcas", lista_marca);
                    request.setAttribute("servicios", lista_servicio);
                    request.setAttribute("antenas", lista_antena);
                    request.getRequestDispatcher("servicio.jsp").forward(request, response);
                    break;
                case "Agregar":
                    int codCliente = Integer.parseInt(request.getParameter("codCliente"));
                    HttpSession s = request.getSession();
                    Usuario us = (Usuario) s.getAttribute("us");
                    Personal p = Personaldao.listarPersonalXId(us.getIdPersonal());
                    String f_inicio_add = Fecha.fecha_actual();
                    String f_fin_add = Fecha.fecha_vencimiento();
                    String f_corte_add = Fecha.fecha_corte();
                    String ip = request.getParameter("cmbo_ip");
                    String mac = request.getParameter("cmbo_mac");
                    String frec = request.getParameter("cmbo_frecuencia");
                    String anchoBanda = request.getParameter("cmbo_anchoBanda");
                    int idAntena = Integer.parseInt(request.getParameter("cmbo_antena"));
                    int marca = Integer.parseInt(request.getParameter("cmbo_marca"));
                    String condicion = request.getParameter("cmbo_condicion");
                    int tarifa = 0;
                    if (anchoBanda.equals("512 Kbps") && frec.equals("2.4 GHz")) {
                        tarifa = 50;
                    } else if (anchoBanda.equals("1 Mbps") && frec.equals("2.4 GHz")) {
                        tarifa = 75;
                    } else if (anchoBanda.equals("1 Mbps") && frec.equals("5.8 GHz")) {
                        tarifa = 100;
                    } else if (anchoBanda.equals("2 Mbps") && frec.equals("5.8 GHz")) {
                        tarifa = 125;
                    }
                    ser.setF_vencimiento(f_fin_add);
                    ser.setF_inicio(f_inicio_add);
                    ser.setF_corte(f_corte_add);
                    ser.setCondicionAntena(condicion);
                    ser.setMac(mac);
                    ser.setIp(ip);
                    ser.setFrecuencia(frec);
                    ser.setAnchoBanda(anchoBanda);
                    ser.setIdMarca(marca);
                    ser.setTarifa(tarifa);
                    ser.setIdAntena(idAntena);
                    ser.setIdCliente(codCliente);
                    ser.setIdPersonal(p.getIdPersonal());
                    Servicio valInsert = Serviciodao.listarServiciosCodCliente(codCliente);
                    if (valInsert == null) {
                        request.setAttribute("msg", "Insert");
                        Serviciodao.insertar_srv(ser);
                        s.removeAttribute("banda");
                        s.removeAttribute("frec");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "InsertNull");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    }

                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Serviciodao.delete_srv(id);
                    Servicio valDelete = Serviciodao.listarServiciosId(id);
                    if (valDelete == null) {
                        request.setAttribute("msg", "Delete");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "DeleteNull");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    }
                    break;
                case "Actualizar":
                    int codCliente_n = Integer.parseInt(request.getParameter("codCliente"));
                    HttpSession s_n = request.getSession();
                    Usuario us_n = (Usuario) s_n.getAttribute("us");
                    Personal p_n = Personaldao.listarPersonalXId(us_n.getIdPersonal());
                    String f_inicio_add_n = Fecha.fecha_actual();
                    String f_fin_add_n = Fecha.fecha_vencimiento();
                    String f_corte_add_n = Fecha.fecha_vencimiento();
                    String ip_n = request.getParameter("cmbo_ip");
                    String mac_n = request.getParameter("cmbo_mac");
                    String frec_n = request.getParameter("cmbo_frecuencia");
                    String anchoBanda_n = request.getParameter("cmbo_anchoBanda");
                    int idAntena_n = Integer.parseInt(request.getParameter("cmbo_antena"));
                    int marca_n = Integer.parseInt(request.getParameter("cmbo_marca"));
                    String condicion_n = request.getParameter("cmbo_condicion");
                    int tarifa_n = 0;
                    if (anchoBanda_n.equals("512 Kbps") && frec_n.equals("2.4 GHz")) {
                        tarifa_n = 50;
                    } else if (anchoBanda_n.equals("1 Mbps") && frec_n.equals("2.4 GHz")) {
                        tarifa_n = 75;
                    } else if (anchoBanda_n.equals("1 Mbps") && frec_n.equals("5.8 GHz")) {
                        tarifa_n = 100;
                    } else if (anchoBanda_n.equals("2 Mbps") && frec_n.equals("5.8 GHz")) {
                        tarifa_n = 125;
                    }
                    ser.setF_vencimiento(f_fin_add_n);
                    ser.setF_inicio(f_inicio_add_n);
                    ser.setF_corte(f_corte_add_n);
                    ser.setCondicionAntena(condicion_n);
                    ser.setMac(mac_n);
                    ser.setIp(ip_n);
                    ser.setFrecuencia(frec_n);
                    ser.setAnchoBanda(anchoBanda_n);
                    ser.setIdMarca(marca_n);
                    ser.setTarifa(tarifa_n);
                    ser.setIdAntena(idAntena_n);
                    ser.setIdCliente(codCliente_n);
                    ser.setIdPersonal(p_n.getIdPersonal());
                    ser.setIdServicio(id);
                    Servicio valEdit = Serviciodao.listarServiciosId(id);
                    if (valEdit == null || (valEdit != null && valEdit.getIdCliente() == codCliente_n)) {
                        Serviciodao.guardar_srv(ser);
                        request.setAttribute("msg", "Edit");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    }
                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Servicio ser = Serviciodao.listarServiciosId(id);
                    Cliente client = Clientedao.listarClienteId(ser.getIdCliente());
                    request.setAttribute("servi", ser);
                    request.setAttribute("cte", client);
                    request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    break;
                case "Buscar":
                    int cod_cliente = Integer.parseInt(request.getParameter("codCliente"));
                    Cliente cl = Clientedao.buscar(cod_cliente);
                    Servicio valCliente = Serviciodao.listarServiciosCodCliente(cod_cliente);
                    if (valCliente == null) {
                        String f_inicio = Fecha.fecha_actual();
                        String f_final = Fecha.fecha_vencimiento();
                        String f_corte = Fecha.fecha_corte();
                        request.setAttribute("f_inicio", f_inicio);
                        request.setAttribute("f_final", f_final);
                        request.setAttribute("f_corte", f_corte);
                        request.setAttribute("cliente", cl);
                        request.setAttribute("msg", "buscarNull");
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    } else {
                        Cliente cliente = Clientedao.listarClienteId(cod_cliente);
                        request.setAttribute("msg", "buscarTrue");
                        request.setAttribute("servi", valCliente);
                        request.setAttribute("cte", cliente);
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar").forward(request, response);
                    }

                    break;
                default:
                    throw new AssertionError();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
