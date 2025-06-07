const express = require('express');
const router = express.Router();
const kpiController = require('../controllers/kpiController');

router.get('/kpis/:idSupermercado', function (req, res){
    kpiController.buscarKPIs(req,res)
});

module.exports = router;