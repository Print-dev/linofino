/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - linofino
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`linofino` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `linofino`;

/*Table structure for table `detalletareas` */

DROP TABLE IF EXISTS `detalletareas`;

CREATE TABLE `detalletareas` (
  `iddetalle` int(11) NOT NULL AUTO_INCREMENT,
  `idususupervisor` int(11) NOT NULL,
  `idjornada` int(11) NOT NULL,
  `idtarea` int(11) NOT NULL,
  `cantidad` smallint(6) NOT NULL,
  `preciotarea` decimal(5,2) NOT NULL,
  `idusucaja` int(11) DEFAULT NULL,
  `pagado` char(1) NOT NULL DEFAULT 'N',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddetalle`),
  KEY `fk_idususupervisor_dta` (`idususupervisor`),
  KEY `fk_idjornada_dta` (`idjornada`),
  KEY `fk_idtarea_dta` (`idtarea`),
  KEY `fk_idusucaja_dta` (`idusucaja`),
  CONSTRAINT `fk_idjornada_dta` FOREIGN KEY (`idjornada`) REFERENCES `jornadas` (`idjornada`),
  CONSTRAINT `fk_idtarea_dta` FOREIGN KEY (`idtarea`) REFERENCES `tareas` (`idtarea`),
  CONSTRAINT `fk_idusucaja_dta` FOREIGN KEY (`idusucaja`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idususupervisor_dta` FOREIGN KEY (`idususupervisor`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalletareas` */

/*Table structure for table `jornadas` */

DROP TABLE IF EXISTS `jornadas`;

CREATE TABLE `jornadas` (
  `idjornada` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `horainicio` datetime NOT NULL,
  `horatermino` datetime DEFAULT NULL,
  PRIMARY KEY (`idjornada`),
  KEY `fk_idpersona_jor` (`idpersona`),
  CONSTRAINT `fk_idpersona_jor` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `jornadas` */

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `telefono` char(9) NOT NULL,
  `dni` char(8) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `uk_dni_per` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `personas` */

insert  into `personas`(`idpersona`,`apellidos`,`nombres`,`telefono`,`dni`,`direccion`) values 
(1,'FRANCIA MINAYA','JHON EDWARD','956834915','45406071','Calle Lima 123'),
(2,'TASAYCO MEZA','RAUL','946546546','21861876','Calle Grau 123'),
(3,'NICOLAS LOPEZ','MARIBEL','946546546','45464748','Jiron Italia N° 778'),
(4,'QUISPE SALAZAR','NELSON','965165165','48456516','Av Los infieles N 123');

/*Table structure for table `tareas` */

DROP TABLE IF EXISTS `tareas`;

CREATE TABLE `tareas` (
  `idtarea` int(11) NOT NULL AUTO_INCREMENT,
  `nombretarea` varchar(100) NOT NULL,
  `precio` decimal(5,2) NOT NULL,
  `idusuregistra` int(11) NOT NULL,
  `idusuactualiza` int(11) DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idtarea`),
  UNIQUE KEY `uk_nombretarea_tar` (`nombretarea`),
  KEY `fk_idusuregistra_tar` (`idusuregistra`),
  KEY `fk_idusuactualiza_tar` (`idusuactualiza`),
  CONSTRAINT `fk_idusuactualiza_tar` FOREIGN KEY (`idusuactualiza`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idusuregistra_tar` FOREIGN KEY (`idusuregistra`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tareas` */

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `nomusuario` varchar(30) NOT NULL,
  `claveacceso` varchar(70) NOT NULL,
  `perfil` char(3) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nomusuario_usu` (`nomusuario`),
  KEY `fk_idpersona_usu` (`idpersona`),
  CONSTRAINT `fk_idpersona_usu` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`idpersona`,`nomusuario`,`claveacceso`,`perfil`) values 
(1,1,'jfrancia','$2y$10$VbXvmD47HmfbEsXTmJYlRejPu6WZME2HQ/hLWlb1Ytyrz2hSjjU8u','ADM'),
(2,2,'rtasayco','$2y$10$OjtaEnU8k7zGhTRryOeE4eX.V6gvHOTVQkF1Z1KRncuLLoJAvmaTC','COL'),
(3,4,'nquispe','$2y$10$I4klnKNxz.C/E4r8HCdNXOVfOvv/mpWJP1jZshBTSQWFPaNT4sSxi','SUP');

/* Procedure structure for procedure `spu_personas_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_personas_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_personas_registrar`(OUT `_idpersona` INT, IN `_apellidos` VARCHAR(40), IN `_nombres` VARCHAR(40), IN `_telefono` CHAR(9), IN `_dni` CHAR(8), IN `_direccion` VARCHAR(100))
BEGIN
	-- Declaración de variables
	DECLARE existe_error INT DEFAULT 0;
	
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
	
    -- Instrucción a ejecutar
    INSERT INTO personas (apellidos, nombres, telefono, dni, direccion) VALUES
		(_apellidos, _nombres, _telefono, _dni, NULLIF(_direccion, ''));
	
    -- Retornar un valor por la variable OUT
	IF existe_error = 1 THEN
		SET _idpersona = -1;
	ELSE
        SET _idpersona = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_listar`()
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres, PE.telefono, PE.dni, PE.direccion,
        US.nomusuario, US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        ORDER BY US.idusuario DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login`(IN `_nomusuario` VARCHAR(30))
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres,
        US.nomusuario,
        US.claveacceso,
        US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        WHERE US.nomusuario = _nomusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_registrar`(OUT `_idusuario` INT, IN `_idpersona` INT, IN `_nomusuario` VARCHAR(30), IN `_claveacceso` CHAR(70), IN `_perfil` CHAR(3))
BEGIN
	-- Declaración de variables
	DECLARE existe_error INT DEFAULT 0;
	
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
	
    -- Instrucción a ejecutar
    INSERT INTO usuarios (idpersona, nomusuario, claveacceso, perfil) VALUES
		(_idpersona, _nomusuario, _claveacceso, _perfil);
	
    -- Retornar un valor por la variable OUT
	IF existe_error = 1 THEN
		SET _idusuario = -1;
	ELSE
        SET _idusuario = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
