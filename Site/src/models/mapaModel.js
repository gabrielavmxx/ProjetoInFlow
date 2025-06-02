var database = require("../database/config");

function buscarValoresDosUltimos5minPorSensor(idSupermercado) {

    var instrucaoSql = `
    SELECT s.x, s.y, COUNT(presenca) AS value FROM registros r
    INNER JOIN sensor s ON r.fksensor = s.id
    INNER JOIN corredor c ON s.fkcorredor = c.id
    INNER JOIN supermercado sm ON c.fksupermercado = sm.id
    INNER JOIN empresa em ON sm.fkempresa = em.id
    WHERE sm.id = ${idSupermercado} AND 
    datahora > DATE_SUB(('2025-05-19 10:11:00'), INTERVAL 20 MINUTE)
    GROUP BY s.x, s.y;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarValoresDosUltimos5minPorSensor
}
