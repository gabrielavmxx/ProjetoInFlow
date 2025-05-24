var express = require("express");
var router = express.Router();

var dashController = require("../controllers/dashController");

router.get("/hipermercado/:idUsuario", function (req, res) {
  dashController.buscarGraficosPorHipermercado(req, res);
});

module.exports = router;