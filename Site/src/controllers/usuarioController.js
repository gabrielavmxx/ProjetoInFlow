var usuarioModel = require("../models/usuarioModel");
var corredorModel = require("../models/corredorModel");
const { json } = require("express");



function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String


                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);


                        corredorModel.buscarCorredoresPorSupermercado(resultadoAutenticar[0].IdSupermercado)
                            .then((resultadoCorredores) => {
                                if (resultadoCorredores.length > 0 && resultadoCorredores.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        senha: resultadoAutenticar[0].senha,
                                        supermercado: resultadoAutenticar[0].IdSupermercado,
                                        corredores: resultadoCorredores,
                                        nomeSupermercado: resultadoAutenticar[0].nomeSupermercado
                                    });
                                } else {
                                    res.status(204).json({ corredores: [] });

                                }
                            })


                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }

            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var supermercado = req.body.supermercadoServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, supermercado)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function alterarDados(req, res) {
    var fotoPerfil = req.body.fotoPerfilServer;
    var id = req.body.idServer;

    if (fotoPerfil == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else {
        usuarioModel.alterarDados(fotoPerfil, id)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao tentar alterar dados! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function listar(req, res) {
    var idSupermercado = req.params.idSupermercado;

    usuarioModel.listar(idSupermercado).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os usuários: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function deletar(req, res) {
    var idUsuario = req.params.idUsuario;

    usuarioModel.deletar(idUsuario).then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao deletar usuário: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

module.exports = {
    autenticar,
    cadastrar,
    alterarDados,
    listar,
    deletar
}