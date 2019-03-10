const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');

passport.use('local.registro', new LocalStrategy({
  usernameField: 'usua_userName',
  passwordField: 'usua_contraseña',
  passReqToCallback: true
}, (username, password, req, done) => {
  console.log(req.body);
  const { userName, nombres, apellidos, correo, fechaDeNacimiento } = req.body;
  var q = 'INSERT INTO USUARIOS (usua_userName, usua_nombres, usua_apellidos, usua_contraseña, usua_correo, usua_fechaDeNacimiento) VALUES (';
  q += '"' + username + '"';
  q += ',"' + nombres + '"';
  q += ',"' + apellidos + '"';
  q += ',"' + password + '"';
  q += ',"' + correo + '"';
  q += ',"' + fechaDeNacimiento + '");';
  console.log(q);
  c = 'select * from USUARIOS';
  pool.query(q, (error, results, fields)=> {
    if (error) throw error;
  });
}));
