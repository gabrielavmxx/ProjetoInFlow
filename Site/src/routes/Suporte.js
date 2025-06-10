var express = require("express");
var router = express.Router();

var suporteController = require("../controllers/suporteController");

router.post("/autenticarSuporte", function (req, res) {
    suporteController.autenticarSuporte(req, res);
});


module.exports = router;