var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    const limite_linhas = 7;

    var idAquario = req.params.idAquario;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(idAquario, limite_linhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarFluxoPorCorredor(req, res) {
    var idSupermercado = req.params.idSupermercado;
    var mes= req.params.mes;
    var ano = req.params.ano;

    console.log(`Recuperando fluxo de pessoas por corredor do supermercado ${idSupermercado}`);

    medidaModel.buscarFluxoPorCorredor(idSupermercado,mes,ano)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar o fluxo por corredor.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}
function buscarFluxoPorPeriodo(req, res) {
    var idSupermercado = req.params.idSupermercado;
    var mes= req.params.mes;
    var ano = req.params.ano;

    console.log(`Recuperando fluxo de pessoas por PERIODO do supermercado ${idSupermercado}`);

    medidaModel.buscarFluxoPorPeriodo(idSupermercado,ano,mes)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar o fluxo por corredor.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}





function buscarMedidasEmTempoReal(req, res) {

    var idAquario = req.params.idAquario;

    console.log(`Recuperando medidas em tempo real`);

    medidaModel.buscarMedidasEmTempoReal(idAquario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarFluxoPorCorredor,
    buscarFluxoPorPeriodo

}