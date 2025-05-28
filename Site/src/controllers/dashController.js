var dashModel = require("../models/dashModel");

function buscarGraficosPorHipermercado(req, res) {
  // Ajustado: sem capturar req.params.idUsuario
  dashModel.buscarDadosDashBoard()
    .then((resultado) => {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).json([]);
      }
    }).catch(function (erro) {
      console.log("Houve um erro ao buscar os registros: ", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
    });
}

function dadosPorCorredor(req, res) {
  var idSupermercado = req.params.idSupermercado;
  var idCorredor = req.params.idCorredor;
  var ano = req.params.ano;

  dashModel.dadosPorCorredor(idSupermercado, idCorredor, ano)
    .then((resultado) => {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).json([]);
      }
    }).catch(function (erro) {
      console.log("Houve um erro ao buscar os registros: ", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  buscarGraficosPorHipermercado,
  dadosPorCorredor
};