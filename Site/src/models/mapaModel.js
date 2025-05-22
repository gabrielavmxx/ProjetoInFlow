var database = require("../database/config");

function buscarValoresDosUltimos5minPorSensor(idSupermercado, sensor) {

    var instrucaoSql = `SELECT 
        fksensor, 
        COUNT(presenca) 
        FROM registros r
            INNER JOIN sensor s ON r.fksensor = s.id
            INNER JOIN corredor c ON s.fkcorredor = c.id
            INNER JOIN supermercado sm ON c.fksupermercado = sm.id
            INNER JOIN empresa em ON sm.fkempresa = em.id
                WHERE sm.id = 1 AND datahora > DATE_SUB(('2025-05-19 08:11:00'), INTERVAL 5 MINUTE)
            GROUP BY fksensor;`;
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarValoresDosUltimos5minPorSensor
}
