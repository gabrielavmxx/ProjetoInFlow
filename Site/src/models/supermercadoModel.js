var database = require("../database/config");

function buscarSupermercadoPorUsuario(empresaId) {

  var instrucaoSql = `SELECT * FROM supermercado WHERE fkempresa = ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, nome) {
  
  var instrucaoSql = `INSERT INTO (nome, fkempresa) supermercado VALUES (${nome}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
    buscarSupermercadoPorEmpresa,
    cadastrar
}