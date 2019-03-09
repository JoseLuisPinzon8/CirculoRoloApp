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

router.get('/registrar', (req, res) => {
  res.render('Sesion/registrar');
});

router.post('/login', async (req, res) => {
	const {userName, pass} = req.body;
	const iniSesion = {
		userName,
		pass
	};
/*
	await pool.query('insert into LUGAR (lug_id, lug_nombre)values('+iniSesion.pass+',"'+iniSesion.userName+'");');*/

	const usuario = await pool.query('select * from USUARIOS where usua_userName="'+iniSesion.userName+'" and usua_contraseña="'+iniSesion.pass+'";');
	if(usuario.length>0){
		//res.send('recibido');
		console.log(usuario);
		res.render('evento/inicio');
	}else{
		//res.send('usuario no existe');
		res.render('Sesion/login');
	}
	
});

module.exports = router;
