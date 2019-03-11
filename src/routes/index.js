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

router.get('/registro', (req, res) => {
  res.render('Sesion/registro');
})


router.post('/registro', async (req, res) => {
	const {userName, nombres,apellidos,pass,correo,fechaDeNacimiento} = req.body;
	const registro = {
	  userName,
	  nombres,
	  apellidos,
	  pass,
	  correo,
	  fechaDeNacimiento
	};
/*
	await pool.query('insert into LUGAR (lug_id, lug_nombre)values('+iniSesion.pass+',"'+iniSesion.userName+'");');*/
	try{
		const usuario = await pool.query('insert into USUARIOS (usua_userName,usua_nombres,usua_apellidos,usua_contraseña,usua_correo,usua_fechaDeNacimiento)values("'+registro.userName+'","'+registro.nombres+'","'+registro.apellidos+'","'+registro.pass+'","'+registro.correo+'","'+registro.fechaDeNacimiento+'");');
		res.render('Sesion/login');
	}
	catch(error) {
		if(error == 'ER_DUP_ENTRY'){
			console.error('El userName ya existe');
		}
		req.flash('errUserName','El UserName ya existe');
  		res.render('Sesion/registro');
	}			
});


module.exports = router;
