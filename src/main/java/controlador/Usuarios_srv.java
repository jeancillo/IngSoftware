package controlador;

import dao.Personaldao;
import dao.TipoUsuariodao;
import dao.Usuariodao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Personal;
import modelo.TipoUsuario;
import modelo.Usuario;

/**
 *
 * @author PIERO
 */
@WebServlet(name = "Usuarios_srv", urlPatterns = {"/Usuarios_srv"})
public class Usuarios_srv extends HttpServlet {
    
    int id;
    Usuario us = new Usuario();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        if (menu.equals("Usuarios")) {
            switch (accion) {
                case "Listar":
                    ArrayList<Usuario> lista = Usuariodao.listarUsuarios();
                    ArrayList<Personal> lista_personal = Personaldao.listarPersonal();
                    ArrayList<TipoUsuario> lista_tipos = TipoUsuariodao.listarTipos();
                    request.setAttribute("tipos", lista_tipos);
                    request.setAttribute("personal", lista_personal);
                    request.setAttribute("user", lista);
                    break;
                case "Agregar":
                    String user = request.getParameter("us").toUpperCase();
                    String pass = request.getParameter("pas");
                    int id_prs = Integer.parseInt(request.getParameter("cmbo_prs"));
                    int id_tps = Integer.parseInt(request.getParameter("cmbo_tps"));
                    us.setUser(user);
                    us.setPassword(pass);
                    us.setIdPersonal(id_prs);
                    us.setIdTipoUser(id_tps);
                    Usuario val = Usuariodao.validar(user, pass);
                    if (val != null) {
                        request.setAttribute("msg", "Usuario con ese nombre ya existe");
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "Usuario insertado correctamente");
                        Usuariodao.insertarUsuario(us);
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    }
                    break;
                case "Delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    Usuariodao.deleteUsuario(id);
                    Usuario valUs = Usuariodao.listarUsuarioXId(id);
                    if (valUs != null) {
                        request.setAttribute("msg", "El usuario no se pudo eliminar");
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    } else {
                        request.setAttribute("msg", "El usuario se elimino correctamente");
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    }
                    break;
                case "Actualizar":
                    String user_n = request.getParameter("us").toUpperCase();
                    String pass_n = request.getParameter("pas");
                    int id_prs_n = Integer.parseInt(request.getParameter("cmbo_prs"));
                    int id_tps_n = Integer.parseInt(request.getParameter("cmbo_tps"));
                    us.setUser(user_n);
                    us.setPassword(pass_n);
                    us.setIdTipoUser(id_tps_n);
                    us.setIdPersonal(id_prs_n);
                    us.setIdUsuario(id);
                    System.out.println(id);
                    Usuariodao.guardarUsuario(us);
                    request.setAttribute("msg", "Usuario modificado correctamentee");
                    request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    break;
                case "Estado":
                    id = Integer.parseInt(request.getParameter("id"));
                    Usuario valEs = Usuariodao.listarUsuarioXId(id);
                    String estado = valEs.getEstado();
                    if (estado.equals("A")) {
                        Usuariodao.desconectarUsuario(id);
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    } else if (estado.equals("I")) {
                        Usuariodao.conectarUsuario(id);
                        request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    }
                    break;
                case "Editar":
                    id = Integer.parseInt(request.getParameter("id"));
                    Usuario valEd = Usuariodao.listarUsuarioXId(id);
                    request.setAttribute("usuario", valEd);
                    request.getRequestDispatcher("Usuarios_srv?menu=Usuarios&accion=Listar").forward(request, response);
                    break;

            }
            request.getRequestDispatcher("usuarios.jsp").forward(request, response);
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
