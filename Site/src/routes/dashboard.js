var express = require("express");
var router = express.Router();

var dashController = require("../controllers/dashController");

// Ajustado: rota sem parâmetro de usuário
router.get("/hipermercado", function (req, res) {
  dashController.buscarGraficosPorHipermercado(req, res);
});

router.get("/dadosCorredor/:idSupermercado/:idCorredor/:ano", function (req, res) {
  dashController.dadosPorCorredor(req, res);
});

module.exports = router;