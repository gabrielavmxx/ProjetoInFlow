var database = require("../database/config");

function buscarSupermercadoPorId(id) {

  var instrucaoSql = `SELECT * FROM supermercado WHERE id = ${id}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(cnpj, nome) {

  var instrucaoSql = `INSERT INTO (nome, cnpj) supermercado VALUES (${nome}, ${cnpj})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarSupermercadoPorId,
  cadastrar
}