/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.Torredao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Torre;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Torre_srv", urlPatterns = {"/Torre_srv"})
public class Torre_srv extends HttpServlet {
    int id;
    Torre t = new Torre();
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
         String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        System.out.println(accion);
        if (menu.equals("Torre")) {
            switch (accion) {
                case "Listar":
                    ArrayList<Torre> lista = Torredao.listarTorres();
                    request.setAttribute("torres", lista);
                    request.getRequestDispatcher("torre.jsp").forward(request, response);
                    break;
                case "Agregar":
                    String nomTorre = request.getParameter("nomTorre").toUpperCase();
                    String dirTorre = request.getParameter("dirTorre").toUpperCase();
                    String dueñoLocal = request.getParameter("dueLocal").toUpperCase();
                    String telefono = request.getParameter("telefono");
                    t.setNombreTorre(nomTorre);
                    t.setDueñoLocal(dueñoLocal);
                    t.setDireccion(dirTorre);
                    t.setTelefono(telefono);
                    Torre valInsert = Torredao.validarTorre(nomTorre);
                    if(valInsert == null){
                        Torredao.insertarTorre(t);
                        request.setAttribute("msg", "Insert");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }else{
                        request.setAttribute("msg", "InsertNull");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }
                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Torredao.deleteTorre(id);
                    Torre valDelete = Torredao.listarTorresId(id);
                    if(valDelete == null){
                        request.setAttribute("msg", "Delete");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }else{
                        request.setAttribute("msg", "DeleteNull");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }
                    break;
                case "Actualizar":
                    String nomTorre_n = request.getParameter("nomTorre").toUpperCase();
                    String dirTorre_n = request.getParameter("dirTorre").toUpperCase();
                    String dueñoLocal_n = request.getParameter("dueLocal").toUpperCase();
                    String telefono_n = request.getParameter("telefono");
                    t.setNombreTorre(nomTorre_n);
                    t.setDueñoLocal(dueñoLocal_n);
                    t.setDireccion(dirTorre_n);
                    t.setTelefono(telefono_n);
                    t.setIdTorre(id);
                    Torre valEdit = Torredao.validarTorre(nomTorre_n);
                    if (valEdit==null || (valEdit!=null &&  valEdit.getNombreTorre().equals(nomTorre_n))){
                        Torredao.guardarTorre(t);
                        request.setAttribute("msg", "Edit");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }else{
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
                    }
                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Torre tr = Torredao.listarTorresId(id);
                    request.setAttribute("torre", tr);
                    request.getRequestDispatcher("Torre_srv?menu=Torre&accion=Listar").forward(request, response);
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
