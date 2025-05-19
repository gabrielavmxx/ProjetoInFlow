var dashModel = require("../models/dashModel");

function buscarGraficosPorHipermercado(req, res) {
  var idUsuario = req.params.idUsuario; // precisa mudar!!

  dashModel.buscarGraficosPorHipermercado(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os aquarios: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarGraficosPorHipermercado
}