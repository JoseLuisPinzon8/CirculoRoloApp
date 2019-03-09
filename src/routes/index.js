const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/', (req, res) => {
  res.render('evento/inicio');
	});

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', async (req, res) => {
	const { nombreEvento, descripcion, capacidad, fecha, duracion, costo} = req.body;
	const evento = {
		nombreEvento,
		descripcion,
		capacidad,
		fecha,
		duracion,
		costo
	};
	db.query('INSERT INTO evento set ?',[evento]); 
	res.redirect('/verevento');
});

router.get('/verevento', (req, res) => {
  res.render('evento/verEvento');
});

module.exports = router;
