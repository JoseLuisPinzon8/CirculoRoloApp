const express = require('express');
const router = express.Router();

const pool = require('../database');

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
  res.render('Sesion/login');
});

router.post('/login', async (req, res) => {
	const {userName, pass} = req.body;
	const iniSesion = {
		userName,
		pass
	};

//	console.log(iniSesion);

	await pool.query('Insert Into LUGAR values('+iniSesion.pass+',' +iniSesion.userName+');');
	res.send('recibido');
});

module.exports = router;
