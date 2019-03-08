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
  usua_fechaDeNacimiento datetime NOT NULL,
  /*edad int -- cuando se consulte (columna calculada)*/
  usua_foto BLOB NULL,
  PRIMARY KEY (usua_id))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table LUGAR
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS LUGAR (
  lug_id INT NOT NULL AUTO_INCREMENT,
  lug_nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (lug_id),
  UNIQUE INDEX nombre_UNIQUE (lug_nombre ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CATEGORIA
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIA (
  cat_id INT NOT NULL AUTO_INCREMENT,
  cat_nombre VARCHAR(45) NOT NULL,
  cat_descripcion VARCHAR(200) NOT NULL,
  PRIMARY KEY (cat_id),
  UNIQUE INDEX nombre_UNIQUE (cat_nombre ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table EVENTO
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS EVENTO (
  even_id INT NOT NULL AUTO_INCREMENT,
  even_nombre VARCHAR(45) NOT NULL,
  even_descripcion VARCHAR(200) NOT NULL,
  even_capacidad VARCHAR(45) NULL,
  even_fecha datetime NOT NULL,
  even_duracion INT NULL,
  even_costo INT NULL,
  even_foto BLOB NULL,
  even_idUsuario INT NOT NULL,
  even_idLugar INT NOT NULL,
  even_idCategoria INT NOT NULL,
  PRIMARY KEY (even_id),
  INDEX fk_usuario_idx (even_idUsuario ASC) VISIBLE,
  INDEX fk_lugar_idx (even_idLugar ASC) VISIBLE,
  INDEX fk_categoria_idx (even_idCategoria ASC) VISIBLE,
  CONSTRAINT fk_usuario_evento
    FOREIGN KEY (even_idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_lugar_evento
    FOREIGN KEY (even_idLugar)
    REFERENCES LUGAR (lug_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_categoria_evento
    FOREIGN KEY (even_idCategoria)
    REFERENCES CATEGORIA (cat_id)
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
  fecha datetime,
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
  CONSTRAINT fk_categoria_intereses
    FOREIGN KEY (idCategoria)
    REFERENCES CATEGORIA (cat_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_usuario_intereses
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (usua_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

