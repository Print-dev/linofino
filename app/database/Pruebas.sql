USE linofino;

INSERT INTO perfiles (perfil, nombrecorto) VALUES 
	('Administrador','ADM'),
    ('Supervisor','COL'),
    ('Colaborador','SUP');
    
SELECT * from perfiles;
SELECT * FROM personas;
SELECT * FROM usuarios;

CALL spu_personas_registrar(@id,'Avalos Romero', 'Royer','999333111','72754412','');
CALL spu_personas_registrar(@id,'Tasayco Torres', 'Raul','931204818','72753312','');
CALL spu_personas_registrar(@id,'Quipse Morales', 'Nadia','942302123','75474852','');

CALL spu_usuarios_registrar(@id,1,'ravalos','ENCRIPTADA',1);
CALL spu_usuarios_registrar(@id,2,'rtasayco','ENCRIPTADA',2);
CALL spu_usuarios_registrar(@id,3,'nquispe','ENCRIPTADA',3);

-- Clave: SENATI123
update usuarios set claveacceso = '$2y$10$3jjBFoh7zxvgdFXnrFmvmOQBZ0Hv0DvVTHA/RAXIqWT56c.S16zlC';

-- jfrancia (administrador)
-- rtasayco (colaborador) 
-- nquispe (supervisor)

select * from usuarios;
select * from personas;

DELETE FROM usuarios;
DELETE FROM personas;
ALTER TABLE usuarios AUTO_INCREMENT 1;
ALTER TABLE personas AUTO_INCREMENT 1;


INSERT INTO modulos (modulo) VALUES
	('jornadas'),
    ('pagos'),
    ('produccion'),
    ('reportes'),
    ('usuarios'),
    ('tareas');
    
INSERT INTO vistas (idmodulo, ruta, sidebaroption, texto, icono) VALUES
	(NULL, 'home','S','Inicio','fa-solid fa-wallet'),
    (1, 'listar-jornada','S','Jornadas','fa-solid fa-wallet'),
    (2, 'listar-pago','S','Pagos','fa-solid fa-wallet'),
    (3, 'listar-produccion','S','Producción','fa-solid fa-wallet'),
    (4, 'reporte-diario','S','Reportes','fa-solid fa-wallet');
    
INSERT INTO vistas (idmodulo, ruta, sidebaroption, texto, icono) VALUES
	(5, 'listar-usuario','S','Usuarios','fa-solid fa-wallet'),
    (5, 'registrar-usuario','N',NULL,NULL),
    (5, 'actualizar-usuario','N',NULL,NULL);
    
INSERT INTO vistas (idmodulo, ruta, sidebaroption, texto, icono) VALUES
	(6, 'listar-tarea','S','Tareas','fa-solid fa-wallet'),
    (6, 'registrar-tarea','N',NULL,NULL);
    
    
SELECT * FROM vistas;
-- JORNADAS
-- PAGOS
-- PRODUCCION
-- REPORTES

-- USUARIOS
-- TAREAS

INSERT INTO permisos (idperfil, idvista) VALUES
	(1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (1,7),
    (1,8),
    (1,9),
    (1,10);
    
INSERT INTO permisos (idperfil, idvista) VALUES
	(2,1),
    (2,4),
    (2,5),
    (2,9),
    (2,3);
    
INSERT INTO permisos (idperfil, idvista) VALUES
	(3,1),
    (3,9);