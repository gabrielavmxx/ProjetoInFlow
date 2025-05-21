var database = require("../database/config");

function buscarCorredoresPorEmpresa(empresaId) {

  var instrucaoSql = `  select cor.posicao as id, ar.nome from corredor cor inner join supermercado sup on sup.id=cor.fksupermercado inner join areas ar on cor.fkarea=ar.id where ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarCorredoresPorEmpresa,
  cadastrar
}
