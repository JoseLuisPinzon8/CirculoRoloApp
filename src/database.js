//ESTE ARCHIVO VA A TENER LA CONEXIÓN A MYSQL

const mysql = require('mysql');
const { promisify } = require('util');
const { database } = require('./keys');

const pool = mysql.createPool(database); //Crea hilos para no correr todo secuencial

pool.getConnection((err, con) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('La conexión a la base de datos fue cerrada');
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('La base de datos tiene demasiadas conexiones');
    }
    if (err.code === 'ECONNREFUSED') {
      console.error('La conexión a la base de datos fue rechazada');
    }
  }

  if (con){
    con.release(); //Así arranca la conexion  
  } 
  console.log('La base de datos está conectada');
  return;
});

//Convertir callbacks en promesas porque el modulo mysql no soporta las promesas
pool.query = promisify(pool.query);

module.exports = pool;
