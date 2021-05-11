<%@page import="model.Produto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Produto</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
        <form action="ManterProduto" method="post">
            <h1>Produtos</h1>
            <div class="search">
                 <div class="form__group field">
                    <input type="input" onkeyup="filtrar()" class="form__field" placeholder="Pesquisar" name="txtPesquisar" id='pesquisar' />
                    <label for="pesquisar" class="form__label">Pesquisar</label>
                    <span id="searchIcon" class="material-icons searchIcon">search</span>
                    <span onclick="clearIconFiltrar()" id="cancelSearchIcon" class="material-icons cancelSearchIcon">clear</span>
                </div>
                
            </div>
            <div class="tbl-header">
            <table cellpadding="0" cellspacing="0" border="0">
                <thead>
                <%List<Produto> lprod = (List<Produto>) request.getAttribute("lprod");
                    %><tr><%
                        %><th onclick="sortTableNumber(0)"><%out.print("ID");%></th><%
                        %><th onclick="sortTable(1)"><%out.print("NOME DO PRODUTO");%></th><%
                        %><th onclick="sortTable(2)"><%out.print("TECNOLOGIA");%></th><%
                        %><th onclick="sortTable(3)"><%out.print("COR");%></th><%
                        %><th onclick="sortTableNumber(4)"><%out.print("VALOR");%></th><th></th><%
                    %></tr>
                </thead>
                </table>
            </div>
            <div class="tbl-content">
                <table id="tabelaProdutos" cellpadding="0" cellspacing="0" border="0">
                    <tbody>
                        <tr></tr>
                    <%
                        double elementCount = 0;
                        int idCount = 0;
                        int idProd;
                        for (Produto prod : lprod) {
                        elementCount += 6;
                    %>
                    
                        <tr><%
                            %><td id="idProdCol<% out.print(idCount); %>"><% out.print(prod.getId_produto()); %></td><%
                            %><td id="nomeProdCol<% out.print(idCount); %>"><% out.print(prod.getNomeProduto()); %></td><%
                            %><td id="tecProdCol<% out.print(idCount); %>"><% out.print(prod.getTecnologia()); %></td><%
                            %><td id="corProdCol<% out.print(idCount); %>"><% out.print(prod.getCor()); %></td><%
                            %><td id="valProdCol<% out.print(idCount); %>">R$<% out.print(prod.getValor()); %></td><%
                            %><td><a id="confirmarEdicao<% out.print(idCount); %>" class="check" onclick="confirmarEdicao(<% out.print(elementCount + "," + idCount); %>)" ><span class="material-icons">check</span></a>
                                <a id="cancelarEdicao<% out.print(idCount); %>" class="cancel" onclick="cancelarEdicao(<% out.print(elementCount + "," + idCount); %>)" ><span class="material-icons">clear</span></a>
                                <a id="editar<% out.print(idCount); %>" onclick="editar(<% out.print(elementCount + "," + idCount); %>)"><span class="material-icons edit">edit</span></a>
                                <a onclick="confirmarDelete(<% out.print(elementCount + "," + idCount); %>)" id="deletar<% out.print(idCount); %>"><span class="material-icons delete">delete</span></a></td><%
                        %></tr>
                    <%
                        idCount++;
                        }
                    %>
                        </tbody>
            </table>
            <br><br>
            </div>
            <input class="btn-2 consultar" type="submit" name="btnOperacao" value="Tela Inicial">
        </form>
            
            <script>
                window.addEventListener('load', function() {
                var msg = "${mensagem}";
                if(msg !== ''){
                        if(msg === "sucesso")
                            swal("SUCESSO!", "Produto atualizado!", "success");
                        else if(msg === "sucessoRemover")
                            swal("SUCESSO!", "Produto removido!", "success");
                        else
                            swal("ERRO!", "Houve um erro na atualização/remoção do produto. " + msg, "error");
                    }
                });
                
                $(window).on("load resize ", function() {
                  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
                  $('.tbl-header').css({'padding-right':scrollWidth});
                }).resize();

                function clearIconFiltrar(){
                    document.getElementById("pesquisar").value = '';
                    document.getElementById("cancelSearchIcon").removeAttribute("style", "display: inline;");
                    document.getElementById("searchIcon").removeAttribute("style", "display: none;");
                    filtrar();
                }
                
                function filtrar() {
                if(document.getElementById("pesquisar").value === ''){
                    document.getElementById("cancelSearchIcon").removeAttribute("style", "display: inline;");
                    document.getElementById("searchIcon").removeAttribute("style", "display: none;");
                }else{
                    document.getElementById("cancelSearchIcon").setAttribute("style", "display: inline;");
                    document.getElementById("searchIcon").setAttribute("style", "display: none;");
                }
                
                var input, filter, table, tr, firstCol,secondCol,thirdCol, fourthCol, i,j, txtValue;
                input = document.getElementById("pesquisar");
                filter = input.value.toUpperCase();
                table = document.getElementById("tabelaProdutos");
                tr = table.getElementsByTagName("tr");

                
                for (i = 0; i < tr.length; i++) {
                  firstCol = tr[i].getElementsByTagName("td")[0];
                  secondCol = tr[i].getElementsByTagName("td")[1];
                  thirdCol = tr[i].getElementsByTagName("td")[2];
                  fourthCol = tr[i].getElementsByTagName("td")[3];
                  if (firstCol || secondCol || thirdCol || fourthCol) {
                    var txtValueCol1 = firstCol.textContent.toUpperCase() || firstCol.innerText.toUpperCase;
                    var txtValueCol2 = secondCol.textContent.toUpperCase() || secondCol.innerText.toUpperCase;
                    var txtValueCol3 = thirdCol.textContent.toUpperCase() || thirdCol.innerText.toUpperCase;
                    var txtValueCol4 = fourthCol.textContent.toUpperCase() || fourthCol.innerText.toUpperCase;
                    
                    if (txtValueCol1.indexOf(filter) > -1 || txtValueCol2.indexOf(filter) > -1 || txtValueCol3.indexOf(filter) > -1 || txtValueCol4.indexOf(filter) > -1) {
                      tr[i].style.display = "";
                    } else {
                      tr[i].style.display = "none";
                    }
                  }
                }
              }
                
                function confirmarDelete(elementCount, idCount){
                    var contagemVetor = 0;
                    var i = elementCount-2;
                    var dadosAlterados = [];
                    var vaiAte = elementCount - 5;
                    elementCount -= 2;
                    while (elementCount >= vaiAte) {
                        document.getElementsByTagName("td")[elementCount].setAttribute("contenteditable",false);
                        
                        while( i >= vaiAte-1) {
                            dadosAlterados[contagemVetor] = document.getElementsByTagName("td")[i].textContent;
                            contagemVetor++;
                            i--;
                        }
                        elementCount--;
                    }
                    var id = dadosAlterados[4].replace(' ','%20');
                    var  url = "http://localhost:8084/CRUD_REXPEITA/ManterProduto?btnOperacao=Remover&txtId="+id;
                    console.log(url);  
                        swal({
                        title: "Você tem certeza?",
                        text: "Uma vez deletado, você não conseguirá recuperar este produto!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true
                      }).then((willDelete) => {
                        if (willDelete) {
                             deleteConfirmed(url, idCount);
                        } else {
                          swal("Seu produto está salvo!");
                        }
                      });
                }
                function deleteConfirmed(url, idCount){
                    document.getElementById("deletar" + idCount).setAttribute("href", url);
                    document.getElementById("deletar" + idCount).click();
                }
                function sortTableNumber(n) {
                    var table, rows, switching, i, x, y, shouldSwitch, count = 0;
                    table = document.getElementById("tabelaProdutos");
                    switching = true;
                    
                    var direction = "ascending";
                    while (switching) {
                      switching = false;
                      rows = table.rows;
                      for (i = 1; i < (rows.length - 1); i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];
                        
                        if (direction === "ascending") {
  
                            if (parseFloat(x.innerHTML.replace('R$','')) > parseFloat(y.innerHTML.replace('R$',''))) {
                                shouldSwitch = true;
                                break;
                            }
                        } else if (direction === "descending") {
  
                            if (parseFloat(x.innerHTML.replace('R$','')) < parseFloat(y.innerHTML.replace('R$',''))) {
                                shouldSwitch = true;
                                break;
                            }
                        }
                      }
                      if (shouldSwitch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                        count++;
                      }else {
                            if (count === 0 && direction === "ascending") {
                                direction = "descending";
                                switching = true;
                            }
                        }
                    }
                  }
                
                function sortTable(n) {
                var table;
                table = document.getElementById("tabelaProdutos");
                var rows, i, x, y, count = 0;
                var switching = true;
  
                var direction = "ascending";
  
                while (switching) {
                    switching = false;
                    var rows = table.rows;
  
                    for (i = 1; i < (rows.length - 1); i++) {
                        var Switch = false;
  
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];
  
                        if (direction === "ascending") {
  
                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase())
                                {
                                Switch = true;
                                break;
                            }
                        } else if (direction === "descending") {
  
                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase())
                                {
                                Switch = true;
                                break;
                            }
                        }
                    }
                    if (Switch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
  
                        count++;
                    } else {
                        if (count === 0 && direction === "ascending") {
                            direction = "descending";
                            switching = true;
                        }
                    }
                }
            }	
                
                function cancelarEdicao(elementCount, idCount){
                    document.getElementsByTagName("tr")[elementCount / 6 + 1].removeAttribute("style","background: cadetblue;");
                    document.getElementById("editar" + idCount).removeAttribute("style", "display: inline;");
                    document.getElementById("deletar" + idCount).setAttribute("style", "display: inline;");
                    document.getElementById("cancelarEdicao" + idCount).removeAttribute("style", "display: none;");
                    document.getElementById("confirmarEdicao" + idCount).removeAttribute("style", "display: none;");
                    
                    var vaiAte = elementCount - 5;
                    elementCount -= 2;
                    while (elementCount >= vaiAte) {
                        document.getElementsByTagName("td")[elementCount].setAttribute("contenteditable",false);
                        document.getElementsByTagName("td")[elementCount].removeAttribute("style", "border: solid 2px rgba(255,255,255,0.5);");
                        elementCount--;
                    }
                    
                }
                
                function confirmarEdicao(elementCount, idCount){
                    document.getElementsByTagName("tr")[elementCount / 6 + 1].removeAttribute("style","background: cadetblue;");
                    document.getElementById("editar" + idCount).removeAttribute("style", "display: inline;");
                    document.getElementById("deletar" + idCount).setAttribute("style", "display: inline;");
                    document.getElementById("confirmarEdicao" + idCount).removeAttribute("style", "display: none;");
                    document.getElementById("cancelarEdicao" + idCount).removeAttribute("style", "display: none;");
                    
                    var contagemVetor = 0;
                    var i = elementCount-2;
                    var dadosAlterados = [];
                    var vaiAte = elementCount - 5;
                    elementCount -= 2;
                    while (elementCount >= vaiAte) {
                        document.getElementsByTagName("td")[elementCount].setAttribute("contenteditable",false);
                        document.getElementsByTagName("td")[elementCount].removeAttribute("style", "border: solid 2px rgba(255,255,255,0.5);");
                        
                        while( i >= vaiAte-1) {
                            dadosAlterados[contagemVetor] = document.getElementsByTagName("td")[i].textContent;
                            contagemVetor++;
                            i--;
                        }
                        elementCount--;
                    }
                    var id = dadosAlterados[4].replace(' ','%20');
                    var nome = dadosAlterados[3].replace(' ','%20');
                    var tec = dadosAlterados[2].replace(' ','%20');
                    var cor = dadosAlterados[1].replace(' ','%20');
                    var valor = parseFloat(dadosAlterados[0].replace('R$',''));
                    var url = "http://localhost:8084/CRUD_REXPEITA/ManterProduto?btnOperacao=Atualizar&txtId="+id+"&txtNomeProduto="+nome+"&txtTecnologia="+tec+"&txtCor="+cor+"&txtValor="+valor;
                    document.getElementById("confirmarEdicao" + idCount).setAttribute("href", url);
                }
                
                function editar(elementCount, idCount){
                    document.getElementsByTagName("tr")[elementCount / 6 + 1].setAttribute("style","background: cadetblue;");
                    document.getElementById("editar" + idCount).setAttribute("style", "display: none;");
                    document.getElementById("deletar" + idCount).setAttribute("style", "display: none;");
                    document.getElementById("confirmarEdicao" + idCount).setAttribute("style", "display: inline;");
                    document.getElementById("cancelarEdicao" + idCount).setAttribute("style", "display: inline;");
                    
                    var vaiAte = elementCount - 5;
                    elementCount -= 2;
                    while (elementCount >= vaiAte) {
                        document.getElementsByTagName("td")[elementCount].setAttribute("contenteditable",true);
                        document.getElementsByTagName("td")[elementCount].setAttribute("style", "border: solid 2px rgba(255,255,255,0.5);");
                        elementCount--;
                    }
                }
            </script>
    </body>
</html>
