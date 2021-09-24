
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

--CONSULTA 3
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






--CONSULTA 15
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




--CONSULTA 16
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




--CONSULTA 18 
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





--CONSULTA 19
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



--CONSULTA 20
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














