USE linofino;

DROP PROCEDURE IF EXISTS `spu_personas_registrar`;
DELIMITER //
CREATE PROCEDURE `spu_personas_registrar`
(
	OUT _idpersona		INT, -- Negativo cuando CATCH|restricción
	IN _apellidos 		VARCHAR(40),
    IN _nombres 		VARCHAR(40),
    IN _telefono		CHAR(9),
    IN _dni				CHAR(8),
    IN _direccion		VARCHAR(100)
)
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
END //




