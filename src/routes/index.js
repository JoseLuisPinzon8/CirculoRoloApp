const express = require('express');
const router = express.Router();

const passport = require('passport');

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

router.post('/login', (req, res) => {
	res.send('recibido');
});

router.get('/registro', (req, res) => {
  res.render('Sesion/registro');
})

router.post('/registro', passport.authenticate('local.registro', {
    successRedirect: '/login',
    failureRedirect: '/registro'
    //failureFlash: true
  }));

module.exports = router;
