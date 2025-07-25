var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
                    SELECT us.id as id, us.nome as nome, email, us.acesso as acesso, fksupermercado as IdSupermercado, sup.nome as nomeSupermercado from usuario us inner join supermercado sup on sup.id=fksupermercado WHERE email = '${email}' AND senha = '${senha}';

    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha, acesso, fksupermercado) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, acesso, fksupermercado);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha, fotoPerfil, acesso, fksupermercado) VALUES ('${nome}', '${email}', '${senha}', null, '${acesso}', '${fksupermercado}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function alterarDados(fotoPerfil, id){
    var instrucaoSql = `
        UPDATE usuario SET fotoPerfil = '${fotoPerfil}' where id = ${id}
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar(idSupermercado) {
    console.log("ACESSEI O ADMIN  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar():", idSupermercado);
    var instrucaoSql = `
    SELECT id, 
            nome, 
            email, 
            acesso, 
            fksupermercado
    FROM usuario 
        WHERE fksupermercado = ${idSupermercado};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function deletar(idUsuario) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function deletar():", idUsuario);
    var instrucaoSql = `DELETE FROM usuario WHERE id = ${idUsuario}`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar,
    alterarDados,
    listar,
    deletar
};