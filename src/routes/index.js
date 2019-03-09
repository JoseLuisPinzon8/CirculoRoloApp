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
	await db.query('INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_idLugar,even_idCategoria) VALUES ('+nombreEvento+","+descripcion+","+capacidad+","+fecha+","+duracion+","+costo+",1,1,1);"); 
	res.redirect('/verevento');
});

router.get('/verevento', (req, res) => {
  res.render('evento/verEvento');
});

module.exports = router;
