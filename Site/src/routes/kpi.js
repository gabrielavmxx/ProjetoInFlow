const express = require('express');
const router = express.Router();
const kpiController = require('../controllers/kpiController');

router.get('/kpis/:idSupermercado', function (req, res){
    kpiController.buscarKPIs(req,res)
});

router.get('/kpisTempoReal/:idSupermercado', function (req, res){
    kpiController.buscarKPIsTempoReal(req,res)
});

module.exports = router;