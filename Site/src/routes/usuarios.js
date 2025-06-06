var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.post("/alterarDados", function (req, res) {
    usuarioController.alterarDados(req, res);
});

router.get("/listar/:idSupermercado", function (res, req) {
    usuarioController.listar(req, res);
})

router.delete("/deletar/:idUsuario", function (res, req) {
    usuarioController.deletar(req, res);
})

module.exports = router;