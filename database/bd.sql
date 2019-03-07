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
DROP TABLE IF EXISTS MODERADOR;
DROP TABLE IF EXISTS CATEGORIAS;
DROP TABLE IF EXISTS ADMINISTRADOR;
DROP TABLE IF EXISTS LUGAR;
DROP TABLE IF EXISTS USUARIOS;


CREATE TABLE IF NOT EXISTS USUARIOS (
  id INT NOT NULL AUTO_INCREMENT,
  userName VARCHAR(45) NOT NULL,
  nombres VARCHAR(45) NOT NULL,
  apellidos VARCHAR(45) NOT NULL,
  contraseña VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  fechaDeNacimiento datetime NOT NULL,
  /*edad int -- cuando se consulte (columna calculada)*/
  foto BLOB NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table LUGAR
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS LUGAR (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  paginaWeb VARCHAR(45) NULL,
  latitud DOUBLE NULL,
  longitud DOUBLE NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CATEGORIAS
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIAS (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX nombre_UNIQUE (nombre ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table MODERADOR
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS MODERADOR (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario INT NOT NULL,
  idCategoria INT NOT NULL,
  /*fechaDeAscenso datetime GENERATED ALWAYS AS (sysdate()), --AL MOMENTO DE LA INSERCIÓN PONEMOS NOW()*/
  fechaDeAscenso datetime,
  PRIMARY KEY (id),
  INDEX fk_usuario_idx (idUsuario ASC) VISIBLE,
  INDEX fk_categoria_idx (idCategoria ASC) VISIBLE,
  CONSTRAINT fk_usuario_moderador
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_categoria_moderador
    FOREIGN KEY (idCategoria)
    REFERENCES CATEGORIAS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table EVENTO
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS EVENTO (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  capacidad VARCHAR(45) NULL,
  fecha datetime NOT NULL,
  duracion INT NULL,
  costo INT NULL,
  foto BLOB NULL,
  validado TINYINT NULL,
  idUsuario INT NOT NULL,
  idLugar INT NOT NULL,
  idCategoria INT NOT NULL,
  idModerador INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_usuario_idx (idUsuario ASC) VISIBLE,
  INDEX fk_lugar_idx (idLugar ASC) VISIBLE,
  INDEX fk_categoria_idx (idCategoria ASC) VISIBLE,
  INDEX fk_moderador_idx (idModerador ASC) VISIBLE,
  CONSTRAINT fk_usuario_evento
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_lugar_evento
    FOREIGN KEY (idLugar)
    REFERENCES LUGAR (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_categoria_evento
    FOREIGN KEY (idCategoria)
    REFERENCES CATEGORIAS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_moderador_evento
    FOREIGN KEY (idModerador)
    REFERENCES MODERADOR (id)
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
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_participacion
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (id)
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
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_reaccion
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (id)
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
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evento_comentario
    FOREIGN KEY (idEvento)
    REFERENCES EVENTO (id)
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
    REFERENCES CATEGORIAS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_usuario_intereses
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ADMINISTRADOR
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS ADMINISTRADOR (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_usuarios_idx (idUsuario ASC) VISIBLE,
  CONSTRAINT fk_usuarios_administrador
    FOREIGN KEY (idUsuario)
    REFERENCES USUARIOS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
