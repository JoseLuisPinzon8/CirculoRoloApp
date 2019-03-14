const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/crearevento', (req, res) => {
  res.render('evento/crearEvento');
});

router.post('/crearevento', (req, res) => {
	const { nombreEvento, descripcion, capacidad, fecha, duracion, costo, tipo, foto} = req.body;

  console.log(req.body);

  switch (tipo) {
    case 'Conciertos':
      url="https://files.informabtl.com/uploads/2018/09/concierto.jpg";
      break;
    case 'Cultura':
      url="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHVIZDdYA3cYzcVnxTDN8wrpjKxLTQKJtQRWILBATRAFQ2pPVA";
      break;
    case 'Comedia':
      url="https://comedyzone.jgm.uchile.cl/wp-content/uploads/2018/12/la-previa-del-stand-up.jpg";
      break;
    case 'Teatro':
      url="http://www.unicentrocucuta.com/wp-content/uploads/2016/08/teatro-1024x1024.jpg";
      break;
    case 'Familiar':
      url="https://cdn.pixabay.com/photo/2017/07/27/15/34/happy-family-2545719_960_720.png";
      break;
    case 'Deportes':
      url="https://www.trollfootball.me/upload/full/2018/11/06/liverpool-in-champions-league-last-year-vs-liverpool.jpg";
      break;
    case 'Festivales':
      url="https://i1.wp.com/festivalflyer.com/wp-content/uploads/2018/06/Leefest-The-Neverland-Festival-news-We-cant-wait-to-be-watching-The-Fortress-Stage-at-Neverworld...-Are-you-excited.jpg?fit=720%2C720&ssl=1";
      break;
    case 'Educativos':
      url="https://rtvc-assets-radionacional-v2.s3.amazonaws.com/s3fs-public/styles/imagen_720x720/public/senalradio/articulo-noticia/galeriaimagen/unal_1.jpg?itok=0nabAx9k&timestamp=1436446939";
      break;
  }
  var q = 'INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) VALUES (';
	q += '"'+nombreEvento+'"';
	q += ',"'+descripcion+'"';
	q += ","+capacidad;
	q += ',"'+fecha+'"';
	q += ","+duracion;
	q += ","+costo;
	q += ",1,1,";
  q += '"'+tipo+'","'+url+'");';
	console.log(q)
	pool.query(q,(error,results,fields)=>{
		if(error) throw error;
		res.redirect('/perfil');
	});

});


router.get('/', (req, res) => {
	c = "SELECT * FROM evento order by even_fecha; ";
	pool.query(c,(error,results,fields)=>{
		if(error) throw error;
	  	//console.log(results);
		res.render('evento/inicio', {results});
	});
});

router.get('/perfil', (req, res) => {
  c = "SELECT * FROM evento order by even_fecha; ";
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
      console.log(results);
    res.render('evento/perfil', {results});
  });
});

router.get('/verevento/:idEvento',   (req, res) => {
  c = "select * from EVENTO where even_id = "+req.params.idEvento+";";

  pool.query(c,(error,results,fields)=>{
		if(error) throw error;
	  	//console.log(results);
		res.render('evento/verEvento', {results});
	});

});

router.get('/vereventoperfil/:idEvento',   (req, res) => {
  c = "select * from EVENTO where even_id = "+req.params.idEvento+";";

  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
      //console.log(results);
    res.render('evento/verEventoPerfil', {results});
  });

});

router.get('/conciertos', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Conciertos" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
      //console.log(results);
    res.render('categorias/conciertos', {results});
  });
});

router.get('/conciertosperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Conciertos" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/conciertosPerfil', {results});
  });
});

router.get('/cultura', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Cultura" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/cultura', {results});
  });
});

router.get('/culturaperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Cultura" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/culturaPerfil', {results});
  });
});

router.get('/comedia', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Comedia" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/comedia', {results});
  });
});

router.get('/comediaperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Comedia" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/comediaPerfil', {results});
  });
});

router.get('/teatro', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Teatro" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/teatro', {results});
  });
});

router.get('/teatroperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Teatro" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/teatroPerfil', {results});
  });
});

router.get('/familiar', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Familiar" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/familiar', {results});
  });
});

router.get('/familiarperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Familiar" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/familiarPerfil', {results});
  });
});


router.get('/deportes', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Deportes" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/deportes', {results});
  });
});

router.get('/deportesperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Deportes" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/deportesPerfil', {results});
  });
});

router.get('/festivales', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Festivales" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/festivales', {results});
  });
});

router.get('/festivalesperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Festivales" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/festivalesPerfil', {results});
  });
});

router.get('/educativos', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Educativos" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/educativos', {results});
  });
});

router.get('/educativosperfil', (req, res) => {
  c = 'select * from EVENTO where even_categoria="Educativos" order by even_fecha;';
  pool.query(c,(error,results,fields)=>{
    if(error) throw error;
    res.render('categorias/educativosPerfil', {results});
  });
});

router.get('/perfil', (req, res) => {
  res.render('evento/perfil');
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
  //console.log(usuario);
  if(usuario.length>0){
    //res.send('recibido');
    //{{nombreUsuario}}=usuario[1];
    //res.render('evento/perfil');
    res.redirect('/perfil');
  }else{
    //res.send('usuario no existe');
    req.flash('errLogin','Usuario o Contraseña incorrectos');
    res.redirect('/login');
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
      res.redirect('/registro');
  }     
});

module.exports = router;
