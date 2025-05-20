var database = require("../database/config");

function buscarCorredoresPorEmpresa(empresaId) {

  var instrucaoSql = `  select cor.id as id, ar.nome as nome, fkempresa from corredor cor inner join areas ar on cor.fkarea=ar.id
inner join supermercado sup on sup.id=ar.fksupermercado  WHERE fkempresa = ${empresaId}`;

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
