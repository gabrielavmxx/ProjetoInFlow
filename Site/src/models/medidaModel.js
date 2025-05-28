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


function buscarFluxoPorCorredor(idSupermercado) {
    console.log("Acessando o Model para buscar fluxo por corredor...");

    var instrucaoSql = `
        SELECT 
            corredor.id AS idCorredor,
            corredor.posicao AS corredor,
            COUNT(registros.id) AS fluxoPessoas
        FROM registros
        JOIN sensor ON registros.fksensor = sensor.id
        JOIN corredor ON sensor.fkcorredor = corredor.id
        WHERE corredor.fksupermercado = ${idSupermercado}
        GROUP BY corredor.id, corredor.posicao
        ORDER BY idCorredor;
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
    buscarFluxoPorCorredor
}
