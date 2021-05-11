<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manter Produto</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
        
        <div class="container">
            
            <img class="logo" src="imagens\logoRx2.png"/>
            
            <form class="formManterProduto" action="ManterProduto" method="post">
                <div class="form__group field">
                    <input type="input" class="form__field" placeholder="Nome do Produto" name="txtNomeProduto" id='name' />
                    <label for="nomeProduto" class="form__label">Nome do Produto</label>
                </div>
                <div class="form__group field">
                    <input type="input" class="form__field" placeholder="Tecnologia" name="txtTecnologia" id='tecnologia' />
                    <label for="txtTecnologia" class="form__label">Tecnologia</label>
                </div>
                <div class="form__group field">
                    <input type="input" class="form__field" placeholder="Cor" name="txtCor" id='cor' />
                    <label for="txtCor" class="form__label">Cor</label>
                </div>
                <div class="form__group field">
                    <input type="input" class="form__field" placeholder="Valor" name="txtValor" id='valor' />
                    <label for="txtValor" class="form__label">Valor</label>
                </div>
                <input class="btn-2 cadastro" type="submit" name="btnOperacao" value="Cadastrar">
                <input class="btn-2 consultar" type="submit" name="btnOperacao" value="Consultar Todos">
            </form>
        </div>
        
        <script>
            window.addEventListener('load', function() {
                var msg = "${mensagem}";
                if(msg !== '')
                    if(msg === "sucesso")
                        swal("SUCESSO!", "Produto cadastrado!", "success");
                    else
                        swal("ERRO!", "Houve um erro no cadastro do produto." + msg, "error");
            });
        </script>
    </body>
</html>
