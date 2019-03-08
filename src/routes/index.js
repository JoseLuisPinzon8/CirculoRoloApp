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
});

router.get('/verevento', (req, res) => {
  res.render('evento/verEvento');
});

router.get('/login', (req, res) => {
  res.render('Login/login');
});

router.post('/login', (req, res) => {
	console.log("hola");
});

module.exports = router;
