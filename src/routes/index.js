const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.render('evento/inicio');
});

router.get('/crearevento', (requ, res) => {
  res.render('evento/crearEvento');
});

router.get('/verevento', (requ, res) => {
  res.render('evento/verEvento');
});

module.exports = router;
