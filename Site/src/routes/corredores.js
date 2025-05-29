var express = require("express");
var router = express.Router();

var corredorController = require("../controllers/corredorController");

router.get("/:IdSupermercado", function (req, res) {
  corredorController.buscarCorredoresPorSupermercado(req, res);
});

router.post("/cadastrar", function (req, res) {
  corredorController.cadastrar(req, res);
})

module.exports = router;