

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



CREATE TABLE temporal (
NOMBRE_CLIENTE	        VARCHAR2(255),
CORREO_CLIENTE	        VARCHAR2(255),
CLIENTE_ACTIVO	        VARCHAR2(255),
FECHA_CREACION	        VARCHAR2(255),
TIENDA_PREFERIDA	    VARCHAR2(255),
DIRECCION_CLIENTE	    VARCHAR2(255),
CODIGO_POSTAL_CLIENTE	VARCHAR2(255),
CIUDAD_CLIENTE	        VARCHAR2(255),
PAIS_CLIENTE	        VARCHAR2(255),
FECHA_RENTA	            VARCHAR2(255),
FECHA_RETORNO	        VARCHAR2(255),
MONTO_A_PAGAR	        VARCHAR2(255),
FECHA_PAGO	            VARCHAR2(255),
NOMBRE_EMPLEADO	        VARCHAR2(255),
CORREO_EMPLEADO	        VARCHAR2(255),
EMPLEADO_ACTIVO	        VARCHAR2(255),
TIENDA_EMPLEADO	        VARCHAR2(255),
USUARIO_EMPLEADO	    VARCHAR2(255),
CONTRASENA_EMPLEADO	    VARCHAR2(255),
DIRECCION_EMPLEADO	    VARCHAR2(255),
CODIGO_POSTAL_EMPLEADO	VARCHAR2(255),
CIUDAD_EMPLEADO	        VARCHAR2(255),
PAIS_EMPLEADO	        VARCHAR2(255),
NOMBRE_TIENDA	        VARCHAR2(255),
ENCARGADO_TIENDA	    VARCHAR2(255),
DIRECCION_TIENDA	    VARCHAR2(255),
CODIGO_POSTAL_TIENDA    VARCHAR2(255),
CIUDAD_TIENDA	        VARCHAR2(255),
PAIS_TIENDA	            VARCHAR2(255),
TIENDA_PELICULA	        VARCHAR2(255),
NOMBRE_PELICULA	        VARCHAR2(255),
DESCRIPCION_PELICULA	VARCHAR2(255),
ANO_LANZAMIENTO	        VARCHAR2(255),
DIAS_RENTA	            VARCHAR2(255),
COSTO_RENTA	            VARCHAR2(255),
DURACION	            VARCHAR2(255),
COSTO_POR_DANO	        VARCHAR2(255),
CLASIFICACION	        VARCHAR2(255),
LENGUAJE_PELICULA	    VARCHAR2(255),
CATEGORIA_PELICULA	    VARCHAR2(255),
ACTOR_PELICULA          VARCHAR2(255)

);

-- Llenamos primero las principales


--Para CIUDAD
INSERT INTO ciudad(nombre)
SELECT CIUDAD_CLIENTE as CIUDAD FROM  
    (SELECT CIUDAD_CLIENTE FROM temporal 
    GROUP BY CIUDAD_CLIENTE
    UNION 
    SELECT CIUDAD_EMPLEADO FROM temporal 
    GROUP BY CIUDAD_EMPLEADO
    UNION 
    SELECT CIUDAD_TIENDA FROM temporal 
    GROUP BY CIUDAD_TIENDA)
GROUP BY CIUDAD_CLIENTE
ORDER BY CIUDAD_CLIENTE ASC;




--Para PAIS
INSERT INTO pais(nombre)
SELECT PAIS_CLIENTE as PAIS FROM  
    (SELECT PAIS_CLIENTE FROM temporal 
    GROUP BY PAIS_CLIENTE
    UNION 
    SELECT PAIS_EMPLEADO FROM temporal 
    GROUP BY PAIS_EMPLEADO
    UNION 
    SELECT PAIS_TIENDA FROM temporal 
    GROUP BY PAIS_TIENDA)
GROUP BY PAIS_CLIENTE
ORDER BY PAIS_CLIENTE ASC;


--Para CLASIFICACION
INSERT INTO clasificacion(nombre)
SELECT CLASIFICACION FROM temporal 
GROUP BY CLASIFICACION;


--Para LENGUAJE_PELICULA
INSERT INTO lenguaje(nombre)
SELECT LENGUAJE_PELICULA FROM temporal 
GROUP BY LENGUAJE_PELICULA;


--Para CATEGORIA_PELICULA
INSERT INTO categoria(nombre)
SELECT CATEGORIA_PELICULA FROM temporal 
GROUP BY CATEGORIA_PELICULA;


--Para ACTOR_PELICULA
INSERT INTO actor(nombre)
SELECT ACTOR_PELICULA FROM temporal 
GROUP BY ACTOR_PELICULA;


--Para PELICULA
INSERT INTO pelicula(nombre, descripcion , lanzamiento , costo_renta , duracion , costo_dano)
SELECT NOMBRE_PELICULA,
DESCRIPCION_PELICULA,
ANO_LANZAMIENTO,
COSTO_RENTA,
DURACION,
COSTO_POR_DANO 
FROM temporal 
WHERE ANO_LANZAMIENTO !='-' and
COSTO_RENTA !='-' and
DURACION !='-' and
COSTO_POR_DANO !='-' 
GROUP BY NOMBRE_PELICULA,
DESCRIPCION_PELICULA,
ANO_LANZAMIENTO,
COSTO_RENTA,
DURACION,
COSTO_POR_DANO;

--INICIA LLENAR TABLAS INTERMEDIAS

--Para Pelicula_Clasificacion
INSERT INTO pelicula_clasificacion(pelicula_id_pelicula,clasificacion_id_clasificacion)
SELECT p.id_pelicula ,c.id_clasificacion 
FROM pelicula p , clasificacion c ,
    (SELECT NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO ,
    CLASIFICACION
    FROM temporal 
    WHERE ANO_LANZAMIENTO !='-' and
    COSTO_RENTA !='-' and
    DURACION !='-' and
    COSTO_POR_DANO !='-' and 
    CLASIFICACION !='-' 
    GROUP BY NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO,
    CLASIFICACION) t 
WHERE p.nombre=t.NOMBRE_PELICULA and
p.descripcion=t.DESCRIPCION_PELICULA and
p.lanzamiento=CAST(t.ANO_LANZAMIENTO AS integer) and
p.costo_renta=CAST(t.COSTO_RENTA AS integer) and
p.duracion=CAST(t.DURACION AS integer) and
p.costo_dano=CAST(t.COSTO_POR_DANO AS integer) and
c.nombre=t.CLASIFICACION 
GROUP BY p.id_pelicula ,c.id_clasificacion ;











--Para Pelicula_Lenguaje
INSERT INTO pelicula_lenguaje(pelicula_id_pelicula,lenguaje_id_lenguaje)
SELECT p.id_pelicula , l.id_lenguaje
FROM pelicula p , lenguaje l ,    
    (SELECT NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO ,
    LENGUAJE_PELICULA
    FROM temporal 
    WHERE ANO_LANZAMIENTO !='-' and
    COSTO_RENTA !='-' and
    DURACION !='-' and
    COSTO_POR_DANO !='-' and 
    LENGUAJE_PELICULA !='-' 
    GROUP BY NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO,
    LENGUAJE_PELICULA) t 
WHERE p.nombre=t.NOMBRE_PELICULA and
p.descripcion=t.DESCRIPCION_PELICULA and
p.lanzamiento=CAST(t.ANO_LANZAMIENTO as integer) and
p.costo_renta=CAST(t.COSTO_RENTA as integer) and
p.duracion=CAST(t.DURACION as integer) and
p.costo_dano=CAST(t.COSTO_POR_DANO as integer) and
l.nombre=t.LENGUAJE_PELICULA 
GROUP BY p.id_pelicula ,l.id_lenguaje ;





--Para Pelicula_Categoria
INSERT INTO pelicula_categoria(pelicula_id_pelicula , categoria_id_categoria)
SELECT p.id_pelicula , c.id_categoria
FROM pelicula p , categoria c ,
    (SELECT NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO ,
    CATEGORIA_PELICULA
    FROM temporal 
    WHERE ANO_LANZAMIENTO !='-' and
    COSTO_RENTA !='-' and
    DURACION !='-' and
    COSTO_POR_DANO !='-' and 
    CATEGORIA_PELICULA !='-' 
    GROUP BY NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO,
    CATEGORIA_PELICULA) t 
WHERE p.nombre=t.NOMBRE_PELICULA and
p.descripcion=t.DESCRIPCION_PELICULA and
p.lanzamiento=CAST( t.ANO_LANZAMIENTO AS integer) and
p.costo_renta=CAST( t.COSTO_RENTA AS integer) and
p.duracion=CAST( t.DURACION AS integer) and
p.costo_dano=CAST( t.COSTO_POR_DANO AS integer) and

c.nombre=t.CATEGORIA_PELICULA 
GROUP BY p.id_pelicula ,c.id_categoria ;





--Para Pelicula_Actor 
INSERT INTO pelicula_actor(pelicula_id_pelicula , actor_id_actor)
SELECT p.id_pelicula , a.id_actor
FROM pelicula p , actor a ,
    (SELECT NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO ,
    ACTOR_PELICULA
    FROM temporal 
    WHERE ANO_LANZAMIENTO !='-' and
    COSTO_RENTA !='-' and
    DURACION !='-' and
    COSTO_POR_DANO !='-' and 
    ACTOR_PELICULA !='-' 
    GROUP BY NOMBRE_PELICULA,
    DESCRIPCION_PELICULA,
    ANO_LANZAMIENTO,
    COSTO_RENTA,
    DURACION,
    COSTO_POR_DANO,
    ACTOR_PELICULA) t 
WHERE p.nombre=t.NOMBRE_PELICULA and
p.descripcion=t.DESCRIPCION_PELICULA and
p.lanzamiento=CAST( t.ANO_LANZAMIENTO AS integer) and
p.costo_renta=CAST( t.COSTO_RENTA AS integer) and
p.duracion=CAST( t.DURACION AS integer) and
p.costo_dano=CAST( t.COSTO_POR_DANO AS integer) and

a.nombre=t.ACTOR_PELICULA 
GROUP BY p.id_pelicula ,a.id_actor
ORDER BY a.id_actor ASC;





--Para Tienda
INSERT INTO tienda(nombre,encargado,direccion,codigo_postal,ciudad_id_ciudad,pais_id_pais)
SELECT t.NOMBRE_TIENDA , t.ENCARGADO_TIENDA , 
t.DIRECCION_TIENDA , t.CODIGO_POSTAL_TIENDA,
c.id_ciudad , p.id_pais
FROM 
    (SELECT NOMBRE_TIENDA , ENCARGADO_TIENDA ,
    DIRECCION_TIENDA , CODIGO_POSTAL_TIENDA ,
    CIUDAD_TIENDA , PAIS_TIENDA 
    FROM temporal 
    WHERE NOMBRE_TIENDA !='-' AND 
    ENCARGADO_TIENDA !='-' AND 
    DIRECCION_TIENDA !='-' AND 
    CIUDAD_TIENDA !='-' AND 
    PAIS_TIENDA !='-' 
    ) t ,
ciudad c ,pais p
WHERE t.CIUDAD_TIENDA=c.nombre and
t.PAIS_TIENDA=p.nombre 
GROUP BY t.NOMBRE_TIENDA , t.ENCARGADO_TIENDA , 
t.DIRECCION_TIENDA , t.CODIGO_POSTAL_TIENDA,
c.id_ciudad , p.id_pais;






--para Empleado
INSERT INTO empleado(nombre, correo, activo, usuario , contrasena, direccion,codigo,ciudad_id_ciudad,pais_id_pais,tienda_id_tienda)
SELECT t1.NOMBRE_EMPLEADO , t1.CORREO_EMPLEADO , t1.EMPLEADO_ACTIVO,
t1.USUARIO_EMPLEADO , t1.CONTRASENA_EMPLEADO , t1.DIRECCION_EMPLEADO,
t1.CODIGO_POSTAL_EMPLEADO , c.id_ciudad , p.id_pais ,t.id_tienda 
FROM 
    (SELECT NOMBRE_EMPLEADO , CORREO_EMPLEADO ,
    EMPLEADO_ACTIVO , USUARIO_EMPLEADO ,
    CONTRASENA_EMPLEADO , DIRECCION_EMPLEADO , CODIGO_POSTAL_EMPLEADO ,
    CIUDAD_EMPLEADO, PAIS_EMPLEADO ,TIENDA_EMPLEADO
    FROM temporal 
    WHERE NOMBRE_EMPLEADO !='-' AND 
    CORREO_EMPLEADO !='-' AND 
    EMPLEADO_ACTIVO !='-' AND 
    USUARIO_EMPLEADO !='-' AND 
    CONTRASENA_EMPLEADO !='-' AND 
    DIRECCION_EMPLEADO !='-' AND 
    --CODIGO_POSTAL_EMPLEADO !='-' AND
    CIUDAD_EMPLEADO !='-' AND  
    PAIS_EMPLEADO !='-' AND  
    TIENDA_EMPLEADO !='-' 
    ) t1 ,
ciudad c , pais p , tienda t 
WHERE t1.CIUDAD_EMPLEADO=c.nombre and
t1.PAIS_EMPLEADO=p.nombre and
t1.TIENDA_EMPLEADO=t.nombre 
GROUP BY t1.NOMBRE_EMPLEADO , t1.CORREO_EMPLEADO , t1.EMPLEADO_ACTIVO,
t1.USUARIO_EMPLEADO , t1.CONTRASENA_EMPLEADO , t1.DIRECCION_EMPLEADO,
t1.CODIGO_POSTAL_EMPLEADO , c.id_ciudad , p.id_pais ,t.id_tienda ;




--Para Cliente 
INSERT INTO cliente(nombre, correo, activo , fecha_creacion, direccion, codigo_postal,id_tienda_preferida,ciudad_id_ciudad,pais_id_pais)
SELECT t1.NOMBRE_CLIENTE , t1.CORREO_CLIENTE , t1.CLIENTE_ACTIVO, t1.FECHA_CREACION,
t1.DIRECCION_CLIENTE , t1.CODIGO_POSTAL_CLIENTE ,
t.id_tienda , c.id_ciudad , p.id_pais
FROM 
    (SELECT NOMBRE_CLIENTE , CORREO_CLIENTE ,
    CLIENTE_ACTIVO , FECHA_CREACION  ,
    DIRECCION_CLIENTE , CODIGO_POSTAL_CLIENTE , TIENDA_PREFERIDA ,
    CIUDAD_CLIENTE, PAIS_CLIENTE 
    FROM temporal 
    WHERE NOMBRE_CLIENTE !='-' AND 
    CORREO_CLIENTE !='-' AND 
    CLIENTE_ACTIVO !='-' AND 
    FECHA_CREACION !='-' AND 
    DIRECCION_CLIENTE !='-' AND 
    --CODIGO_POSTAL_CLIENTE !='-' AND
    TIENDA_PREFERIDA !='-' AND  
    CIUDAD_CLIENTE !='-' AND  
    PAIS_CLIENTE !='-' 
    )t1, 
tienda t , ciudad c , pais p 
WHERE t1.TIENDA_PREFERIDA=t.nombre and
t1.CIUDAD_CLIENTE=c.nombre and
t1.PAIS_CLIENTE=p.nombre
GROUP BY t1.NOMBRE_CLIENTE , t1.CORREO_CLIENTE , t1.CLIENTE_ACTIVO, t1.FECHA_CREACION,
t1.DIRECCION_CLIENTE , t1.CODIGO_POSTAL_CLIENTE ,
t.id_tienda , c.id_ciudad , p.id_pais;




--Para Cliente_Tienda
INSERT INTO cliente_tienda(cliente_id_cliente,tienda_id_tienda)
SELECT c.id_cliente , t.id_tienda 
FROM cliente c , tienda t , 
    (SELECT TIENDA_PREFERIDA,NOMBRE_CLIENTE
    FROM temporal
    WHERE TIENDA_PREFERIDA!='-' and
    NOMBRE_CLIENTE !='-'
    ) t1
WHERE  t1.TIENDA_PREFERIDA=t.nombre and
t1.NOMBRE_CLIENTE=c.nombre 
GROUP BY c.id_cliente , t.id_tienda ;



--Para Tienda_Pelicula
INSERT INTO tienda_pelicula(tienda_id_tienda , pelicula_id_pelicula)
SELECT t.id_tienda , p.id_pelicula 
FROM tienda t , pelicula p , 
    (SELECT TIENDA_PELICULA,NOMBRE_PELICULA
    FROM temporal
    WHERE TIENDA_PELICULA!='-' and
    NOMBRE_PELICULA !='-'
    ) t1
WHERE t1.TIENDA_PELICULA=t.nombre and
t1.NOMBRE_PELICULA=p.nombre 
GROUP BY t.id_tienda , p.id_pelicula  ;





--Para prestamo
INSERT INTO prestamo(fecha_renta , fecha_retorno , monto_pagar , fecha_pago , dias_renta , empleado_id_empleado , pelicula_id_pelicula , cliente_id_cliente)
SELECT TO_DATE(t1.FECHA_RENTA ,'DD/MM/YYYY HH24:MI') as FECHA_RENTA,
TO_DATE(t1.FECHA_RETORNO ,'DD/MM/YYYY HH24:MI') as FECHA_RETORNO ,
t1.MONTO_A_PAGAR ,
TO_DATE(t1.FECHA_PAGO ,'DD/MM/YYYY HH24:MI') as FECHA_PAGO,
t1.DIAS_RENTA ,
e.id_empleado , p.id_pelicula , c.id_cliente
FROM empleado e , pelicula p , cliente c , 
    (SELECT FECHA_RENTA,FECHA_RETORNO,MONTO_A_PAGAR,FECHA_PAGO,DIAS_RENTA,NOMBRE_EMPLEADO,NOMBRE_PELICULA,NOMBRE_CLIENTE
    FROM temporal 
    WHERE FECHA_RENTA!='-' and
    FECHA_RETORNO!='-' and
    MONTO_A_PAGAR!='-' and
    FECHA_PAGO!='-' and
    DIAS_RENTA!='-' and
    NOMBRE_EMPLEADO!='-' and
    NOMBRE_PELICULA!='-' and
    NOMBRE_CLIENTE!='-' 
    ) t1
WHERE  t1.NOMBRE_EMPLEADO=e.nombre and
t1.NOMBRE_PELICULA=p.nombre and
t1.NOMBRE_CLIENTE=c.nombre
GROUP BY t1.FECHA_RENTA , t1.FECHA_RETORNO ,
t1.MONTO_A_PAGAR ,t1.FECHA_PAGO ,t1.DIAS_RENTA ,
e.id_empleado , p.id_pelicula , c.id_cliente; 



--para prstamo fecha nula


INSERT INTO prestamo(fecha_renta , monto_pagar , fecha_pago , dias_renta , empleado_id_empleado , pelicula_id_pelicula , cliente_id_cliente)
SELECT TO_DATE(t1.FECHA_RENTA ,'DD/MM/YYYY HH24:MI') as FECHA_RENTA,
t1.MONTO_A_PAGAR ,
TO_DATE(t1.FECHA_PAGO ,'DD/MM/YYYY HH24:MI') as FECHA_PAGO,
t1.DIAS_RENTA ,
e.id_empleado , p.id_pelicula , c.id_cliente
FROM empleado e , pelicula p , cliente c , 
    (SELECT FECHA_RENTA, FECHA_RETORNO , MONTO_A_PAGAR,FECHA_PAGO,DIAS_RENTA,NOMBRE_EMPLEADO,NOMBRE_PELICULA,NOMBRE_CLIENTE
    FROM temporal 
    WHERE FECHA_RENTA!='-' and
    FECHA_RETORNO='-' and
    MONTO_A_PAGAR!='-' and
    FECHA_PAGO!='-' and
    DIAS_RENTA!='-' and
    NOMBRE_EMPLEADO!='-' and
    NOMBRE_PELICULA!='-' and
    NOMBRE_CLIENTE!='-' 
    ) t1
WHERE  t1.NOMBRE_EMPLEADO=e.nombre and
t1.NOMBRE_PELICULA=p.nombre and
t1.NOMBRE_CLIENTE=c.nombre
GROUP BY t1.FECHA_RENTA  , 
t1.MONTO_A_PAGAR ,t1.FECHA_PAGO ,t1.DIAS_RENTA ,
e.id_empleado , p.id_pelicula , c.id_cliente; 





--EMPIEZAN LAS CONSULTAS 

--CONSULTA 1

SELECT p.nombre , count(*) AS CANTIDAD
FROM pelicula p , tienda_pelicula tp
WHERE regexp_like(p.nombre,'SUGAR WONKA') AND
p.id_pelicula=tp.pelicula_id_pelicula
GROUP BY p.nombre;


--CONSULTA 2

SELECT c.nombre , p.SUMA ,p.TOTAL
FROM cliente c ,
    (SELECT p.cliente_id_cliente , SUM(p.monto_pagar) AS SUMA , COUNT(*) AS TOTAL
    FROM prestamo p 
    GROUP BY p.cliente_id_cliente) p
WHERE c.id_cliente=p.cliente_id_cliente AND
p.TOTAL>=40
;

--consulta 3
--insertar retorno nulo y preguntar lo otro que no se entiende

SELECT c.nombre as cliente , p.nombre as pelicula
FROM cliente c , pelicula p , prestamo pr
WHERE c.id_cliente=pr.cliente_id_cliente AND
pr.pelicula_id_pelicula=p.id_pelicula AND
pr.fecha_retorno is null;

--CONSULTA 4 , solo una columna
SELECT nombre || apellido as NOMBRE
FROM
(SELECT SUBSTR(nombre,0,INSTR(nombre,' ')) AS nombre ,
SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido
FROM actor)
WHERE REGEXP_LIKE(apellido ,'son')
ORDER BY nombre ASC;


--CONSULTA 5
SELECT a.apellido , a.total 
FROM 
    (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')-1) AS nombre ,
    SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido 
    FROM actor) c ,

    (SELECT apellido , COUNT(*) AS total
    FROM
    (SELECT SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido 
    FROM actor)
    GROUP BY apellido) a ,
    
    (SELECT nombre,total
    FROM
        (SELECT nombre , COUNT(*) AS total
        FROM
        (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')-1) AS nombre 
        FROM actor)
        GROUP BY nombre)
    WHERE total>=2) n 
WHERE n.nombre=c.nombre AND
a.apellido=c.apellido
GROUP BY a.apellido, a.total;



--CONSULTA 6

SELECT d.nombre , d.apellido , d.lanzamiento
FROM
(SELECT SUBSTR(nombre,0,INSTR(s.nombre,' ')-1) as nombre ,
SUBSTR(nombre,INSTR(s.nombre,' ')+1) as apellido,
s.lanzamiento
FROM
(SELECT a.nombre , p.lanzamiento
FROM
(SELECT id_pelicula , lanzamiento 
FROM pelicula
WHERE REGEXP_LIKE(descripcion,'Crocodile') AND
REGEXP_LIKE(descripcion,'Shark')) p,
actor a ,pelicula_actor pa
WHERE p.id_pelicula=pa.pelicula_id_pelicula AND
pa.actor_id_actor=a.id_actor
GROUP BY a.nombre, p.lanzamiento
ORDER BY a.nombre ASC) s) d
ORDER BY d.apellido ASC;


--CONSULTA 7
SELECT nombre , total
FROM
(SELECT c.nombre , COUNT(*) AS TOTAL
FROM categoria c ,pelicula_categoria pc
WHERE c.id_categoria=pc.categoria_id_categoria
GROUP BY  c.nombre)
WHERE total>=55 AND total<=65
ORDER BY total DESC;



--CONSULTA 8
SELECT nombre, promedio
FROM
(SELECT c.nombre , AVG(p.diferencia) AS promedio
FROM categoria c , pelicula_categoria pc ,
(SELECT id_pelicula , (costo_dano-costo_renta) AS diferencia
FROM pelicula) p 
WHERE p.id_pelicula =pc.pelicula_id_pelicula AND
c.id_categoria=pc.categoria_id_categoria
GROUP BY c.nombre)
WHERE promedio>17;


--CONSULTA 9
SELECT p.nombre , a.nombre , a.total
FROM pelicula p , pelicula_actor pa ,
(SELECT a.id_actor , a.nombre , COUNT(*) AS total
FROM actor a , pelicula_actor pa
WHERE a.id_actor=pa.actor_id_actor
GROUP BY  a.id_actor , a.nombre) a 
WHERE p.id_pelicula=pa.pelicula_id_pelicula AND
pa.actor_id_actor=a.id_actor AND
a.total>=2;


--CONSULTA 10
(SELECT a.nombre || a.apellido AS NOMBRE
FROM 
    (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')) AS nombre ,
    SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido
    FROM actor
    WHERE id_actor!=8) a,
    (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')) AS nombre ,
    SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido
    FROM actor
    WHERE id_actor=8) o
WHERE a.nombre=o.nombre)
UNION
(SELECT c.nombre || c.apellido
FROM
    (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')) AS nombre,
    SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido
    FROM cliente) c,
    (SELECT SUBSTR(nombre,0,INSTR(nombre,' ')) AS nombre ,
    SUBSTR(nombre,INSTR(nombre,' ')+1) AS apellido
    FROM actor
    WHERE id_actor=8) a
WHERE c.nombre=a.nombre);

--CONSULTA 11

--CONSULTA HECHA SOBRE CLIENTE_PAIS
SELECT y.nombre,y.u_global ,y.u_record ,p.nombre as pais , y.porcentaje
FROM pais p ,
(SELECT i.nombre  , t.total AS U_GLOBAL, i.total AS U_RECORD ,i.pais_id_pais AS pais , (i.total/t.total)*100 AS PORCENTAJE
FROM

(SELECT c.nombre ,c.pais_id_pais ,p.total
FROM cliente c ,
(SELECT cliente , total
FROM 
(SELECT cliente_id_cliente as cliente , COUNT(*) as total
FROM prestamo 
GROUP BY  cliente_id_cliente)
ORDER BY total DESC
FETCH FIRST 1 ROWS ONLY) p
WHERE c.id_cliente=p.cliente) i ,

(SELECT SUM(f.total) as TOTAL
FROM
(SELECT u.id_cliente ,u.pais_id_pais , count(*) as total 
FROM prestamo p , 
(SELECT c.id_cliente ,c.pais_id_pais
FROM cliente c ,
(SELECT c.nombre ,c.pais_id_pais ,p.total
FROM cliente c ,
(SELECT cliente , total
FROM 
(SELECT cliente_id_cliente as cliente , COUNT(*) as total
FROM prestamo 
GROUP BY  cliente_id_cliente)
ORDER BY total DESC
FETCH FIRST 1 ROWS ONLY) p
WHERE c.id_cliente=p.cliente) p
WHERE p.pais_id_pais=c.pais_id_pais) u

WHERE u.id_cliente=p.cliente_id_cliente
GROUP BY u.id_cliente ,u.pais_id_pais) f) t ) y
WHERE p.id_pais = y.pais;


--CONSULTA HECHA SOBRE TIENDA_PAIS





--consulta 12



--consulta 13
SELECT f.nombre , p.nombre as pais, f.total
FROM pais p ,
(SELECT cm.nombre ,cm.pais ,cm.total
FROM
(SELECT o.pais , o.total 
FROM
(SELECT t.pais , MAX(t.total) as total
FROM
(SELECT c.nombre ,c.pais_id_pais as pais ,p.total
FROM cliente c ,
(SELECT cliente_id_cliente as cliente , count(*) as total
FROM prestamo 
GROUP BY cliente_id_cliente) p
WHERE p.cliente=c.id_cliente
ORDER BY c.pais_id_pais DESC) t
GROUP BY t.pais) o
ORDER BY o.pais) pm ,

(SELECT  c.nombre ,c.pais_id_pais as pais ,p.total
FROM cliente c ,
(SELECT cliente_id_cliente as cliente , count(*) as total
FROM prestamo 
GROUP BY cliente_id_cliente) p
WHERE p.cliente=c.id_cliente) cm

WHERE pm.pais = cm.pais AND
pm.total=cm.total) f
WHERE f.pais=p.id_pais
ORDER BY f.pais ASC;



--CONSULTA 14

--usa TIENDA_PAIS
SELECT f.pais , f.ciudad , f.categoria
FROM
(SELECT p.nombre as pais , c.nombre as ciudad ,ct.nombre as categoria
FROM pais p , ciudad c , categoria ct,
(SELECT p1.pais , p1.ciudad , p1.categoria 
FROM
(SELECT p.pais , p.ciudad  , p.categoria , COUNT(*) as total
FROM
(SELECT  t.pais_id_pais as pais ,t.ciudad_id_ciudad as ciudad , p.pelicula_id_pelicula as pelicula , pc.categoria_id_categoria as categoria
FROM tienda t , empleado e , prestamo p , pelicula_categoria pc
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) p 
GROUP BY  p.pais , p.ciudad , p.categoria) p1,
(SELECT s.pais , s.ciudad ,MAX(s.total) as maxi
FROM
(SELECT p.pais , p.ciudad  , p.categoria , COUNT(*) as total
FROM
(SELECT  t.pais_id_pais as pais ,t.ciudad_id_ciudad as ciudad , p.pelicula_id_pelicula as pelicula , pc.categoria_id_categoria as categoria
FROM tienda t , empleado e , prestamo p , pelicula_categoria pc
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) p 
GROUP BY  p.pais , p.ciudad , p.categoria) s
GROUP BY s.pais , s.ciudad) p2

WHERE p1.ciudad=p2.ciudad AND
p1.pais=p2.pais AND
p1.total=p2.maxi) p1
WHERE p1.pais=p.id_pais AND
p1.ciudad=c.id_ciudad AND
p1.categoria=ct.id_categoria) f
WHERE REGEXP_LIKE(f.categoria , 'Horror');




--CLIENTE_PAIS

SELECT p.nombre as pais , c.nombre AS ciudad , ct.nombre AS categoria
FROM pais p, ciudad c , categoria ct , 
(SELECT p1.pais , p1.ciudad , p1.categoria 
FROM
(SELECT s.pais , s.ciudad ,s.categoria ,COUNT(*) as total
FROM
(SELECT p.pais , p.ciudad , c.categoria_id_categoria as categoria
FROM pelicula_categoria c ,
(SELECT p.pelicula_id_pelicula as pelicula , c.ciudad_id_ciudad as ciudad , c.pais_id_pais as pais 
FROM prestamo p  , cliente c 
WHERE p.cliente_id_cliente=c.id_cliente) p
WHERE p.pelicula =c.pelicula_id_pelicula) s
GROUP BY s.pais , s.ciudad ,s.categoria) p1,

(SELECT p.pais , p.ciudad ,MAX(p.total) as max
FROM
(SELECT s.pais , s.ciudad ,s.categoria ,COUNT(*) as total
FROM
(SELECT p.pais , p.ciudad , c.categoria_id_categoria as categoria
FROM pelicula_categoria c ,
(SELECT p.pelicula_id_pelicula as pelicula , c.ciudad_id_ciudad as ciudad , c.pais_id_pais as pais 
FROM prestamo p  , cliente c 
WHERE p.cliente_id_cliente=c.id_cliente) p
WHERE p.pelicula =c.pelicula_id_pelicula) s
GROUP BY s.pais , s.ciudad ,s.categoria) p 
GROUP BY p.pais ,p.ciudad) p2 ,
(SELECT c.id_categoria FROM categoria c WHERE REGEXP_LIKE(c.nombre,'Horror')) s
WHERE p1.pais=p2.pais AND
p1.ciudad=p2.ciudad AND
p1.total=p2.max AND
p1.categoria=s.id_categoria) o 
WHERE o.ciudad=c.id_ciudad AND
o.pais=p.id_pais AND
o.categoria=ct.id_categoria;



--consulta 15
--no esta clara , promedio del pais o promedio dde las ciudades

--TIENDA_CIUDAD
SELECT p.nombre as pais , c.nombre as ciudad , f.total as total_ciudad , f.promedio_pais
FROM pais p , ciudad c ,
(SELECT p1.pais , p1.ciudad ,p1.total , p2.promedio as promedio_pais
FROM
(SELECT p.pais ,p.ciudad ,COUNT(*) AS total
FROM 
(SELECT t.pais_id_pais as pais , t.ciudad_id_ciudad as ciudad
FROM tienda t , empleado e , prestamo p 
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado) p
GROUP BY p.pais , p.ciudad) p1 ,
(SELECT p.pais ,(SUM(p.total)/COUNT(*)) AS promedio
FROM 
(SELECT p.pais ,p.ciudad ,COUNT(*) AS total
FROM 
(SELECT t.pais_id_pais as pais , t.ciudad_id_ciudad as ciudad
FROM tienda t , empleado e , prestamo p 
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado) p
GROUP BY p.pais , p.ciudad) p
GROUP BY p.pais ) p2
WHERE p1.pais=p2.pais) f
WHERE p.id_pais=f.pais AND
c.id_ciudad=f.ciudad;


--CLIENTE_CIUDAD
SELECT p.nombre as pais , c.nombre as ciudad , f.total as total_ciudad , f.promedio_pais
FROM pais p , ciudad c ,
(SELECT p1.pais , p1.ciudad ,p1.total , p2.promedio as promedio_pais
FROM
(SELECT p.pais ,p.ciudad ,COUNT(*) AS total
FROM 
(SELECT c.pais_id_pais as pais , c.ciudad_id_ciudad as ciudad
FROM cliente c , prestamo p 
WHERE c.id_cliente=p.cliente_id_cliente) p
GROUP BY p.pais , p.ciudad) p1 ,
(SELECT p.pais ,(SUM(p.total)/COUNT(*)) AS promedio
FROM 
(SELECT p.pais ,p.ciudad ,COUNT(*) AS total
FROM 
(SELECT c.pais_id_pais as pais , c.ciudad_id_ciudad as ciudad
FROM cliente c , prestamo p 
WHERE c.id_cliente=p.cliente_id_cliente) p
GROUP BY p.pais , p.ciudad) p
GROUP BY p.pais ) p2
WHERE p1.pais=p2.pais) f
WHERE p.id_pais=f.pais AND
c.id_ciudad=f.ciudad;




--cosulta 16
--relacion al pais o global?
--PAIS_TIENDA
SELECT f.pais , f.categoria , f.porcentaje
FROM 
(SELECT p.nombre as pais , c.nombre as categoria , o.porcentaje
FROM pais p , categoria c ,
(SELECT pc.pais , pc.categoria , ((pc.total/pt.total)*100) AS porcentaje
FROM
--muestra pais , categoria y el togal 
(SELECT pc.pais, pc.categoria ,COUNT(*) AS total
FROM
(SELECT t.pais_id_pais as pais ,pc.categoria_id_categoria as categoria
FROM tienda t , empleado e , prestamo p , pelicula_categoria pc
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) pc
GROUP BY pc.pais, pc.categoria
ORDER BY pc.pais, pc.categoria) pc ,
(--muestra la suma total del pais para todas las cataegorias
SELECT pt.pais , SUM(pt.total) as total
FROM
(SELECT pc.pais, pc.categoria ,COUNT(*) AS total
FROM
(SELECT t.pais_id_pais as pais ,pc.categoria_id_categoria as categoria
FROM tienda t , empleado e , prestamo p , pelicula_categoria pc
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) pc
GROUP BY pc.pais, pc.categoria
ORDER BY pc.pais, pc.categoria) pt
GROUP BY pt.pais ) pt
WHERE pc.pais=pt.pais) o
WHERE o.pais=p.id_pais AND
o.categoria=c.id_categoria) f
WHERE REGEXP_LIKE(f.categoria,'Sports');




--PAIS_CLIENTE
SELECT f.pais , f.categoria , f.porcentaje
FROM 
(SELECT p.nombre as pais , c.nombre as categoria , o.porcentaje
FROM pais p , categoria c ,
(SELECT pc.pais , pc.categoria , ((pc.total/pt.total)*100) AS porcentaje
FROM
--muestra pais , categoria y el total 
(SELECT pc.pais, pc.categoria ,COUNT(*) AS total
FROM
(SELECT c.pais_id_pais as pais ,pc.categoria_id_categoria as categoria
FROM cliente c , prestamo p , pelicula_categoria pc
WHERE c.id_cliente=p.cliente_id_cliente AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) pc
GROUP BY pc.pais, pc.categoria
ORDER BY pc.pais, pc.categoria) pc ,
(--muestra la suma total del pais para todas las cataegorias
SELECT pt.pais , SUM(pt.total) as total
FROM
(SELECT pc.pais, pc.categoria ,COUNT(*) AS total
FROM
(SELECT c.pais_id_pais as pais ,pc.categoria_id_categoria as categoria
FROM cliente c , prestamo p , pelicula_categoria pc
WHERE c.id_cliente=p.cliente_id_cliente AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula) pc
GROUP BY pc.pais, pc.categoria
ORDER BY pc.pais, pc.categoria) pt
GROUP BY pt.pais ) pt
WHERE pc.pais=pt.pais) o
WHERE o.pais=p.id_pais AND
o.categoria=c.id_categoria) f
WHERE REGEXP_LIKE(f.categoria,'Sports');






--CONSULTA 17
--solo canada y australia
--los datos de estadosunidos estan incompletos 
--no hay informacion solo ciudad y pais 



--CIUDAD_TEINDA

SELECT c.nombre as ciudad , p.nombre as pais , r.total
FROM ciudad c , pais p , 
(SELECT d.ciudad , d.pais , d.total 
FROM
(SELECT p.ciudad , p.pais ,COUNT(*) as total
FROM
(SELECT t.ciudad_id_ciudad as ciudad , t.pais_id_pais as pais
FROM  tienda t , empleado e , prestamo p ,
(SELECT id_pais 
FROM pais 
WHERE REGEXP_like(nombre,'United States')) u
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
t.pais_id_pais=u.id_pais) p
GROUP BY  p.ciudad , p.pais ) d,

(SELECT r.ciudad , r.pais , r.total
FROM
(SELECT id_ciudad
FROM ciudad
WHERE REGEXP_like(nombre,'Dayton')) s ,
(SELECT p.ciudad , p.pais ,COUNT(*) as total
FROM
(SELECT t.ciudad_id_ciudad as ciudad , t.pais_id_pais as pais
FROM  tienda t , empleado e , prestamo p ,
(SELECT id_pais 
FROM pais 
WHERE REGEXP_like(nombre,'United States')) u
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
t.pais_id_pais=u.id_pais) p
GROUP BY  p.ciudad , p.pais ) r
WHERE r.ciudad=s.id_ciudad) r
WHERE d.total>=r.total) r  
WHERE c.id_ciudad=r.ciudad AND
p.id_pais=r.pais ;



--CIUDAD_CLIENTE

SELECT c.nombre as ciudad , p.nombre as pais , r.total
FROM ciudad c , pais p , 
(SELECT d.ciudad , d.pais , d.total 
FROM
(SELECT p.ciudad , p.pais ,COUNT(*) as total
FROM
(SELECT c.ciudad_id_ciudad as ciudad , c.pais_id_pais as pais
FROM  cliente c , prestamo p ,
(SELECT id_pais 
FROM pais 
WHERE REGEXP_like(nombre,'United States')) u
WHERE c.id_cliente=p.cliente_id_cliente AND
c.pais_id_pais=u.id_pais) p
GROUP BY  p.ciudad , p.pais ) d,
(SELECT r.ciudad , r.pais , r.total
FROM
(SELECT id_ciudad
FROM ciudad
WHERE REGEXP_like(nombre,'Dayton')) s ,
(SELECT p.ciudad , p.pais ,COUNT(*) as total
FROM
(SELECT c.ciudad_id_ciudad as ciudad , c.pais_id_pais as pais
FROM  cliente c , prestamo p ,
(SELECT id_pais 
FROM pais 
WHERE REGEXP_like(nombre,'United States')) u
WHERE c.id_cliente=p.cliente_id_cliente AND
c.pais_id_pais=u.id_pais) p
GROUP BY  p.ciudad , p.pais ) r
WHERE r.ciudad=s.id_ciudad) r
WHERE d.total>=r.total) r 
WHERE c.id_ciudad=r.ciudad AND
p.id_pais=r.pais ;




--consulta 18 
--para las ventas que hizo en el dia , seria solo las de ingles o general

SELECT c.nombre as cliente , e.nombre as empleado , f.fecha_renta ,f.fecha_retorno 
FROM cliente c , empleado e , 
(SELECT p1.cliente , p1.empleado , p1.fecha_retorno , p1.fecha_renta
FROM
(SELECT p1.cliente , p1.empleado , p1.fecha_retorno ,p1.fecha_renta
FROM
--retorna cliente fecha retorno y lenguaje que sea solo ingles 
(SELECT p.cliente_id_cliente as cliente , p.fecha_retorno , 
EXTRACT(DAY FROM p.fecha_renta) || '/' || EXTRACT(MONTH FROM p.fecha_renta) || '/' || EXTRACT(YEAR FROM p.fecha_renta) AS fecha_renta 
, l.nombre as Lenguaje
, p.empleado_id_empleado as empleado
FROM prestamo p ,  pelicula_lenguaje pl ,lenguaje l
WHERE p.pelicula_id_pelicula = pl.pelicula_id_pelicula AND
pl.lenguaje_id_lenguaje=l.id_lenguaje AND
REGEXP_LIKE(l.nombre,'English')) p1  ,
--retorna clientes que han rentado mas de 2 peliculas en ingles
(SELECT t.cliente , t.lenguaje , t.total 
FROM 
(SELECT m.cliente , m.lenguaje ,COUNT(*) as total 
FROM
(SELECT p.cliente_id_cliente as cliente , p.fecha_retorno , l.nombre as Lenguaje
FROM prestamo p ,  pelicula_lenguaje pl ,lenguaje l
WHERE p.pelicula_id_pelicula = pl.pelicula_id_pelicula AND
pl.lenguaje_id_lenguaje=l.id_lenguaje AND
REGEXP_LIKE(l.nombre,'English')) m 
GROUP BY m.cliente , m.lenguaje) t
WHERE t.total>2) c2 

WHERE P1.cliente=c2.cliente ) p1 ,
--calcula las fchas en las que el empleado gano mas de 15dolares
(SELECT f.empleado , f.fecha_renta , f.gano
FROM
(SELECT e.empleado , e.fecha_renta ,SUM(e.monto_pagar) as GANO
FROM 
(SElECT p.empleado_id_empleado as empleado , 
EXTRACT(DAY FROM p.fecha_retorno) || '/' || EXTRACT(MONTH FROM p.fecha_retorno) || '/' || EXTRACT(YEAR FROM p.fecha_retorno) AS fecha_renta ,
p.fecha_retorno ,
p.monto_pagar 
FROM prestamo p) e 
GROUP BY e.empleado , e.fecha_renta) f
WHERE f.gano>15 ) p2

WHERE p1.empleado=p2.empleado AND
p1.fecha_renta=p2.fecha_renta) f 
WHERE f.cliente=c.id_cliente AND
f.empleado=e.id_empleado 
ORDER BY f.fecha_retorno desc;





--consulta 19
--cuantos muestra de lso que mas hay rentado y los que menos han rentado
--como asi que en 1 sola consulta

SELECT p.mes , p.nombre , s.total
FROM 
(SELECT p.mes , p.nombre
FROM
(SELECT EXTRACT(MONTH FROM p.fecha_renta) as MES , c.nombre 
FROM prestamo p , cliente c 
WHERE p.cliente_id_cliente=c.id_cliente
ORDER BY c.nombre) p
GROUP BY p.mes , p.nombre) p ,

(SELECT d.nombre , d.total 
FROM
((SELECT p.nombre , p.total 
FROM
(SELECT o.nombre , o.total
FROM
(SELECT c.nombre , COUNT(*) as total
FROM
(SELECT EXTRACT(MONTH FROM p.fecha_renta) as MES , c.nombre 
FROM prestamo p , cliente c 
WHERE p.cliente_id_cliente=c.id_cliente
ORDER BY c.nombre) c
GROUP BY  c.nombre) o
ORDER BY o.total DESC) p
WHERE p.total>0
FETCH FIRST 10 ROWS ONLY )
UNION
(SELECT o.nombre , o.total
FROM
(SELECT c.nombre , COUNT(*) as total
FROM
(SELECT EXTRACT(MONTH FROM p.fecha_renta) as MES , c.nombre 
FROM prestamo p , cliente c 
WHERE p.cliente_id_cliente=c.id_cliente
ORDER BY c.nombre) c
GROUP BY  c.nombre) o
ORDER BY o.total ASC
FETCH FIRST 10 ROWS ONLY)) d
ORDER BY d.total DESC) s
WHERE p.nombre=s.nombre;



--consulta 20
--union consulta 



SELECT c.nombre as ciudad , l.nombre as lenguaje  , r.porcentaje
FROM ciudad c , lenguaje l ,
(SELECT p.ciudad , p.lenguaje , ((p.total/d.total)*100) as porcentaje
FROM
--entrega la ciudad  y todos los lenguajes de la ciudad y sus count
(SELECT p.ciudad , p.lenguaje ,COUNT(*) as total
FROM
(SELECT t.ciudad_id_ciudad  as ciudad , pc.lenguaje_id_lenguaje as lenguaje
FROM tienda t , empleado e , prestamo p , pelicula_lenguaje pc 
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula AND
EXTRACT(MONTH FROM p.fecha_renta) = 7 AND
EXTRACT(YEAR FROM p.fecha_renta) = 2005) p 
GROUP BY  p.ciudad , p.lenguaje ) p ,
--entrega el total suma de todos los lenguajes de la ciudad
(SELECT p.ciudad , COUNT(*) as total
FROM
(SELECT t.ciudad_id_ciudad  as ciudad , pc.lenguaje_id_lenguaje as lenguaje
FROM tienda t , empleado e , prestamo p , pelicula_lenguaje pc 
WHERE t.id_tienda=e.tienda_id_tienda AND
e.id_empleado=p.empleado_id_empleado AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula AND
EXTRACT(MONTH FROM p.fecha_renta) = 7 AND
EXTRACT(YEAR FROM p.fecha_renta) = 2005) p 
GROUP BY  p.ciudad  ) d
WHERE p.ciudad=d.ciudad) r 
WHERE c.id_ciudad=r.ciudad AND
l.id_lenguaje=r.lenguaje;







--CIUDAD_CLIENTE
SELECT c.nombre as ciudad , l.nombre as lenguaje  , r.porcentaje
FROM ciudad c , lenguaje l ,
(SELECT p.ciudad , p.lenguaje , ((p.total/d.total)*100) as porcentaje
FROM
--entrega la ciudad  y todos los lenguajes de la ciudad y sus count
(SELECT p.ciudad , p.lenguaje ,COUNT(*) as total
FROM
(SELECT c.ciudad_id_ciudad  as ciudad , pc.lenguaje_id_lenguaje as lenguaje
FROM cliente c , prestamo p , pelicula_lenguaje pc 
WHERE c.id_cliente=p.cliente_id_cliente AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula AND
EXTRACT(MONTH FROM p.fecha_renta) = 7 AND
EXTRACT(YEAR FROM p.fecha_renta) = 2005) p 
GROUP BY  p.ciudad , p.lenguaje ) p ,
--entrega el total suma de todos los lenguajes de la ciudad
(SELECT p.ciudad , COUNT(*) as total
FROM
(SELECT c.ciudad_id_ciudad  as ciudad , pc.lenguaje_id_lenguaje as lenguaje
FROM cliente c , prestamo p , pelicula_lenguaje pc 
WHERE c.id_cliente=p.cliente_id_cliente AND
p.pelicula_id_pelicula=pc.pelicula_id_pelicula AND
EXTRACT(MONTH FROM p.fecha_renta) = 7 AND
EXTRACT(YEAR FROM p.fecha_renta) = 2005) p 
GROUP BY  p.ciudad  ) d
WHERE p.ciudad=d.ciudad) r 
WHERE c.id_ciudad=r.ciudad AND
l.id_lenguaje=r.lenguaje;











SELECT COUNT(*) as total FROM pelicula_clasificacion ;
SELECT COUNT(*) as total FROM pelicula_lenguaje ;
SELECT COUNT(*) as total FROM pelicula_categoria ;
SELECT COUNT(*) as total FROM pelicula_actor;
SELECT COUNT(*) as total FROM tienda_pelicula ;
SELECT COUNT(*) as total FROM cliente_tienda ;
SELECT COUNT(*) as total FROM prestamo ;
SELECT COUNT(*) as total FROM cliente ;
SELECT COUNT(*) as total FROM empleado ;
SELECT COUNT(*) as total FROM tienda ;
SELECT COUNT(*) as total FROM ciudad ;
SELECT COUNT(*) as total FROM pais ;
SELECT COUNT(*) as total FROM pelicula ;
SELECT COUNT(*) as total FROM actor ;
SELECT COUNT(*) as total FROM categoria ;
SELECT COUNT(*) as total FROM lenguaje ;
SELECT COUNT(*) as total FROM clasificacion ;

SELECT COUNT(*) as total FROM temporal ;

--introducir fechas de retorno vacias
--VERIFICAR ORDEN DE LAS COLUMNAS DE LAS TABLAS PARA QU EFUNCIONES  


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




