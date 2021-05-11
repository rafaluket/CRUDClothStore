/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Produto;
import util.FabricaConexao;

/**
 *
 * @author Rafael
 * 
 */
public class ProdutoDAO {

    public void cadastrar(Produto Prod) throws ClassNotFoundException, SQLException {
        try ( Connection con = FabricaConexao.getConexao() ) {
            String sql = "insert into public.\"Produtos\" (nome, tecnologia, cor, valor) values (?,?,?,?)";
            PreparedStatement comando = con.prepareStatement(sql);
            comando.setString(1, Prod.getNomeProduto());
            comando.setString(2, Prod.getTecnologia());
            comando.setString(3, Prod.getCor());
            comando.setDouble(4, Prod.getValor());
            
            comando.execute();
            
            con.close();
        }

    }

    public void remover(Produto Prod) throws ClassNotFoundException, SQLException {
        try ( Connection con = FabricaConexao.getConexao()) {
            String sql = "delete from public.\"Produtos\" where id_produto = ?";
            PreparedStatement comando = con.prepareStatement(sql);
            comando.setInt(1, Prod.getId_produto());
            
            comando.execute();
            
            con.close();
        }

    }

    public List<Produto> consultarTodos() throws ClassNotFoundException, SQLException {
        List<Produto> listaProduto;
        try ( Connection con = FabricaConexao.getConexao() ) {
            String sql = "select * from public.\"Produtos\"";
            PreparedStatement comando = con.prepareStatement(sql);
            
            ResultSet resultado = comando.executeQuery();
            listaProduto = new ArrayList<>();
            while (resultado.next()) {
                Produto p = new Produto();
                p.setId_produto(resultado.getInt("id_produto"));
                p.setNomeProduto(resultado.getString("nome"));
                p.setTecnologia(resultado.getString("tecnologia"));
                p.setCor(resultado.getString("cor"));
                p.setValor(resultado.getDouble("valor"));
                listaProduto.add(p);
            }
            con.close();
        }
        return listaProduto;
    }

    public void atualizar(Produto Prod) throws ClassNotFoundException, SQLException {
        try ( Connection con = FabricaConexao.getConexao() ) {
            String sql = "UPDATE public.\"Produtos\" SET nome = ?, tecnologia=?, cor = ?, valor =? where id_produto = ?";
            
            PreparedStatement comando = con.prepareStatement(sql);
            
            comando.setString(1, Prod.getNomeProduto());
            comando.setString(2, Prod.getTecnologia());
            comando.setString(3, Prod.getCor());
            comando.setDouble(4, Prod.getValor());
            comando.setInt(5, Prod.getId_produto());
            
            comando.execute();
            con.close();
        }
    }
}
