//ACA ARRANCA LA APLICACIÓN
const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');

//Initialization
const app = express();

//setings
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
  defaultLayout: 'main',
  layoutsDir: path.join(app.get('views'), 'layouts'),
  partialDir: path.join(app.get('views'), 'partials'),
  extname: '.hbs',
  helpers: require('./lib/handlebars'),
}));
app.set('view engine', '.hbs');//La linea de arriba es como funciona handlebars

//Middlewares	
app.use(morgan('dev'));
//para poder aceptar desde los formularios los datos que me envían los usuarios
app.use(express.urlencoded({ extended: false }));

//Global variables
app.use((req,res,next)=>{

next();
});

//Routes
app.use(require('./routes/index'));

//Lo de abajo es para crear carpetas por ruta, lo que Farid no quiere
app.use('/eventos', require('./routes/eventos'));

//app.use(require('./routes/crearevento'))

//Public

//Carpeta en la que van todos los archivos al que el ordenador puede acceder

//Starting server
app.listen(app.get('port'), () => {
  console.log('Servidor en puerto: ', app.get('port'));
});
