var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/suporteController");

router.post("/autenticarSuporte", function (req, res) {
    usuarioController.autenticar(req, res);
});


module.exports = router;