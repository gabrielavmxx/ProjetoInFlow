const database = require('../database/config');

// Total Ativações
function totalAtivacoes(idSupermercado, mes, ano) {
  const instrucaoSql = `
    SELECT COUNT(*) AS total
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND MONTH(r.datahora) = ${mes}
      AND YEAR(r.datahora) = ${ano};
  `;
  return database.executar(instrucaoSql);
}

// Corredor com maior fluxo
function corredorMaiorFluxo(idSupermercado, mes, ano) {
  const instrucaoSql = `
    SELECT c.posicao, COUNT(r.id) AS fluxo
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND MONTH(r.datahora) = ${mes}
      AND YEAR(r.datahora) = ${ano}
    GROUP BY c.id
    ORDER BY fluxo DESC
    LIMIT 1;
  `;
  return database.executar(instrucaoSql);
}

// Dia com maior fluxo
function diaMaiorFluxo(idSupermercado, mes, ano) {
  const instrucaoSql = `
    SELECT DAY(r.datahora) AS dia, COUNT(r.id) AS fluxo
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND MONTH(r.datahora) = ${mes}
      AND YEAR(r.datahora) = ${ano}
    GROUP BY dia
    ORDER BY fluxo DESC
    LIMIT 1;
  `;
  return database.executar(instrucaoSql);
}

// Corredor com menor fluxo
function corredorMenorFluxo(idSupermercado, mes, ano) {
  const instrucaoSql = `
    SELECT c.posicao, COUNT(r.id) AS fluxo
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND MONTH(r.datahora) = ${mes}
      AND YEAR(r.datahora) = ${ano}
    GROUP BY c.id
    ORDER BY fluxo ASC
    LIMIT 1;
  `;
  return database.executar(instrucaoSql);
}

function corredorMaiorFluxoAgora(idSupermercado) {
  const sql = `
    SELECT c.posicao AS corredor, 'ATENÇÃO' AS status, COUNT(r.id) AS pessoas
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND r.datahora >= NOW() - INTERVAL 5 MINUTE
    GROUP BY c.id
    ORDER BY pessoas DESC
    LIMIT 1;
  `;
  return database.executar(sql);
}

function corredorMenorFluxoAgora(idSupermercado) {
  const sql = `
    SELECT c.posicao AS corredor, 'Tranquilo' AS status, COUNT(r.id) AS pessoas
    FROM registros r
    JOIN sensor s ON r.fksensor = s.id
    JOIN corredor c ON s.fkcorredor = c.id
    WHERE c.fksupermercado = ${idSupermercado}
      AND r.datahora >= NOW() - INTERVAL 5 MINUTE
    GROUP BY c.id
    ORDER BY pessoas ASC
    LIMIT 1;
  `;
  return database.executar(sql);
}

module.exports = {  };

module.exports = {
  totalAtivacoes,
  corredorMaiorFluxo,
  diaMaiorFluxo,
  corredorMenorFluxo,
  corredorMaiorFluxoAgora, 
  corredorMenorFluxoAgora
};