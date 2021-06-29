/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.Antenadao;
import dao.Servidordao;
import dao.TipoAntenadao;
import dao.Torredao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Antena;
import modelo.Servidor;
import modelo.TipoAntena;
import modelo.Torre;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Antena_srv", urlPatterns = {"/Antena_srv"})
public class Antena_srv extends HttpServlet {

    Antena ant = new Antena();
    int id;

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
        if (menu.equals("Antena")) {
            switch (accion) {
                case "Listar":
                    ArrayList<Antena> lista_antena = Antenadao.listarAntenas();
                    ArrayList<Servidor> lista_servidor = Servidordao.listarServidores();
                    ArrayList<Torre> lista_torres = Torredao.listarTorres();
                    ArrayList<TipoAntena> lista_tipos = TipoAntenadao.listarTipos();
                    request.setAttribute("tipos", lista_tipos);
                    request.setAttribute("torres", lista_torres);
                    request.setAttribute("servidores", lista_servidor);
                    request.setAttribute("antenas", lista_antena);
                    request.getRequestDispatcher("antena.jsp").forward(request, response);
                    break;
                case "Agregar":
                    String nomAntena = request.getParameter("nomAntena");
                    String ip = request.getParameter("ip");
                    String mac = request.getParameter("mac");
                    String frecuencia = request.getParameter("frecuencia");
                    String canal = request.getParameter("canal");
                    String passConfig = request.getParameter("passConfig");
                    String passConec = request.getParameter("passConec");
                    int idServidor = Integer.parseInt(request.getParameter("cmbo_servidor"));
                    int idTorre = Integer.parseInt(request.getParameter("cmbo_torre"));
                    int idTipo = Integer.parseInt(request.getParameter("cmbo_tipos"));
                    ant.setNombreAntena(nomAntena);
                    ant.setIp(ip);
                    ant.setMac(mac);
                    ant.setFrecuencia(frecuencia);
                    ant.setCanal(canal);
                    ant.setPasswConfig(passConfig);
                    ant.setPasswConeccion(passConec);
                    ant.setIdServidor(idServidor);
                    ant.setIdTorre(idTorre);
                    ant.setIdTipo(idTipo);
                    Antena valInsert = Antenadao.validarAntena(nomAntena);
                    if (valInsert == null) {
                        request.setAttribute("msg", "Insert");
                        Antenadao.insertarAntena(ant);
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "InsertNull");
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    }

                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Antenadao.deleteAntena(id);
                    Antena valDelete = Antenadao.listarAntenasId(id);
                    if (valDelete == null) {
                        request.setAttribute("msg", "Delete");
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "DeleteNull");
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    }
                    break;
                case "Actualizar":
                    String nomAntena_n = request.getParameter("nomAntena");
                    String ip_n = request.getParameter("ip");
                    String mac_n = request.getParameter("mac");
                    String frecuencia_n = request.getParameter("frecuencia");
                    String canal_n = request.getParameter("canal");
                    String passConfig_n = request.getParameter("passConfig");
                    String passConec_n = request.getParameter("passConec");
                    int idServidor_n = Integer.parseInt(request.getParameter("cmbo_servidor"));
                    int idTorre_n = Integer.parseInt(request.getParameter("cmbo_torre"));
                    int idTipo_n = Integer.parseInt(request.getParameter("cmbo_tipos"));
                    ant.setNombreAntena(nomAntena_n);
                    ant.setIp(ip_n);
                    ant.setMac(mac_n);
                    ant.setFrecuencia(frecuencia_n);
                    ant.setCanal(canal_n);
                    ant.setPasswConfig(passConfig_n);
                    ant.setPasswConeccion(passConec_n);
                    ant.setIdAntena(id);
                    ant.setIdServidor(idServidor_n);
                    ant.setIdTorre(idTorre_n);
                    ant.setIdTipo(idTipo_n);
                    Antena valEdit = Antenadao.validarAntena(nomAntena_n);
                    if (valEdit==null || (valEdit!=null &&  valEdit.getNombreAntena().equals(nomAntena_n))) {
                        Antenadao.guardarAntena(ant);
                        request.setAttribute("msg", "Edit");
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    }else{
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    }
                    break;

                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Antena ant = Antenadao.listarAntenasId(id);
                    request.setAttribute("antena", ant);
                    request.getRequestDispatcher("Antena_srv?menu=Antena&accion=Listar").forward(request, response);
                    break;
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
