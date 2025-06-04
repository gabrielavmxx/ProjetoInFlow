var database = require("../database/config");

function buscarCorredoresPorSupermercado(IdSupermercado) {

  var instrucaoSql = `  select cor.id, ar.nome,cor.posicao,cor.fksupermercado from corredor cor inner join supermercado sup on sup.id=cor.fksupermercado inner join areas ar on cor.fkarea=ar.id where fksupermercado = ${IdSupermercado}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarCorredoresPorSupermercado,
  cadastrar
}
