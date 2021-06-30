
package controlador;

import dao.Usuariodao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.MD5;
import modelo.Usuario;

@WebServlet(name = "Password_srv", urlPatterns = {"/Password_srv"})
public class Password_srv extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        switch(accion){
                case "Formulario":
                    request.getRequestDispatcher("password.jsp").forward(request, response);
                break;
                case "Recuperar":
                    String codRecu = request.getParameter("codRecuperacion");
                    Usuario us = Usuariodao.validarCod(codRecu);
                    if(us!=null){
                        request.setAttribute("msg","recup");
                        Usuariodao.reestablecerContraseña(MD5.getMD5("123456"), us.getIdUsuario());
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }else{
                        request.setAttribute("msg","codNull");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                        
                    }
                break;
                case "Regresar":
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
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
