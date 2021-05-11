/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controler;

import dao.ProdutoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;

/**
 *
 * @author Rafael
 */
@WebServlet(name = "ManterProduto", urlPatterns = {"/ManterProduto"})
public class ManterProduto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mensagem = "";

        try {

            String operacao = request.getParameter("btnOperacao");

            if (operacao.equals("Cadastrar")) {
                try{
                    String nomeProduto = request.getParameter("txtNomeProduto");
                    String tecnologia = request.getParameter("txtTecnologia");
                    String cor = request.getParameter("txtCor");
                    double valor = Double.parseDouble(request.getParameter("txtValor"));

                    Produto prod = new Produto();
                    prod.setNomeProduto(nomeProduto);
                    prod.setTecnologia(tecnologia);
                    prod.setCor(cor);
                    prod.setValor(valor);

                    ProdutoDAO cdao = new ProdutoDAO();
                    cdao.cadastrar(prod);
                    
                    mensagem = "sucesso";
                    request.setAttribute("mensagem", mensagem);
                    
                    request.getRequestDispatcher("/ManterProduto.jsp").forward(request, response);
                }catch(IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e){
                    
                    mensagem = "Erro: " + e.getMessage();
                    request.setAttribute("mensagem", mensagem);
                    
                    request.getRequestDispatcher("/ManterProduto.jsp").forward(request, response);
                }
            }

            if (operacao.equals("Remover")) {
                //cenario : remover
                try{
                    int id = Integer.parseInt(request.getParameter("txtId"));

                    Produto prod = new Produto();
                    prod.setId_produto(id);

                    ProdutoDAO cdao = new ProdutoDAO();
                    cdao.remover(prod);
                    List<Produto> lprod = cdao.consultarTodos();
                    request.setAttribute("lprod", lprod);

                    mensagem = "sucessoRemover";
                    request.setAttribute("mensagem", mensagem);
                    request.getRequestDispatcher("/ListarProduto.jsp").forward(request, response);
                }catch(IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e){
                    mensagem = "Erro: " + e.getMessage();
                    request.setAttribute("mensagem", mensagem);
                    request.getRequestDispatcher("/ListarProduto.jsp").forward(request, response);
                }
            }

            if (operacao.equals("Consultar Todos")) {
                //cenario : consultar todos

                ProdutoDAO cdao = new ProdutoDAO();
                List<Produto> lprod = cdao.consultarTodos();
                request.setAttribute("lprod", lprod);

                request.getRequestDispatcher("/ListarProduto.jsp").forward(request, response);

            }
            if (operacao.equals("Atualizar")) {
                //cenario : Atualizar
                try{
                    Integer id_produto = Integer.parseInt(request.getParameter("txtId"));
                    String nomeProduto = request.getParameter("txtNomeProduto");
                    String tecnologia = request.getParameter("txtTecnologia");
                    String cor = request.getParameter("txtCor");
                    double valor = Double.parseDouble(request.getParameter("txtValor"));

                    
                    Produto prod = new Produto();

                    prod.setNomeProduto(nomeProduto);
                    prod.setTecnologia(tecnologia);
                    prod.setCor(cor);
                    prod.setValor(valor);
                    prod.setId_produto(id_produto);

                    ProdutoDAO cdao = new ProdutoDAO();
                    cdao.atualizar(prod);
                    List<Produto> lprod = cdao.consultarTodos();
                    request.setAttribute("lprod", lprod);

                    mensagem = "sucesso";
                    request.setAttribute("mensagem", mensagem);

                    request.getRequestDispatcher("/ListarProduto.jsp").forward(request, response);
                }catch(IOException | ClassNotFoundException | NumberFormatException | SQLException | ServletException e){
                    mensagem = "Erro:" + e.getMessage();
                    request.setAttribute("mensagem", mensagem);
                    
                    request.getRequestDispatcher("/ListarProduto.jsp").forward(request, response);
                }
            }
            if (operacao.equals("Tela Inicial")) {

                request.getRequestDispatcher("/ManterProduto.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException | IOException | NumberFormatException | ServletException ex) {
            mensagem = ex.getMessage();
            request.setAttribute("mensagem", mensagem);
            request.getRequestDispatcher("/ManterProduto.jsp").forward(request, response);
        }

//        request.setAttribute("mensagem", mensagem);
//        request.getRequestDispatcher("/ResultadoManterProduto.jsp").forward(request, response);

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
