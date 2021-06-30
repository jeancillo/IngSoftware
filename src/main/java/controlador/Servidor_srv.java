/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.Serviciodao;
import dao.Servidordao;
import dao.Torredao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Servidor;
import modelo.Torre;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Servidor_srv", urlPatterns = {"/Servidor_srv"})
public class Servidor_srv extends HttpServlet {

    int id;
    Servidor s = new Servidor();

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
        System.out.println(accion);
        if (menu.equals("Servidor")) {
            switch (accion) {
                case "Listar":
                    ArrayList<Servidor> lista = Servidordao.listarServidores();
                    request.setAttribute("servidores", lista);
                    request.getRequestDispatcher("servidor.jsp").forward(request, response);
                    break;
                case "Agregar":
                    String nomServidor = request.getParameter("nomServidor").toUpperCase();
                    String ipEntrada = request.getParameter("ipEntrada");
                    String ipSalida = request.getParameter("ipSalida");

                    s.setNombreServidor(nomServidor);
                    s.setIpEntrada(ipEntrada);
                    s.setIpSalida(ipSalida);
                    Servidor valInsert = Servidordao.validarServidor(nomServidor);
                    if (valInsert == null) {
                        request.setAttribute("msg", "Insert");
                        Servidordao.insertarServidor(s);
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "InsertNull");
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    }

                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Servidordao.deleteServidor(id);
                    Servidor valDelete = Servidordao.listarServidoresId(id);
                    if (valDelete == null) {
                        request.setAttribute("msg", "Delete");
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "DeleteNull");
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    }
                    request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    break;
                case "Actualizar":
                    String nomServidor_n = request.getParameter("nomServidor").toUpperCase();
                    String ipEntrada_n = request.getParameter("ipEntrada");
                    String ipSalida_n = request.getParameter("ipSalida");
                    s.setNombreServidor(nomServidor_n);
                    s.setIpEntrada(ipEntrada_n);
                    s.setIpSalida(ipSalida_n);
                    s.setIdServidor(id);
                    Servidor valEdit = Servidordao.validarServidor(nomServidor_n);
                    if (valEdit==null || (valEdit!=null &&  valEdit.getNombreServidor().equals(nomServidor_n))) {
                        Servidordao.guardarServidor(s);
                        request.setAttribute("msg", "Edit");
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
                    }

                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Servidor s = Servidordao.listarServidoresId(id);
                    request.setAttribute("servidor", s);
                    request.getRequestDispatcher("Servidor_srv?menu=Servidor&accion=Listar").forward(request, response);
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
