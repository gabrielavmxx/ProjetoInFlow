var supermercadoModel = require("../models/supermercadoModel");

function buscarSupermercadoPorId(req, res) {
  var id = req.params.id;

  supermercadoModel.buscarSupermercadoPorId(id).then((resultado) => {
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


function cadastrar(req, res) {
  var nome = req.body.nome;
  var idUsuario = req.body.idUsuario;

  if (nome == undefined) {
    res.status(400).send("nome está undefined!");
  } else if (idUsuario == undefined) {
    res.status(400).send("idUsuario está undefined!");
  } else {

  }
}

module.exports = {
  buscarSupermercadoPorId,
  cadastrar
}