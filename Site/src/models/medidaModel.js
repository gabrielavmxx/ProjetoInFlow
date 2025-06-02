var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function buscarFluxoPorCorredor(idSupermercado, mes, ano) {
    console.log("Acessando o Model para buscar fluxo por corredor...");

    var instrucaoSql = `
        SELECT 
            corredor.id AS idCorredor,
            corredor.posicao AS corredor,
            COUNT(registros.id) AS fluxoPessoas
        FROM registros
        JOIN sensor ON registros.fksensor = sensor.id
        JOIN corredor ON sensor.fkcorredor = corredor.id
    WHERE corredor.fksupermercado = ${idSupermercado} and month(datahora)=${mes} and year(datahora)=${ano}
        GROUP BY corredor.id, corredor.posicao
        ORDER BY idCorredor;
    `;

    console.log("Executando a SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}
function buscarFluxoPorPeriodo(idSupermercado, ano, mes) {
    console.log("Acessando o Model para buscar fluxo por corredor...");

    var instrucaoSql = `
       
SELECT 

    c.fksupermercado AS Supermercado,
    CASE 
        WHEN TIME(datahora) >= '07:00:00' AND TIME(datahora) < '12:00:00' THEN 'Manhã'
        WHEN TIME(datahora) >= '12:00:00' AND TIME(datahora) < '18:00:00' THEN 'Tarde'
        WHEN TIME(datahora) >= '18:00:00' AND TIME(datahora) < '22:00:00' THEN 'Noite'
        ELSE 'Fechado'
    END AS Horarios_SuperMercado,
    COUNT(*) AS Total_Registros
FROM registros r 
INNER JOIN sensor s ON s.id = r.fksensor
INNER JOIN corredor c ON c.id = s.fkcorredor
where fksupermercado = ${idSupermercado} and year(datahora) =${ano} and month(datahora) = ${mes}
GROUP BY 

    c.fksupermercado,
    Horarios_SuperMercado
order by Horarios_SuperMercado;
    `;

    console.log("Executando a SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function buscarMedidasEmTempoReal(idAquario) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarFluxoPorCorredor, 
    buscarFluxoPorPeriodo
}
