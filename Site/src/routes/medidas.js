var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})
router.get("/fluxo/:idSupermercado/:mes/:ano", function (req, res) {
    medidaController.buscarFluxoPorCorredor(req, res);
});
router.get("/pizza/:idSupermercado/:mes/:ano", function (req, res) {
    medidaController.buscarFluxoPorPeriodo(req, res);
});

module.exports = router;