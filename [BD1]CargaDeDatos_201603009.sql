


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