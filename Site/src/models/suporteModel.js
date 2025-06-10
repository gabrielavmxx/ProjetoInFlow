var database = require("../database/config")

function autenticarSuporte(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
                    SELECT us.id as id, us.nome as nome, email, fksupermercado as IdSupermercado, sup.nome as nomeSupermercado from usuario us inner join supermercado sup on sup.id=fksupermercado WHERE email = '${email}' AND senha = '${senha}';

    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticarSuporte,
};