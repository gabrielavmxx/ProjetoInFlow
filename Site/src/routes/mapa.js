var express = require("express");
var router = express.Router();

var mapaController = require("../controllers/mapaController");

router.get("/ultimos5Min/:idSupermercado", function (req, res){
    mapaController.buscarValoresDosUltimos5minPorSensor(req, res);
});

module.exports = router;