DROP DATABASE IF EXISTS `linofino`;
CREATE DATABASE linofino;
USE linofino;

CREATE TABLE personas
(
	idpersona 		INT AUTO_INCREMENT PRIMARY KEY,
    apellidos 		VARCHAR(40)		NOT NULL,
    nombres 		VARCHAR(40)		NOT NULL,
    telefono 		CHAR(9) 		NOT NULL,
    dni 			CHAR(8) 		NOT NULL,
    direccion		VARCHAR(100) 	NULL,
    CONSTRAINT uk_dni_per UNIQUE (dni)
)ENGINE = INNODB;

-- ALTER TABLE personas ADD `direccion` VARCHAR(100) NOT NULL AFTER `dni`;
-- ALTER TABLE personas ADD `telefono` CHAR(9) NOT NULL AFTER `nombres`;
CREATE TABLE perfiles
(
	idperfil	INT auto_increment PRIMARY KEY,
    perfil		VARCHAR(50) 		NOT NULL,
    nombrecorto	CHAR(3)				NOT NULL,
    create_at	DATETIME 			NOT NULL DEFAULT NOW(),
    CONSTRAINT 	uk_perfil_per		UNIQUE (perfil),
    CONSTRAINT 	uk_nombrecorto_per 	UNIQUE (nombrecorto)
)ENGINE = INNODB;

CREATE TABLE usuarios 
(
	idusuario 		INT AUTO_INCREMENT PRIMARY KEY,
    idpersona 		INT 			NOT NULL,
    nomusuario		VARCHAR(30)		NOT NULL,
    claveacceso 	VARCHAR(70) 	NOT NULL,
    idperfil 		INT		 		NOT NULL, -- ADM | COL | AST
    CONSTRAINT fk_idpersona_usu FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT uk_nomusuario_usu UNIQUE (nomusuario),
    CONSTRAINT fk_idperfil		foreign key (idperfil) REFERENCES perfiles(idperfil)    
)ENGINE = INNODB;

CREATE TABLE tareas
(
	idtarea 		INT AUTO_INCREMENT PRIMARY KEY,
    nombretarea	 	VARCHAR(100)	NOT NULL,
    precio 			DECIMAL(5,2)	NOT NULL,
    idusuregistra	INT 			NOT NULL,
    idusuactualiza	INT 			NULL,
    create_at 		DATETIME 		NOT NULL DEFAULT NOW(),
    update_at 		DATETIME 		NULL,
    CONSTRAINT uk_nombretarea_tar UNIQUE (nombretarea),
    CONSTRAINT ck_precio_tar CHECK (precio > 0),
    CONSTRAINT fk_idusuregistra_tar FOREIGN KEY (idusuregistra) REFERENCES usuarios (idusuario),
    CONSTRAINT fk_idusuactualiza_tar FOREIGN KEY (idusuactualiza) REFERENCES usuarios (idusuario)
)ENGINE = INNODB;

CREATE TABLE jornadas
(
	idjornada 		INT AUTO_INCREMENT PRIMARY KEY,
    idpersona 		INT 			NOT NULL,
    horainicio		DATETIME 		NOT NULL,
    horatermino		DATETIME 		NULL,
    CONSTRAINT fk_idpersona_jor FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT ck_horas_jor CHECK (horainicio < horatermino)
)ENGINE = INNODB;

CREATE TABLE detalletareas
(
	iddetalle		INT AUTO_INCREMENT PRIMARY KEY,
    idususupervisor	INT 			NOT NULL, -- Encargado de agregar este registro
    idjornada 		INT 			NOT NULL, -- Día, trabajador
    idtarea 		INT 			NOT NULL, -- Operación realizada
    cantidad 		SMALLINT 		NOT NULL,
    preciotarea 	DECIMAL(5,2) 	NOT NULL,
    idusucaja 		INT 			NULL,	 -- Encargado de realizar el pago
    pagado 			CHAR(1) 		NOT NULL DEFAULT 'N',
    create_at 		DATETIME 		NOT NULL DEFAULT NOW(),
    update_at 		DATETIME 		NULL,
    CONSTRAINT fk_idususupervisor_dta FOREIGN KEY (idususupervisor) REFERENCES usuarios (idusuario),
    CONSTRAINT fk_idjornada_dta FOREIGN KEY (idjornada) REFERENCES jornadas (idjornada),
    CONSTRAINT fk_idtarea_dta FOREIGN KEY (idtarea) REFERENCES tareas (idtarea),
    CONSTRAINT fk_idusucaja_dta FOREIGN KEY (idusucaja) REFERENCES usuarios (idusuario),
    CONSTRAINT ck_pagado_dta CHECK (pagado IN ('S','N'))
)ENGINE = INNODB;

CREATE TABLE modulos
(
	idmodulo	INT auto_increment primary key,
    modulo		VARCHAR(50) NOT NULL,
    create_at	DATETIME	NOT NULL DEFAULT NOW(),
    CONSTRAINT 	uk_modulo_mod	UNIQUE (modulo)
)ENGINE=INNODB;

CREATE TABLE vistas 
(
	idvista			INT 			auto_increment primary key,
    idmodulo		INT				null,
    ruta			VARCHAR(50) 	NOT NULL,
    sidebaroption	CHAR(1)			NOT NULL,
	texto			VARCHAR(50)		NULL,
    icono			VARCHAR(100)	NULL,
	CONSTRAINT fk_idmodulo_vis FOREIGN KEY(idmodulo) REFERENCES modulos(idmodulo),
    CONSTRAINT uk_ruta_vis		UNIQUE (ruta),
    CONSTRAINT ck_sidebaroption_vis CHECK (sidebaroption IN ('S','N'))
)ENGINE=INNODB;

CREATE TABLE permisos
(
	idpermiso 			INT 	auto_increment PRIMARY KEY,
	idperfil			INT 	NOT NULL,
    idvista				INT 	NOT NULL,
    create_at			DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_idvista		 	foreign key (idvista) REFERENCES vistas(idvista),
    CONSTRAINT idperfil				foreign key (idperfil) REFERENCES perfiles(idperfil),
    CONSTRAINT uk_vista_per 		UNIQUE (idperfil, idvista)
)ENGINE=INNODB;
