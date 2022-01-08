/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package federacion;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Driver;
import java.io.*;
import java.net.*;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author DARWIN
 */
public class accesobd {
    Connection cn;
    
 public void conectaBD() throws Exception {
        try {
         Driver driver = (Driver)
                 Class.forName("com.mysql.jdbc.Driver").newInstance();
         DriverManager.registerDriver(driver);
         String url="jdbc:mysql://localhost/federacion";
         cn=DriverManager.getConnection( url,"root","");
         System.out.println("Conexion exitosa ");
        } catch (SQLException e) {
            System.out.println("Error grave de acceso a BD "+e.toString());
            System.out.println("Finalizando Servidor");
            System.exit(0);
        }
    }
      
    public ResultSet consultaBD(String sql )throws Exception {
        Statement stm=cn.createStatement();
        ResultSet cursor;
        cursor = stm.executeQuery(sql);
        return cursor;
        
        
    }
    public void actualizaBD(String Sql)throws Exception{
        try {
        Statement stm = cn.createStatement();
        stm.executeUpdate(Sql);
        System.out.println("Los datos han sido actualizado con exito");   
        } catch (SQLException e) {
            System.out.println("Error al actualizar la actualizacion"+e.toString());
            System.exit(0);
        }
    }
    public void cerrarBD() throws Exception {
    cn.close();
    
    }
    
}
