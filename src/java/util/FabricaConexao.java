/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Rafael
 * 
 */
public class FabricaConexao {
    
    public static Connection getConexao() throws ClassNotFoundException, SQLException{
        //Carregar Driver  e criar conexao
        Class.forName("org.postgresql.Driver");
        Connection con =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/DB_REXPEITA", "postgres", "05101996");       
        return con;
    }
    
}
