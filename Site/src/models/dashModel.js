var database = require("../database/config");

function buscarDadosDashBoard() {
  var instrucaoSql = `
        SELECT 
            sm.nome AS supermercado,
            c.posicao AS corredor,
            MONTH(r.datahora) AS mes,
            YEAR(r.datahora) AS ano,
            COUNT(r.presenca) AS total_movimentacoes
        FROM registros r
        INNER JOIN sensor s ON r.fksensor = s.id
        INNER JOIN corredor c ON s.fkcorredor = c.id
        INNER JOIN supermercado sm ON c.fksupermercado = sm.id
        GROUP BY sm.nome, c.posicao, mes, ano
        ORDER BY ano DESC, mes DESC, sm.nome, c.posicao;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function dadosPorCorredor(idSupermercado, idCorredor, ano){
  var instrucaoSql = `
    select COUNT(r.id) AS fluxoPessoas
    from registros r
    inner join sensor s on r.fksensor = s.id
    inner join corredor c on s.fkcorredor = c.id
    where c.fksupermercado = ${idSupermercado} and c.id = ${idCorredor} and year(r.datahora) = '${ano}' group by month(r.datahora);
  `

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarDadosDashBoard,
  dadosPorCorredor
};