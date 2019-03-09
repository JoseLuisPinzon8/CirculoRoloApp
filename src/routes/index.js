const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.render('evento/inicio');
	});

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', (req, res) => {
	console.log(req.body);
	res.redirect('/crearevento');
});

router.get('/verevento', (req, res) => {
  res.render('evento/verEvento');
});

module.exports = router;
