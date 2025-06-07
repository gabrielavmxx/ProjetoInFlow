const kpiModel = require('../models/kpiModel');

async function buscarKPIs(req, res) {
  const idSupermercado = req.params.idSupermercado;
  const mes = req.query.mes;
  const ano = req.query.ano;
  try {
    const [total, maior, dia, menor] = await Promise.all([
      kpiModel.totalAtivacoes(idSupermercado, mes, ano),
      kpiModel.corredorMaiorFluxo(idSupermercado, mes, ano),
      kpiModel.diaMaiorFluxo(idSupermercado, mes, ano),
      kpiModel.corredorMenorFluxo(idSupermercado, mes, ano)
    ]);
    res.json({
      totalAtivacoes: total[0]?.total || 0,
      corredorMaiorFluxo: maior[0]?.posicao || '-',
      diaMaiorFluxo: dia[0]?.dia || '-',
      corredorMenorFluxo: menor[0]?.posicao || '-'
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

module.exports = { buscarKPIs };