    drop schema if exists ciudad CASCADE;
CREATE schema ciudad;

SET search_path TO "ciudad";

drop table if exists padrino CASCADE;
CREATE TABLE padrino (
	dni VARCHAR(8) NOT NULL,
	nombre_y_ape VARCHAR(50) NOT NULL,
	direccion VARCHAR (50),
	facebook VARCHAR(50),
	mail VARCHAR(50),
	cod_postal VARCHAR(50),
	CONSTRAINT pkpadrino PRIMARY KEY (dni)
);

drop DOMAIN if exists tipo_cel cascade;
CREATE DOMAIN tipo_cel AS VARCHAR
CHECK (VALUE IN ('CELULAR', 'FIJO'));


drop table if exists mtel CASCADE;
CREATE TABLE mtel(
	dni VARCHAR(8) NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	tipo tipo_cel NOT NULL,
	CONSTRAINT pkmtel PRIMARY KEY(dni, telefono),
	CONSTRAINT fkdni FOREIGN KEY (dni) REFERENCES padrino(dni)
);

drop DOMAIN if exists tipo_estado cascade;
CREATE DOMAIN tipo_estado AS VARCHAR
CHECK (VALUE IN ('AMIGO', 'VOLUNTARIO', 'EN GESTION', 'SIN LLAMAR', 'ADHERIDO', 'ERROR', 'NO ACEPTA', 'BAJA'));

drop table if exists contacto CASCADE;
CREATE TABLE contacto(
	dni VARCHAR(8) NOT NULL,
	fecha_primer_contacto DATE,
	fecha_alta DATE,
	fecha_baja DATE,
	fecha_rechazo_ad DATE,
	estado tipo_estado,
	CONSTRAINT pkcontacto PRIMARY KEY (dni),
	CONSTRAINT fkdni FOREIGN KEY (dni) REFERENCES padrino(dni),
	CONSTRAINT fechas CHECK (fecha_baja > fecha_alta),
	CONSTRAINT fechas1 CHECK (fecha_baja > fecha_primer_contacto)
);


drop table if exists donante CASCADE;
CREATE TABLE donante(
	dni VARCHAR(8) NOT NULL,
	ocupacion VARCHAR(30),
	cuil VARCHAR(11),
	CONSTRAINT pkdonante PRIMARY KEY (dni),
	CONSTRAINT fkdni FOREIGN KEY (dni) REFERENCES padrino(dni)
);

drop table if exists programa CASCADE;
CREATE TABLE programa(
	id_programa SERIAL,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(150),
 CONSTRAINT pkprograma PRIMARY KEY (id_programa)
);

drop DOMAIN if exists tipoFrecuencia cascade;
CREATE DOMAIN tipoFrecuencia AS VARCHAR
CHECK (VALUE IN ('MENSUAL', 'SEMANAL'));


drop table if exists medioPago CASCADE; 
CREATE TABLE medioPago(
	id_medio_pago SERIAL,
	nombre_titular VARCHAR(50) NOT NULL,
	CONSTRAINT Pkid PRIMARY KEY (id_medio_pago)
);

drop table if exists aportan CASCADE;
CREATE TABLE aportan(
	dni VARCHAR(8) NOT NULL,
	id_programa INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	frecuencia tipoFrecuencia,
	id_medio_pago INTEGER NOT NULL,
	CONSTRAINT pkAportan PRIMARY KEY (dni,id_programa),
	CONSTRAINT fkdni FOREIGN KEY (dni) REFERENCES padrino(dni) ON DELETE CASCADE,
	CONSTRAINT fkid_programa FOREIGN KEY (id_programa) REFERENCES programa(id_programa),
	CONSTRAINT fkmediopago FOREIGN KEY (id_medio_pago) REFERENCES medioPago(id_medio_pago) ON DELETE CASCADE,
	CONSTRAINT montoNoNulo CHECK (monto > 0)

);

drop table if exists credito CASCADE;
CREATE TABLE credito(
	id_medio_pago INTEGER NOT NULL,
	nombre_tarjeta VARCHAR(50) NOT NULL,
	numero_tarjeta VARCHAR(16) NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	CONSTRAINT PkiC PRIMARY KEY (id_medio_pago),
	CONSTRAINT FKidMP FOREIGN KEY (id_medio_pago) REFERENCES medioPago(id_medio_pago) ON DELETE CASCADE
);

drop table if exists debito_o_transferencia CASCADE;
CREATE TABLE debito_o_transferencia(
	id_medio_pago INTEGER,
	cbu VARCHAR(22) NOT NULL,
	nombre_y_suc_banco VARCHAR(100) NOT NULL,
	nro_cuenta VARCHAR(20) NOT NULL,
	tipo_cuenta VARCHAR(30) NOT NULL,
	CONSTRAINT pkDT PRIMARY KEY (id_medio_pago),
	CONSTRAINT fkDt FOREIGN KEY (id_medio_pago) REFERENCES medioPago(id_medio_pago) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS auditoria_donante CASCADE;
CREATE TABLE auditoria_donante(
	dni VARCHAR(8),
	fecha_eliminacion TIMESTAMP DEFAULT now(),
	usuario TEXT
);

CREATE OR REPLACE FUNCTION funcion_auditoria_donante()
RETURNS trigger AS $$
BEGIN
    INSERT INTO ciudad.auditoria_donante(dni, usuario)
    VALUES (OLD.dni, current_user);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_auditoria_donante
AFTER DELETE ON donante
FOR EACH ROW
EXECUTE FUNCTION funcion_auditoria_donante();






