const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/perfil', (req, res) => {
  res.render('evento/perfil');
});

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', (req, res) => {
	const { nombreEvento, descripcion, capacidad, fecha, duracion, costo} = req.body;
	var q = 'INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_idLugar,even_idCategoria) VALUES (';
	q += '"'+nombreEvento+'"';
	q += ',"'+descripcion+'"';
	q += ","+capacidad;
	q += ',"'+fecha+'"';
	q += ","+duracion;  
	q += ","+costo; 
	q += ",1,1,1);";
	console.log(q)
	c = "select * from evento"; 
	db.query(q,(error,results,fields)=>{
		if(error) throw error;
		res.redirect('/');
	});
	
});


router.get('/', (req, res) => {
	c = "SELECT * FROM evento";
	console.log("hooolaaaa");
	db.query(c,(error,results,fields)=>{
		if(error) throw error;
	  	console.log(results);
		res.render('evento/inicio', {results});
	});
});

router.get('/verevento/:nombreEvento', async  (req, res) => {
  const eventoX = req.params;
  console.log(eventoX);
  res.render('evento/verEvento', {eventoX});
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
	
	const usuario = await pool.query('select * from USUARIOS where usua_userName="'+iniSesion.userName+'" and usua_contraseña="'+iniSesion.pass+'";');

	if(usuario.length>0){
		res.render('evento/perfil');
	}else{
		req.flash('errLogin','Usuario o Contraseña incorrectos');
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
