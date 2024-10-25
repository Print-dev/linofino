-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-10-2024 a las 19:09:07
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `linofino`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_personas_registrar` (OUT `_idpersona` INT, IN `_apellidos` VARCHAR(40), IN `_nombres` VARCHAR(40), IN `_telefono` CHAR(9), IN `_dni` CHAR(8), IN `_direccion` VARCHAR(100))   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_listar` ()   BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres, PE.telefono, PE.dni, PE.direccion,
        US.nomusuario, US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        ORDER BY US.idusuario DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login` (IN `_nomusuario` VARCHAR(30))   BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres,
        US.nomusuario,
        US.claveacceso,
        US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        WHERE US.nomusuario = _nomusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_registrar` (OUT `_idusuario` INT, IN `_idpersona` INT, IN `_nomusuario` VARCHAR(30), IN `_claveacceso` CHAR(70), IN `_perfil` CHAR(3))   BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalletareas`
--

CREATE TABLE `detalletareas` (
  `iddetalle` int(11) NOT NULL,
  `idususupervisor` int(11) NOT NULL,
  `idjornada` int(11) NOT NULL,
  `idtarea` int(11) NOT NULL,
  `cantidad` smallint(6) NOT NULL,
  `preciotarea` decimal(5,2) NOT NULL,
  `idusucaja` int(11) DEFAULT NULL,
  `pagado` char(1) NOT NULL DEFAULT 'N',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jornadas`
--

CREATE TABLE `jornadas` (
  `idjornada` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `horainicio` datetime NOT NULL,
  `horatermino` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `telefono` char(9) NOT NULL,
  `dni` char(8) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`idpersona`, `apellidos`, `nombres`, `telefono`, `dni`, `direccion`) VALUES
(1, 'FRANCIA MINAYA', 'JHON EDWARD', '956834915', '45406071', 'Calle Lima 123'),
(2, 'TASAYCO MEZA', 'RAUL', '946546546', '21861876', 'Calle Grau 123'),
(3, 'NICOLAS LOPEZ', 'MARIBEL', '946546546', '45464748', 'Jiron Italia N° 778'),
(4, 'QUISPE SALAZAR', 'NELSON', '965165165', '48456516', 'Av Los infieles N 123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `idtarea` int(11) NOT NULL,
  `nombretarea` varchar(100) NOT NULL,
  `precio` decimal(5,2) NOT NULL,
  `idusuregistra` int(11) NOT NULL,
  `idusuactualiza` int(11) DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `nomusuario` varchar(30) NOT NULL,
  `claveacceso` varchar(70) NOT NULL,
  `perfil` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `idpersona`, `nomusuario`, `claveacceso`, `perfil`) VALUES
(1, 1, 'jfrancia', '$2y$10$VbXvmD47HmfbEsXTmJYlRejPu6WZME2HQ/hLWlb1Ytyrz2hSjjU8u', 'ADM'),
(2, 2, 'rtasayco', '$2y$10$OjtaEnU8k7zGhTRryOeE4eX.V6gvHOTVQkF1Z1KRncuLLoJAvmaTC', 'COL'),
(3, 4, 'nquispe', '$2y$10$I4klnKNxz.C/E4r8HCdNXOVfOvv/mpWJP1jZshBTSQWFPaNT4sSxi', 'SUP');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalletareas`
--
ALTER TABLE `detalletareas`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `fk_idususupervisor_dta` (`idususupervisor`),
  ADD KEY `fk_idjornada_dta` (`idjornada`),
  ADD KEY `fk_idtarea_dta` (`idtarea`),
  ADD KEY `fk_idusucaja_dta` (`idusucaja`);

--
-- Indices de la tabla `jornadas`
--
ALTER TABLE `jornadas`
  ADD PRIMARY KEY (`idjornada`),
  ADD KEY `fk_idpersona_jor` (`idpersona`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`idpersona`),
  ADD UNIQUE KEY `uk_dni_per` (`dni`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`idtarea`),
  ADD UNIQUE KEY `uk_nombretarea_tar` (`nombretarea`),
  ADD KEY `fk_idusuregistra_tar` (`idusuregistra`),
  ADD KEY `fk_idusuactualiza_tar` (`idusuactualiza`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `uk_nomusuario_usu` (`nomusuario`),
  ADD KEY `fk_idpersona_usu` (`idpersona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalletareas`
--
ALTER TABLE `detalletareas`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jornadas`
--
ALTER TABLE `jornadas`
  MODIFY `idjornada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `idtarea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalletareas`
--
ALTER TABLE `detalletareas`
  ADD CONSTRAINT `fk_idjornada_dta` FOREIGN KEY (`idjornada`) REFERENCES `jornadas` (`idjornada`),
  ADD CONSTRAINT `fk_idtarea_dta` FOREIGN KEY (`idtarea`) REFERENCES `tareas` (`idtarea`),
  ADD CONSTRAINT `fk_idusucaja_dta` FOREIGN KEY (`idusucaja`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idususupervisor_dta` FOREIGN KEY (`idususupervisor`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `jornadas`
--
ALTER TABLE `jornadas`
  ADD CONSTRAINT `fk_idpersona_jor` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`);

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `fk_idusuactualiza_tar` FOREIGN KEY (`idusuactualiza`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `fk_idusuregistra_tar` FOREIGN KEY (`idusuregistra`) REFERENCES `usuarios` (`idusuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_idpersona_usu` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
