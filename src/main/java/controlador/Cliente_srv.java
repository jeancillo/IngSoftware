/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.Clientedao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Cliente;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Cliente_srv", urlPatterns = {"/Cliente_srv"})
public class Cliente_srv extends HttpServlet {

    int id;
    Cliente cl = new Cliente();

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
        if (menu.equals("Cliente")) {
            switch (accion) {
                case "Listar":
                    String banda = request.getParameter("banda");
                    String frec = request.getParameter("frec");
                    HttpSession session = request.getSession();
                    session.setAttribute("banda", banda);
                    session.setAttribute("frec", frec);
                    ArrayList<Cliente> lista = Clientedao.listarClientes();
                    request.setAttribute("clientes", lista);
                    request.getRequestDispatcher("cliente.jsp").forward(request, response);
                    break;
                case "Agregar":
                    String nom = request.getParameter("nom").toUpperCase();
                    String apePaterno = request.getParameter("apePat").toUpperCase();
                    String apeMaterno = request.getParameter("apeMat").toUpperCase();
                    String dir = request.getParameter("dir");
                    String correo = request.getParameter("correo");
                    String dni = request.getParameter("dni");
                    cl.setNombre(nom);
                    cl.setApellidoPaterno(apePaterno);
                    cl.setApellidoMaterno(apeMaterno);
                    cl.setDireccion(dir);
                    cl.setCorreo(correo);
                    cl.setDNI(dni);
                    Cliente valInsert = Clientedao.validarCliente(dni);
                    if (valInsert == null) {
                        Clientedao.insertarCliente(cl);
                        request.setAttribute("msg", "InsertCliente");
                        Cliente regCliente = Clientedao.validarCliente(dni);
                        request.getRequestDispatcher("Servicio_srv?menu=Servicio&accion=Listar&dni="+dni).forward(request, response);
                    } else {
                        request.setAttribute("msg", "InsertNull");
                        request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
                    }
                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Clientedao.deleteCliente(id);
                    Cliente valDelete = Clientedao.listarClienteId(id);
                    if (valDelete == null) {
                        request.setAttribute("msg", "Delete");
                        request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "DeleteNull");
                        request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
                    }
                    break;
                case "Actualizar":
                    String nom_n = request.getParameter("nom").toUpperCase();
                    String apePaterno_n = request.getParameter("apePat").toUpperCase();
                    String apeMaterno_n = request.getParameter("apeMat").toUpperCase();
                    String dir_n = request.getParameter("dir");
                    String correo_n = request.getParameter("correo");
                    String dni_n = request.getParameter("dni");
                    cl.setNombre(nom_n);
                    cl.setApellidoPaterno(apePaterno_n);
                    cl.setApellidoMaterno(apeMaterno_n);
                    cl.setDireccion(dir_n);
                    cl.setCorreo(correo_n);
                    cl.setDNI(dni_n);
                    cl.setIdCliente(id);
                    Cliente valEdit = Clientedao.validarCliente(dni_n);
                    if (valEdit == null || (valEdit != null && valEdit.getIdCliente() == id)) {
                        Clientedao.guardarCliente(cl);
                        request.setAttribute("msg", "Edit");
                        request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
                    }
                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Cliente clr = Clientedao.listarClienteId(id);
                    request.setAttribute("cliente", clr);
                    request.getRequestDispatcher("Cliente_srv?menu=Cliente&accion=Listar").forward(request, response);
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
