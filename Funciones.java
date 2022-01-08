/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package federacion;

import java.sql.ResultSet;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author DARWIN
 */
public class Funciones {
    
    public Funciones(){}
    
    public void agregar_equipo(String nombre, String provincia){
        String sentencia = "INSERT INTO equipos (nombre, provincia)VALUES ('"+nombre+"','"+provincia+"')";
        try{
            if(!nombre.equals("")){
                Federacion.con.actualizaBD(sentencia);
                JOptionPane.showMessageDialog(null, "Se guardo correctamente");
                    
            }
        }catch(Exception ex){
            System.out.println("Excepcion" + ex.getMessage());
        }
    }
    
    public void agregar_jugador(String cedula, String nombres, String apellidos,  String nacionalidad, String Equipo){
        String id_equipo;
        ResultSet rs;
                
        try{
            rs = Federacion.con.consultaBD("SELECT id_equipo FROM equipos WHERE nombre = '"+Equipo+"'");
            rs.next();
            id_equipo = rs.getString(1);
            String sentencia = "INSERT INTO jugadores (cedula, nombre, apellido, nacionalidad, id_equipo)VALUES ('"+cedula+"','"+nombres+"','"+apellidos+"','"+nacionalidad+"','"+id_equipo+"')";
            if(!cedula.equals("") || !nombres.equals("") || !apellidos.equals("") || !nacionalidad.equals("") ){
                Federacion.con.actualizaBD(sentencia);
                JOptionPane.showMessageDialog(null, "Se guardo correctamente");
                    
            }
        }catch(Exception ex){
            System.out.println("Excepcion" + ex.getMessage());
        }
    }
    
    public void generar_partidos(){
        try{
            if(JOptionPane.showConfirmDialog(null, "Se eliminaran los partidos registrados ¿Esta de acuerdo?")==0){
                System.out.println("Entro");
                Federacion.con.actualizaBD("DELETE FROM partidos");
                Federacion.con.actualizaBD("CALL emparejar2()");
            }
        }catch (Exception ex){
            System.out.println("Excepcion" + ex.getMessage());
        }
    }
    
    public void actualizar_tabla(JTable tabla){
        DefaultTableModel modelo = (DefaultTableModel) tabla.getModel();
        modelo.setRowCount(0);
        ResultSet equipos;
        ResultSet rs;
        String equipo;
        int puntos=0;
        int jugados=0;
        int ganados=0;
        int empatados=0;
        int perdidos=0;
        int a_favor=0;
        int en_contra=0;
        try{
            equipos = Federacion.con.consultaBD("SELECT nombre FROM equipos");
            while(equipos.next()){
                puntos=0;
                jugados=0;
                ganados=0;
                empatados=0;
                perdidos=0;
                a_favor=0;
                en_contra=0;
                equipo = equipos.getString("nombre");
                rs = Federacion.con.consultaBD("SELECT COUNT(*) ganados FROM partidos "
                        + "WHERE (equipo1 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND"
                                + " equipo_1_goles > equipo_2_goles) OR"
                                + "  (equipo2 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND"
                                        + " equipo_2_goles > equipo_1_goles) AND jugado = TRUE");
                rs.next();
                ganados = rs.getInt("ganados");
                puntos += ganados * 3;
                rs = Federacion.con.consultaBD("SELECT COUNT(*) empatados FROM partidos "
                        + "WHERE ((equipo1 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND"
                                + " equipo_1_goles = equipo_2_goles) OR"
                                + "  (equipo2 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND"
                                        + " equipo_2_goles = equipo_1_goles)) AND jugado = TRUE");
                rs.next();
                empatados = rs.getInt("empatados");
                puntos += empatados;
                rs = Federacion.con.consultaBD("SELECT COUNT(*) jugados FROM partidos WHERE (equipo1 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') OR equipo2 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"')) AND jugado = TRUE;");
                rs.next();
                jugados = rs.getInt("jugados");
                perdidos = jugados - (ganados + empatados);
                rs = Federacion.con.consultaBD("SELECT SUM(equipo_1_goles) favor, SUM(equipo_2_goles) contra FROM partidos WHERE equipo1 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND jugado = TRUE;");
                rs.next();
                a_favor += rs.getInt("favor");
                en_contra += rs.getInt("contra");
                rs = Federacion.con.consultaBD("SELECT SUM(equipo_2_goles) favor, SUM(equipo_1_goles) contra FROM partidos WHERE equipo2 = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"') AND jugado = TRUE;");
                rs.next();
                a_favor += rs.getInt("favor");
                en_contra += rs.getInt("contra");
                modelo.addRow(new Object[]{equipo,puntos,jugados,ganados,empatados,perdidos,a_favor,en_contra});
                System.out.print(" "+equipo+" "+puntos+" "+jugados+""+ganados+" "+empatados+""+perdidos+" "+a_favor+""+en_contra+"");
            }
        }catch(Exception ex){
            System.out.println("Excepcion" + ex.getMessage());
        }
    }
    
    public void actualizar_partidos(JTable tabla){
        int id_1 = 0, id_2 = 0;
        String verdad;
        
        for(int i=0; i<tabla.getRowCount(); i++){
            if(tabla.getSelectedRow()>=0){
                try{
                    ResultSet rs = Federacion.con.consultaBD("SELECT id_equipo FROM equipos WHERE nombre = '"+tabla.getValueAt(i, 0)+"'");
                    rs.next();
                    id_1 = rs.getInt("id_equipo");
                    rs = Federacion.con.consultaBD("SELECT id_equipo FROM equipos WHERE nombre = '"+tabla.getValueAt(i, 1).toString()+"'");
                    rs.next();
                    id_2 = rs.getInt("id_equipo");
                    Federacion.con.actualizaBD("UPDATE partidos SET jugado = "+(boolean)tabla.getValueAt(i, 2)+", equipo_1_goles = '"+(int)tabla.getValueAt(i, 3)+"', equipo_2_goles = '"+(int)tabla.getValueAt(i, 4)+"' "
                            + "WHERE equipo1 = '"+id_1+"' AND equipo2 = '"+id_2+"'");
                }catch(Exception ex){
                    System.out.println("Error de conexion "+ex.toString());
                }
            }
        }
    }
    
    public void llenar_tabla(JTable tabla){
        String equipo1;
        String equipo2;
        boolean jugado;
        int gol1=0;
        int gol2=0;
        ResultSet rs1;
        ResultSet rs2;
        try{
            DefaultTableModel modelo = (DefaultTableModel) tabla.getModel();
            modelo.setRowCount(0);
            rs1 = Federacion.con.consultaBD("SELECT equipo1, equipo2, jugado, equipo_1_goles, equipo_2_goles FROM partidos");
            while(rs1.next()){
                rs2 = Federacion.con.consultaBD("SELECT nombre FROM equipos WHERE id_equipo = '"+rs1.getString("equipo1")+"'");
                rs2.next();
                equipo1 = rs2.getString("nombre");
                rs2 = Federacion.con.consultaBD("SELECT nombre FROM equipos WHERE id_equipo = '"+rs1.getString("equipo2")+"'");
                rs2.next();
                equipo2 = rs2.getString("nombre");
                jugado = rs1.getBoolean("jugado");
                gol1 = rs1.getInt("equipo_1_goles");
                gol2 = rs1.getInt("equipo_2_goles");
                modelo.addRow(new Object[]{equipo1,equipo2,jugado,gol1,gol2});
            }
            
        }
        catch(Exception ex){}
    }
    
    public void llenar_tabla_jugadores(JTable tabla, String equipo){        
        ResultSet rs;
        try{
            DefaultTableModel modelo = (DefaultTableModel) tabla.getModel();
            modelo.setRowCount(0);
            rs = Federacion.con.consultaBD("SELECT cedula, nombre, apellido, nacionalidad FROM jugadores WHERE id_equipo = (SELECT id_equipo FROM equipos WHERE nombre = '"+equipo+"')");
            while(rs.next()){
                modelo.addRow(new Object[]{rs.getString("cedula"),rs.getString("nombre"),rs.getString("apellido"),rs.getString("nacionalidad")});
            }
            
        }
        catch(Exception ex){}
    }
    
}
