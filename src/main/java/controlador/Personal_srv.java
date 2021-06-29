package controlador;

import dao.Personaldao;
import dao.Usuariodao;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Personal;
import modelo.Usuario;

/**
 *
 * @author PIERO
 */
@MultipartConfig
@WebServlet(name = "Personal_srv", urlPatterns = {"/Personal_srv"})
public class Personal_srv extends HttpServlet {

    int id;
    Personal p = new Personal();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        if (menu.equals("Personal")) {
            switch (accion) {
                case "Listar":
                    ArrayList<Personal> lista = Personaldao.listarPersonal();
                    request.setAttribute("personal", lista);
                    request.getRequestDispatcher("personal.jsp").forward(request, response);
                    break;
                case "Agregar":
                    String nom = request.getParameter("nom").toUpperCase();
                    String apePat = request.getParameter("apePat").toUpperCase();
                    String apeMat = request.getParameter("apeMat").toUpperCase();
                    String dni = request.getParameter("dni");
                    Part part = request.getPart("img");
                    InputStream inputStream = part.getInputStream();
                    p.setNombre(nom);
                    p.setApellidoPaterno(apePat);
                    p.setApellidoMaterno(apeMat);
                    p.setDni(dni);
                    p.setImg(inputStream);
                    Personal val = Personaldao.validar(dni);
                    if (val != null) {
                        request.setAttribute("msg", "perNull");
                        request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "perInsert");
                        Personaldao.insertarPersonal(p);
                        request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
                    }
                    break;
                case "Delete":
                    break;
                case "Actualizar":
                    String nom_n = request.getParameter("nom").toUpperCase();
                    String apePat_n = request.getParameter("apePat").toUpperCase();
                    String apeMat_n = request.getParameter("apeMat").toUpperCase();
                    String dni_n = request.getParameter("dni");
                    p.setNombre(nom_n);
                    p.setApellidoPaterno(apePat_n);
                    p.setApellidoMaterno(apeMat_n);
                    p.setDni(dni_n);
                    p.setIdPersonal(id);
                    Personal valEdit = Personaldao.validar(dni_n);
                    if (valEdit == null || (valEdit != null && valEdit.getIdPersonal() == id)) {
                        Personaldao.guardarPersonal(p);
                        request.setAttribute("msg", "perUpdate");
                        request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "EditNull");
                        request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
                    }

                    request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Personal valEd = Personaldao.listarPersonalXId(id);
                    request.setAttribute("pers", valEd);
                    request.getRequestDispatcher("Personal_srv?menu=Personal&accion=Listar").forward(request, response);
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
