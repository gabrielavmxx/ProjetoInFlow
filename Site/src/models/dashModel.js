var database = require("../database/config");

function buscarDadosDashBoard (idRegistro) {

      var instrucaoSql = `SELECT * FROM Registro r WHERE fkSensor = ${idRegistro}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}
