
--ELIMINACION DE LAS TABLAS 

drop table temporal;

drop table pelicula_clasificacion;
drop table pelicula_lenguaje;
drop table pelicula_categoria;
drop table pelicula_actor;
drop table tienda_pelicula;
drop table cliente_tienda;
drop table prestamo;
drop table cliente;
drop table empleado;
drop table tienda;
drop table ciudad;
drop table pais;
drop table pelicula;
drop table actor;
drop table categoria;
drop table lenguaje;
drop table clasificacion;














--CREACION DE LAS TABLAS



CREATE TABLE actor (
    id_actor INTEGER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL ,
    nombre   VARCHAR2(255)
);

ALTER TABLE actor ADD CONSTRAINT actor_pk PRIMARY KEY ( id_actor );

CREATE TABLE categoria (
    id_categoria INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre       VARCHAR2(255)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE ciudad (
    id_ciudad INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre    VARCHAR2(255)
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE clasificacion (
    id_clasificacion INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre           VARCHAR2(255)
);

ALTER TABLE clasificacion ADD CONSTRAINT clasificacion_pk PRIMARY KEY ( id_clasificacion );

CREATE TABLE cliente (
    id_cliente          INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre              VARCHAR2(255),
    correo              VARCHAR2(255),
    activo              VARCHAR2(255),
    fecha_creacion      VARCHAR2(255),
    direccion           VARCHAR2(255),
    codigo_postal       VARCHAR2(255),
    id_tienda_preferida INTEGER NOT NULL,
    ciudad_id_ciudad    INTEGER NOT NULL,
    pais_id_pais        INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE cliente_tienda (
    cliente_id_cliente INTEGER NOT NULL,
    tienda_id_tienda   INTEGER NOT NULL
);

CREATE TABLE empleado (
    id_empleado      INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre           VARCHAR2(255),
    correo           VARCHAR2(255),
    activo           VARCHAR2(255),
    usuario          VARCHAR2(255),
    contrasena       VARCHAR2(255),
    direccion        VARCHAR2(255),
    codigo           VARCHAR2(255),
    ciudad_id_ciudad INTEGER NOT NULL,
    pais_id_pais     INTEGER NOT NULL,
    tienda_id_tienda INTEGER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE lenguaje (
    id_lenguaje INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre      VARCHAR2(255)
);

ALTER TABLE lenguaje ADD CONSTRAINT lenguaje_pk PRIMARY KEY ( id_lenguaje );

CREATE TABLE pais (
    id_pais INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre  VARCHAR2(255)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE pelicula (
    id_pelicula INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre      VARCHAR2(255),
    descripcion VARCHAR2(255),
    lanzamiento INTEGER,
    costo_renta INTEGER,
    duracion    INTEGER,
    costo_dano  INTEGER
);

ALTER TABLE pelicula ADD CONSTRAINT pelicula_pk PRIMARY KEY ( id_pelicula );

CREATE TABLE pelicula_actor (
    pelicula_id_pelicula INTEGER NOT NULL,
    actor_id_actor       INTEGER NOT NULL
);

CREATE TABLE pelicula_categoria (
    categoria_id_categoria INTEGER NOT NULL,
    pelicula_id_pelicula   INTEGER NOT NULL
);

CREATE TABLE pelicula_clasificacion (
    pelicula_id_pelicula           INTEGER NOT NULL,
    clasificacion_id_clasificacion INTEGER NOT NULL
);

CREATE TABLE pelicula_lenguaje (
    lenguaje_id_lenguaje INTEGER NOT NULL,
    pelicula_id_pelicula INTEGER NOT NULL
);

CREATE TABLE prestamo (
    id_prestamo          INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    fecha_renta          DATE,
    fecha_retorno        DATE NULL,
    monto_pagar          INTEGER,
    fecha_pago           DATE,
    dias_renta           INTEGER,
    empleado_id_empleado INTEGER NOT NULL,
    pelicula_id_pelicula INTEGER NOT NULL,
    cliente_id_cliente   INTEGER NOT NULL
);

ALTER TABLE prestamo ADD CONSTRAINT prestamo_pk PRIMARY KEY ( id_prestamo );

CREATE TABLE tienda (
    id_tienda        INTEGER  GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    nombre           VARCHAR2(255),
    encargado        VARCHAR2(255),
    direccion        VARCHAR2(255),
    codigo_postal    VARCHAR2(255),
    ciudad_id_ciudad INTEGER NOT NULL,
    pais_id_pais     INTEGER NOT NULL
);

ALTER TABLE tienda ADD CONSTRAINT tienda_pk PRIMARY KEY ( id_tienda );

CREATE TABLE tienda_pelicula (
    tienda_id_tienda     INTEGER NOT NULL,
    pelicula_id_pelicula INTEGER NOT NULL
);

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE cliente_tienda
    ADD CONSTRAINT cliente_tienda_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_tienda_fk FOREIGN KEY ( id_tienda_preferida )
        REFERENCES tienda ( id_tienda );

ALTER TABLE cliente_tienda
    ADD CONSTRAINT cliente_tienda_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE pelicula_actor
    ADD CONSTRAINT pelicula_actor_actor_fk FOREIGN KEY ( actor_id_actor )
        REFERENCES actor ( id_actor );

ALTER TABLE pelicula_actor
    ADD CONSTRAINT pelicula_actor_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );


ALTER TABLE pelicula_categoria
    ADD CONSTRAINT pelicula_cate_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE pelicula_categoria
    ADD CONSTRAINT pelicula_categoria_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );


ALTER TABLE pelicula_clasificacion
    ADD CONSTRAINT pelicula_clasi_clasificacion_fk FOREIGN KEY ( clasificacion_id_clasificacion )
        REFERENCES clasificacion ( id_clasificacion );


ALTER TABLE pelicula_clasificacion
    ADD CONSTRAINT pelicula_clasi_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );

ALTER TABLE pelicula_lenguaje
    ADD CONSTRAINT pelicula_lenguaje_lenguaje_fk FOREIGN KEY ( lenguaje_id_lenguaje )
        REFERENCES lenguaje ( id_lenguaje );

ALTER TABLE pelicula_lenguaje
    ADD CONSTRAINT pelicula_lenguaje_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );

ALTER TABLE prestamo
    ADD CONSTRAINT prestamo_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE prestamo
    ADD CONSTRAINT prestamo_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE prestamo
    ADD CONSTRAINT prestamo_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );

ALTER TABLE tienda
    ADD CONSTRAINT tienda_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE tienda
    ADD CONSTRAINT tienda_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE tienda_pelicula
    ADD CONSTRAINT tienda_pelicula_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );

ALTER TABLE tienda_pelicula
    ADD CONSTRAINT tienda_pelicula_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );




















