const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', (req, res) => {
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
});

router.get('/verevento/:nombreEvento', async  (req, res) => {
  //console.log(req.params.nombreEvento);
  const eventoX = req.params;
  console.log(eventoX);
  //res.send('evento');
  res.render('evento/verEvento', {eventoX});
});

module.exports = router;
