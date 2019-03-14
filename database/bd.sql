CREATE DATABASE IF NOT EXISTS circuloRolo;
USE circuloRolo;
-- -----------------------------------------------------
-- Table USUARIOS
-- -----------------------------------------------------

DROP TABLE IF EXISTS CATEGORIA_DE_INTERES;
DROP TABLE IF EXISTS COMENTARIO;
DROP TABLE IF EXISTS REACCION;
DROP TABLE IF EXISTS PARTICIPACION;
DROP TABLE IF EXISTS EVENTO;
DROP TABLE IF EXISTS CATEGORIA;
DROP TABLE IF EXISTS LUGAR;
DROP TABLE IF EXISTS USUARIOS;


CREATE TABLE IF NOT EXISTS USUARIOS (
  usua_id INT NOT NULL AUTO_INCREMENT,
  usua_userName VARCHAR(45) NOT NULL,
  usua_nombres VARCHAR(45) NOT NULL,
  usua_apellidos VARCHAR(45) NOT NULL,
  usua_contraseña VARCHAR(45) NOT NULL,
  usua_correo VARCHAR(45) NOT NULL,
  usua_fechaDeNacimiento date NOT NULL,
  /*edad int -- cuando se consulte (columna calculada)*/
  usua_foto BLOB NULL,
  PRIMARY KEY (usua_id))
ENGINE = InnoDB;

ALTER TABLE USUARIOS 
ADD UNIQUE (usua_userName);




-- -----------------------------------------------------
-- Table EVENTO
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS EVENTO (
  even_id INT NOT NULL AUTO_INCREMENT,
  even_nombre VARCHAR(45) NOT NULL,
  even_descripcion VARCHAR(600) NOT NULL,
  even_capacidad VARCHAR(45) NULL,
  even_fecha date NOT NULL,
  even_duracion INT NULL,
  even_costo INT NULL,
  even_foto VARCHAR(500) NULL,
  even_idUsuario INT NOT NULL,
  even_lugar VARCHAR(45) NOT NULL,
  even_categoria VARCHAR(45) NOT NULL,
  PRIMARY KEY (even_id),
  INDEX fk_usuario_idx (even_idUsuario ASC) VISIBLE,
  CONSTRAINT fk_usuario_evento
    FOREIGN KEY (even_idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PARTICIPACION
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS PARTICIPACION (
  idUsuario INT NOT NULL,
  idEvento INT NOT NULL,
  PRIMARY KEY (idUsuario, idEvento),
  INDEX fk_evento_idx (idEvento ASC) VISIBLE,
  CONSTRAINT fk_usuario_participacion
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_participacion
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (even_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table REACCION
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS REACCION (
  idUsuario INT NOT NULL,
  idEvento INT NOT NULL,
  reaccion INT NOT NULL,
  PRIMARY KEY (idUsuario, idEvento),
  INDEX fk_evento_idx (idEvento ASC) VISIBLE,
  CONSTRAINT fk_usuario_reaccion
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_reaccion
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (even_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table COMENTARIO
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS COMENTARIO (
  idUsuario INT NOT NULL,
  idEvento INT NOT NULL,
  comentario VARCHAR(200) NOT NULL,
  /*fecha datetime GENERATED ALWAYS AS (sysdate()) stored, --AL MOMENTO DE LA INSERCIÓN PONEMOS NOW()*/ 
  fecha date,
  PRIMARY KEY (idUsuario, idEvento),
  INDEX fk_evento_idx (idEvento ASC) VISIBLE,
  CONSTRAINT fk_usuario_comentario
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_comentario
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (even_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CATEGORIA_DE_INTERES
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS CATEGORIA_DE_INTERES (
  idUsuario INT NOT NULL,
  idCategoria INT NOT NULL,
  CATEGORIA_DE_INTEREScol VARCHAR(45) NOT NULL,
  PRIMARY KEY (idUsuario, idCategoria),
  INDEX fk_categoria_idx (idCategoria ASC) VISIBLE,
  CONSTRAINT fk_usuario_intereses
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



INSERT INTO usuarios (usua_userName,usua_nombres,usua_apellidos,usua_contraseña,usua_correo,usua_fechaDeNacimiento)
      VALUES ("USERNAME","CARLOS","CORTES","PASSWORD","HOLA@HOTMAIL.COM",'1000-01-01 00:00:00');
-- concientos
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Concierto en la Che","¿¡Qué tal compas!? El día de hoy los queremos invitar al evento que tendrá lugar el día 22 de Marzo. En la plazoleta central de la universidad se reunirán artistas que los une su odio al innombrable. No importa si te gustan los verdes, el polo o hasta cambio radical, extendemos esta invitación para todos los que consideran repulsivo al presidente que normalizó el asesinato a diestra y siniestra en nombre de la seguridad democrática ¡No faltes ¡Te esperamos!",1000,"2019-03-18",2,0,1,"La Che","Conciertos","https://files.informabtl.com/uploads/2018/09/concierto.jpg");

-- educativos
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Curso de Arduino","Este evento es para todos los usuarios de arduino, raspberry Pi, iot (Internet de las Cosas), impresión 3D, Open Source Hardware, makerspace, hackerspace, fablabs, asociaciones, maestros, profesionales y novatos interesados en aprender y compartir el uso de Arduino, raspberry Pi, iot (Internet de las Cosas), impresión 3D, Open Source Hardware y sus posibilidades. Es para aquellos que nos gusta saber cómo funcionan las cosas y llegar a hacerlas, además de brindar la posibilidad de entrar en la onda maker.",20,"2019-03-12",1,0,1,"Laboratorio microprocesadores","Educativos","https://rtvc-assets-radionacional-v2.s3.amazonaws.com/s3fs-public/styles/imagen_720x720/public/senalradio/articulo-noticia/galeriaimagen/unal_1.jpg?itok=0nabAx9k&timestamp=1436446939");

-- deportes
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Convocatoria de fútbol","Buenas las tengan, finales de semestre a punto de estallar. La facultad de ingeniería quiere extender la invitación para seleccionar las personas que harán parte del equipo de quidditch de la Universidad Nacional de Colombia - Sede Bogotá. Esperamos que todos los estudiantes se presenten a tan magno evento que tendrá lugar en las canchas de fútbol de la Universidad. Saca tu Harry Potter interno, ¡sabemos que no nos defraudarás!",1000,"2019-03-20",1,0,1,"Canchas de futbol","Deportes","https://www.trollfootball.me/upload/full/2018/11/06/liverpool-in-champions-league-last-year-vs-liverpool.jpg");

-- cultura
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Bailes Colombianos","Presentación de los bailes de todas las regiones Colombianas, un acto cultural sin precedentes! no te lo pierdas!",200,"2019-03-20",2,0,1,"La Perola","Cultura","https://www.viajejet.com/wp-content/viajes/Bailes-de-Colombia.jpg");

-- comedia 
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Boyacoman en la UN","Uno de los mejores comediante de Colombia como lo es Boyacoman, se presentará en la Universidad Nacional de Colombia, no te lo pierdas, vas a morir de la risa con sus maravillosos chistes",200,"2019-03-25",2,0,1,"La Perola","Comedia","https://www.caracoltv.com/sites/default/files/boyacoman_44.jpg");

-- teatro
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Cursos de Teatro","Ven y aprende teatro desde cero. No encontrarás un curso similar a este, con los mejores profesionales, en los mejores espacios, no faltes",25,"2019-03-28",3,5000,1,"Salón 101 - Edificio 405","Teatro","http://teatrocolon.org.ar/sites/default/files/traviata_noticia_landscape.jpg");

-- familiar
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Integración Familiar","Actividades ludicas y deportivas para la integración familiar de los estudiante de la UN. Te esperamos con toda tu familia para una tarde llena de diversión y alegría ¡Te esperamos!",50,"2019-03-27",2,0,1,"La Che","Familiar","https://t1.pb.ltmcdn.com/es/posts/5/2/8/img_el_apoyo_familiar_acontecimientos_significativos_de_vida_familiar_2825_600.jpg");

-- festivales
INSERT INTO evento (even_nombre,even_descripcion,even_capacidad,even_fecha,even_duracion,even_costo,even_idUsuario,even_lugar,even_categoria, even_foto) 
VALUES ("Festival de Títeres: Mary la titiritera","En esta oportunidad los asistentes al festival podrán aprender sobre el mundo titiritero en un taller especial y disfrutar de la Obra Que duermas bien Alfonso del grupo El Submarino invisible del capitán Nemo",100,"2019-05-28",2,0,1,"Auditorio IPARM","Festivales","http://www.kioskoteatral.com/wp-content/uploads/2016/05/VI-MARY-LA-TITIRITERA-472x360.jpg");


select * from EVENTO where even_categoria="Cultura" order by even_fecha;       