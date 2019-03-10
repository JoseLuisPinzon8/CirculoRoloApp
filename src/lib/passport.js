const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');

passport.use('local.registro', new LocalStrategy({
  usernameField: 'usua_userName',
  passwordField: 'usua_contraseña',
  passReqToCallback: true
}, (req, username, password, done) => {
  const { userName, usua_nombres, usua_apellidos, usua_correo, usua_fechaDeNacimiento } = req.body;
  console.log(username, usua_nombres, usua_apellidos, usua_correo, usua_fechaDeNacimiento);
  var q = 'INSERT INTO USUARIOS (usua_userName, usua_nombres, usua_apellidos, usua_contraseña, usua_correo, usua_fechaDeNacimiento) VALUES (';
  q += '"' + username + '"';
  q += ',"' + usua_nombres + '"';
  q += ',"' + usua_apellidos + '"';
  q += ',"' + password + '"';
  q += ',"' + usua_correo + '"';
  q += ',"' + usua_fechaDeNacimiento + '");';
  console.log(q);
  c = 'select * from USUARIOS';
  pool.query(q, (error, results, fields)=> {
    if (error) throw error;
  });
}));
