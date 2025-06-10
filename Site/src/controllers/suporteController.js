var usuarioModel = require("../models/usuarioModel");
var corredorModel = require("../models/corredorModel");
const { json } = require("express");



function autenticarSuporte(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticarSuporte(email, senha)
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

module.exports = {
    autenticarSuporte
}