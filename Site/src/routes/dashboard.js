var express = require("express");
var router = express.Router();

var dashController = require("../controllers/dashController");

// Ajustado: rota sem parâmetro de usuário
router.get("/hipermercado", function (req, res) {
  dashController.buscarGraficosPorHipermercado(req, res);
});

module.exports = router;