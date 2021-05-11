
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Personal;

public class Personaldao {
    
    public static final String SQL_VALIDAR = "select * from usuario where user=? and password=?";
    public static final String SQL_LISTAR="select * from personal";
    
    public static Personal listarPersonalXId(int id){
        Connection cn = conexion.conexion.abrir();
        Personal p=null;
        try{
            PreparedStatement stm =   cn.prepareStatement("select * from personal where idPersonal=?");
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                p = new Personal();
                p.setIdPersonal(rs.getInt("idPersonal"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setImg(rs.getString("img"));   
            }
            cn.close();
            stm.close();
            rs.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return p;
    }
    public static ArrayList<Personal> listarPersonal() {
        ArrayList<Personal> lista = new ArrayList<>();
        Connection cn = conexion.conexion.abrir();
        Personal p = null;
        try {
            PreparedStatement stm = cn.prepareStatement(SQL_LISTAR);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                 p = new Personal();
                p.setIdPersonal(rs.getInt("idPersonal"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setDni(rs.getString("dni"));
                p.setImg(rs.getString("img"));   
                lista.add(p);
            }
            cn.close();
            stm.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    
}
