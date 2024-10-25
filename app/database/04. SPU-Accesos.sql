USE linofino;

DROP PROCEDURE IF EXISTS `spu_registrar_modulos`;
DELIMITER //
CREATE PROCEDURE `spu_registrar_modulos`
(
	OUT _idmodulo	INT,
	IN _modulo	VARCHAR(50)
)
BEGIN
	-- Declaración de variables
	DECLARE existe_error INT DEFAULT 0;
	
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
	INSERT INTO modulos (modulo) values (_modulo);
    
     -- Retornar un valor por la variable OUT
	IF existe_error = 1 THEN
		SET _idmodulo = -1;
	ELSE
        SET _idmodulo = LAST_INSERT_ID();
    END IF;
END //


DROP PROCEDURE IF EXISTS `spu_registrar_accesos`;
DELIMITER //
CREATE PROCEDURE `spu_registrar_accesos`
(
	OUT _idacceso INT,
	IN _idmodulo	INT,
    IN _ruta	VARCHAR(50),
    IN _visibilidad	BOOLEAN,
    IN _texto		VARCHAR(50),
    IN _icono		VARCHAR(100)
)
BEGIN
	-- Declaración de variables
	DECLARE existe_error INT DEFAULT 0;
	
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
        
	INSERT INTO accesos (idmodulo, ruta, visibilidad, texto, icono) values (_idmodulo, _ruta, _visibilidad, NULLIF(_texto, ''), NULLIF(_icono,''));
    
    -- Retornar un valor por la variable OUT
	IF existe_error = 1 THEN
		SET _idacceso = -1;
	ELSE
        SET _idacceso = LAST_INSERT_ID();
    END IF;
END //
