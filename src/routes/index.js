const express = require('express');
const router = express.Router();
const db = require('../database');
<<<<<<< HEAD

router.get('/', (req, res) => {
  res.render('evento/inicio');
	});
=======
>>>>>>> escribir-datos

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', (req, res) => {
<<<<<<< HEAD
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
		res.redirect('/verevento');	
	}); 
=======
  res.redirect('/');
  const { nombreEvento, organizador, tipo, fecha, duracion, capacidad, costo, image, descripcion, lugar} = req.body;
  const eventoNuevo = {
    nombreEvento, organizador, tipo, fecha, duracion, capacidad, costo, image, descripcion, lugar
  }

  listaEventos.push(eventoNuevo);

});


router.get('/', (req, res) => {
	c = "SELECT * FROM evento"; 
	db.query(c,(error,results,fields)=>{''
		if(error) throw error;
	  	console.log(results);
		res.render('evento/inicio', {c});
	});
>>>>>>> escribir-datos
});

router.get('/verevento/:nombreEvento', async  (req, res) => {
  //console.log(req.params.nombreEvento);
  const eventoX = req.params;
  console.log(eventoX);
  //res.send('evento');
  res.render('evento/verEvento', {eventoX});
});

module.exports = router;
