/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package federacion;

/**
 *
 * @author DARWIN
 */
public class Federacion {
    public static accesobd con = new accesobd();

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Menu m = new Menu();
        m.setVisible(true);
    }
    
}
