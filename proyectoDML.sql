SET search_path TO "ciudad";

INSERT INTO padrino (dni, nombre_y_ape, direccion, facebook, mail, cod_postal) VALUES
('12345678', 'Lucía Pérez', 'Av. Corrientes 1234', 'lucia.pperez', 'luciaperez4@gmail.com', 'C1043'),
('87654321', 'Martín Gómez', 'Suipacha 300', 'martin.gomezz', 'martingomez1@gmail.com', 'B7000'),
('11223344', 'Sofía Ramírez', 'San Martín 4321', 'sofi.r', 'sofiiiramirex@hotmail.com', 'T4000'),
('44556677', 'Juan Fernández', 'Alsina 2020', 'juancito.f', 'juanfernandez@outlook.com', 'C1040'),
('33445566', 'Ana Torres', 'Av. Belgrano 2345', 'ana.torres', 'anitatorres@gmail.com', 'B8000'),
('99887766', 'Diego Sosa', 'Mitre 789', 'diegos', 'diegos@hotmail.com', 'M5500'),
('22334455', 'María López', 'Av. Libertador 100', 'maria_lo', 'marialopezz@yahoo.com', 'C1425');

INSERT INTO mtel (dni, telefono, tipo) VALUES
('12345678', '1123456789', 'CELULAR'),
('12345678', '47891234', 'FIJO'),
('87654321', '1133345566', 'CELULAR'),
('11223344', '1145678901', 'CELULAR'),
('44556677', '1156789012', 'FIJO'),
('33445566', '1167890123', 'CELULAR'),
('99887766', '1178901234', 'FIJO');

INSERT INTO contacto (dni, fecha_primer_contacto, fecha_alta, fecha_baja, fecha_rechazo_ad, estado) VALUES
('12345678', '2022-01-10', '2022-01-15', NULL, NULL, 'ADHERIDO'),
('87654321', '2022-02-01', '2022-02-10', '2023-01-01', NULL, 'BAJA'),
('11223344', '2022-03-01', '2022-03-10', NULL, NULL, 'VOLUNTARIO'),
('44556677', '2022-04-01', NULL, NULL, NULL, 'SIN LLAMAR'),
('33445566', '2022-05-01', '2022-05-10', NULL, NULL, 'ADHERIDO'),
('99887766', '2022-06-01', '2022-06-10', NULL, NULL, 'EN GESTION'),
('22334455', '2022-07-01', '2022-07-10', NULL, NULL, 'AMIGO');

INSERT INTO donante (dni, ocupacion, cuil) VALUES
('12345678', 'Docente', '27123456789'),
('87654321', 'Ingeniero', '27876543210'),
('11223344', 'Estudiante', '27112233445'),
('44556677', 'Médico', '27445566778'),
('33445566', 'Comerciante', '27334455661'),
('99887766', 'Abogada', '27998877663'),
('22334455', 'Jubilada', '27223344558');

INSERT INTO programa (nombre, descripcion) VALUES
('Apadrinamiento Escolar', 'Apoyo mensual a estudiantes vulnerables'),
('Salud Infantil', 'Financia controles médicos y vacunas'),
('Becas Universitarias', 'Ayuda económica a estudiantes terciarios'),
('Nutrición Infantil', 'Entrega de leche y alimentos a familias'),
('Hogar Digno', 'Mejoras habitacionales'),
('Deporte y Valores', 'Actividades deportivas solidarias'),
('Acceso Digital', 'Entrega de computadoras a escuelas');

INSERT INTO medioPago (nombre_titular) VALUES
('Lucía Pérez'),
('Martín Gómez'),
('Sofía Ramírez'),
('Juan Fernández'),
('Ana Torres'),
('Diego Sosa'),
('María López');

INSERT INTO credito (id_medio_pago, nombre_tarjeta, numero_tarjeta, fecha_vencimiento) VALUES
(1, 'Visa', '4111111111111111', '2026-10-01'),
(2, 'MasterCard', '5500000000000004', '2025-12-01'),
(3, 'Visa', '4111111111111112', '2026-05-01'),
(4, 'MasterCard', '5500000000000005', '2027-07-01'),
(5, 'Visa', '4111111111111113', '2028-09-01'),
(6, 'MasterCard', '5500000000000006', '2026-03-01'),
(7, 'Visa', '4111111111111114', '2025-12-01');

INSERT INTO debito_o_transferencia (id_medio_pago, cbu, nombre_y_suc_banco, nro_cuenta, tipo_cuenta) VALUES
(1, '2850590940090418135201', 'Banco Nación Suc. 123', '123456789012', 'Caja de Ahorro'),
(2, '0720054630000001234567', 'Banco Galicia Suc. 456', '234567890123', 'Cuenta Corriente'),
(3, '1430011613000006789012', 'Banco Provincia Suc. 789', '345678901234', 'Caja de Ahorro'),
(4, '2850590940090418000002', 'Banco Santander Suc. 890', '456789012345', 'Cuenta Corriente'),
(5, '0720054630000001111111', 'Banco Macro Suc. 111', '567890123456', 'Caja de Ahorro'),
(6, '1430011613000002222222', 'Banco Ciudad Suc. 222', '678901234567', 'Cuenta Corriente'),
(7, '2850590940090418333333', 'Banco HSBC Suc. 333', '789012345678', 'Caja de Ahorro');

INSERT INTO aportan (dni, id_programa, monto, frecuencia, id_medio_pago) VALUES
('12345678', 1, 5000, 'MENSUAL', 1),
('12345678', 2, 5000, 'MENSUAL', 1),
('12345678', 3, 5000, 'MENSUAL', 1),
('87654321', 1, 3000, 'MENSUAL', 2),
('11223344', 3, 4000, 'SEMANAL', 3),
('44556677', 4, 6000, 'MENSUAL', 4),
('33445566', 5, 3500, 'SEMANAL', 5),
('99887766', 6, 2500, 'MENSUAL', 6),
('22334455', 7, 4500, 'SEMANAL', 7);

