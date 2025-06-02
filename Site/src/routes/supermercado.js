var express = require("express");
var router = express.Router();

var supermercadoController = require("../controllers/supermercadoController");

router.get("/buscar/:id", function (req, res) {
  supermercadoController.buscarSupermercadoPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  supermercadoController.cadastrar(req, res);
})

module.exports = router;