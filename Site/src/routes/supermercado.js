var express = require("express");
var router = express.Router();

var supermercadoController = require("../controllers/supermercadoController");

router.get("/:empresaId", function (req, res) {
  supermercadoController.buscarSupermercadoPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  supermercadoController.cadastrar(req, res);
})

module.exports = router;