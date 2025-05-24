  var dashModel = require("../models/dashModel");
  
  function buscarGraficosPorHipermercado(req, res) {
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

  module.exports = {
    buscarGraficosPorHipermercado
  }