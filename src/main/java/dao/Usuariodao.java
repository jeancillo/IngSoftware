package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Usuario;

public class Usuariodao {

    public static final String SQL_VALIDAR = "select * from usuario where user=? and password=?";
    public static final String SQL_LISTAR="select * from usuario";

    public static Usuario validar(String user, String pass) {
        Usuario us = null;
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm = cn.prepareStatement(SQL_VALIDAR);
            stm.setString(1, user);
            stm.setString(2, pass);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                us = new Usuario();
                us.setIdUsuario(rs.getInt("idUsuario"));
                us.setUser(rs.getString("user"));
                us.setPassword(rs.getString("password"));
                us.setIdPersonal(rs.getInt("idPersonal"));
                us.setIdTipoUser(rs.getInt("idTipoUser"));
                us.setEstado(rs.getString("estado"));
            }
            cn.close();
            stm.close();
            rs.close();
        } catch (Exception e) {
            System.out.print("No se encontro usuario");
            e.printStackTrace();
        }
        return us;
    }
    public static ArrayList<Usuario> listarUsuarios() {
        ArrayList<Usuario> lista = new ArrayList<>();
        Connection cn = conexion.conexion.abrir();
        Usuario u = null;
        try {
            PreparedStatement stm = cn.prepareStatement(SQL_LISTAR);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setUser(rs.getString("user"));
                u.setPassword(rs.getString("password"));
                u.setIdPersonal(rs.getInt("idPersonal"));
                u.setIdTipoUser(rs.getInt("idTipoUser"));
                u.setEstado(rs.getString("estado"));
                lista.add(u);
            }
            cn.close();
            stm.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    public static Usuario listarUsuarioXId(int id){
        Connection cn = conexion.conexion.abrir();
        Usuario u=null;
        try{
            PreparedStatement stm =   cn.prepareStatement("select * from usuario where idUsuario=?");
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setUser(rs.getString("user"));
                u.setPassword(rs.getString("password"));
                u.setIdPersonal(rs.getInt("idPersonal"));
                u.setIdTipoUser(rs.getInt("idTipoUser"));
                u.setEstado(rs.getString("estado"));
            }
            cn.close();
            stm.close();
            rs.close();
        }catch(Exception e){
            e.printStackTrace();
        }
           
        return u;
    }
    public static void insertarUsuario(Usuario us) {
        String sql = "insert into usuario (user,password,idPersonal,idTipoUser,estado)values(?,?,?,?,'A')";
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm=cn.prepareStatement(sql);
            stm.setString(1,us.getUser());
            stm.setString(2, us.getPassword());
            stm.setInt(3, us.getIdPersonal());
            stm.setInt(4, us.getIdTipoUser());
            stm.executeUpdate();
            cn.close();
            stm.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void guardarUsuario(Usuario us) {
        String sql = "update usuario set user=?,password=?,idPersonal=?,idTipoUser=? where idUsuario=?";
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm=cn.prepareStatement(sql);
            stm.setString(1,us.getUser());
            stm.setString(2, us.getPassword());
            stm.setInt(3, us.getIdPersonal());
            stm.setInt(4, us.getIdTipoUser());
            stm.setInt(5, us.getIdUsuario());
            stm.executeUpdate();
            cn.close();
            stm.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
     public static void deleteUsuario(int id) {
        String sql = "delete from usuario where idUsuario=?";
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm=cn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
            cn.close();
            stm.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void desconectarUsuario(int id) {
        String sql = "update usuario set estado='I' where idUsuario=?";
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm=cn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
            cn.close();
            stm.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void conectarUsuario(int id) {
        String sql = "update usuario set estado='A' where idUsuario=?";
        Connection cn = conexion.conexion.abrir();
        try {
            PreparedStatement stm=cn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
            cn.close();
            stm.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
