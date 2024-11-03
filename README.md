#TIENDA

-- Lista el nombre de todos los productos
SELECT nombre FROM producto;

-- Lista los nombres y los precios de todos los productos
SELECT nombre, precio FROM producto;

-- Lista todas las columnas de la tabla producto
SELECT * FROM producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares (USD)
SELECT nombre, precio, (precio * 1.1) AS precio_dolares FROM producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares, con alias
SELECT nombre AS "nombre de producto", precio AS euros, (precio * 1.1) AS dolares FROM producto;

-- Lista los nombres y los precios de todos los productos en mayúsculas
SELECT UPPER(nombre), precio FROM producto;

-- Lista los nombres y los precios de todos los productos en minúsculas
SELECT LOWER(nombre), precio FROM producto;

-- Lista los nombres de los fabricantes en una columna y en otra los dos primeros caracteres del nombre en mayúsculas
SELECT nombre, UPPER(LEFT(nombre, 2)) AS iniciales FROM fabricante;

-- Lista los nombres y los precios de los productos redondeados
SELECT nombre, ROUND(precio, 0) AS precio_redondeado FROM producto;

-- Lista los nombres y los precios de los productos truncando el precio sin decimales
SELECT nombre, TRUNCATE(precio, 0) AS precio_truncado FROM producto;

-- Lista el código de los fabricantes que tienen productos
SELECT DISTINCT codigo_fabricante FROM producto;

-- Lista los códigos de fabricantes sin repetir
SELECT DISTINCT codigo_fabricante FROM producto;

-- Lista los nombres de los fabricantes ordenados ascendentemente
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- Lista los nombres de los fabricantes ordenados descendentemente
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- Lista los nombres de los productos ordenados por nombre ascendente y precio descendente
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- Devuelve las 5 primeras filas de la tabla producto
SELECT * FROM producto LIMIT 5;

-- Devuelve 2 filas a partir de la cuarta fila de la tabla producto
SELECT * FROM producto LIMIT 3, 2;

-- Lista el nombre y el precio del producto más barato
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- Lista el nombre y el precio del producto más caro
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- Lista los productos del fabricante cuyo código es igual a 2
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- Lista el nombre del producto, precio y nombre de fabricante
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Lista el nombre del producto, precio y nombre del fabricante, ordenado por fabricante
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

-- Lista el código del producto, nombre del producto, código del fabricante y nombre del fabricante
SELECT p.codigo, p.nombre AS producto, p.codigo_fabricante, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Lista el producto más barato con su fabricante
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC LIMIT 1;

-- Lista el producto más caro con su fabricante
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC LIMIT 1;

-- Lista todos los productos del fabricante Lenovo
SELECT p.nombre
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- Lista todos los productos del fabricante Crucial con un precio mayor a 200€
SELECT p.nombre, p.precio
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- Lista todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate (sin IN)
SELECT p.nombre
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- Lista todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate (con IN)
SELECT p.nombre
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- Lista productos de fabricantes cuyo nombre termina en 'e'
SELECT p.nombre, p.precio
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

-- Lista productos cuyo fabricante contiene 'w'
SELECT p.nombre, p.precio
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- Lista productos con precio >= 180€, ordenados por precio desc y nombre asc
SELECT p.nombre, p.precio, f.nombre AS fabricante
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- Lista códigos y nombres de fabricantes con productos asociados
SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;

-- Lista todos los fabricantes con sus productos, incluidos los sin productos
SELECT f.nombre AS fabricante, p.nombre AS producto
FROM fabricante f 
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- Lista fabricantes sin productos asociados
SELECT f.nombre
FROM fabricante f 
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo_fabricante IS NULL;

-- Lista productos del fabricante Lenovo (sin INNER JOIN)
SELECT nombre 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- Lista productos con el mismo precio que el producto más caro de Lenovo (sin INNER JOIN)
SELECT * 
FROM producto 
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Lista el producto más caro del fabricante Lenovo
SELECT nombre 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
ORDER BY precio DESC 
LIMIT 1;

-- Lista el producto más barato del fabricante Hewlett-Packard
SELECT nombre 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard')
ORDER BY precio ASC 
LIMIT 1;

-- Lista productos con precio >= al del más caro de Lenovo
SELECT nombre, precio 
FROM producto 
WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Lista productos de Asus con precio superior al precio medio de sus productos
SELECT nombre, precio 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') 
AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));


#UNIVERSIDAD

-- Listado de alumnos/as, ordenado alfabéticamente
SELECT primer_apellido, segundo_apellido, nombre 
FROM persona 
WHERE tipo = 'alumno' 
ORDER BY primer_apellido, segundo_apellido, nombre;

-- Alumnos que no han dado de alta su número de teléfono
SELECT nombre, primer_apellido, segundo_apellido 
FROM persona 
WHERE tipo = 'alumno' AND telefono IS NULL;

-- Listado de los alumnos que nacieron en 1999
SELECT nombre, primer_apellido, segundo_apellido 
FROM persona 
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Profesores/as sin teléfono y NIF que acaba en K
SELECT nombre, primer_apellido, segundo_apellido 
FROM persona 
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- Asignaturas del primer cuatrimestre, tercer curso, grado 7
SELECT nombre_asignatura 
FROM asignaturas 
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- Profesores/as y departamento, ordenado
SELECT p.primer_apellido, p.segundo_apellido, p.nombre, d.nombre AS nombre_departamento 
FROM persona p 
JOIN departamentos d ON p.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY p.primer_apellido, p.segundo_apellido, p.nombre;

-- Asignaturas de un alumno con NIF 26902806M
SELECT a.nombre_asignatura, c.ano_inicio, c.ano_fin 
FROM asignaturas a 
JOIN matriculas m ON a.id = m.id_asignatura 
JOIN cursos c ON m.id_curso = c.id 
JOIN persona al ON m.id_alumno = al.id 
WHERE al.tipo = 'alumno' AND al.nif = '26902806M';

-- Departamentos con profesores que imparten en Ingeniería Informática
SELECT DISTINCT d.nombre 
FROM departamentos d 
JOIN persona p ON d.id = p.id_departamento 
JOIN asignaturas a ON p.id = a.id_profesor 
JOIN grados g ON a.id_grado = g.id 
WHERE p.tipo = 'profesor' AND g.nombre = 'Grado en Ingeniería Informática' AND g.plan = '2015';

-- Alumnos matriculados en 2018/2019
SELECT DISTINCT a.nombre, a.primer_apellido, a.segundo_apellido 
FROM persona a 
JOIN matriculas m ON a.id = m.id_alumno 
JOIN cursos c ON m.id_curso = c.id 
WHERE a.tipo = 'alumno' AND c.ano_inicio = 2018 AND c.ano_fin = 2019;

-- Profesores/as y sus departamentos (LEFT JOIN)
SELECT d.nombre AS nombre_departamento, p.primer_apellido, p.segundo_apellido, p.nombre 
FROM persona p 
LEFT JOIN departamentos d ON p.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY d.nombre, p.primer_apellido, p.segundo_apellido, p.nombre;

-- Profesores/as que no tienen departamento
SELECT p.nombre, p.primer_apellido, p.segundo_apellido 
FROM persona p 
WHERE p.tipo = 'profesor' AND p.id_departamento IS NULL;

-- Departamentos sin profesores asociados
SELECT d.nombre 
FROM departamentos d 
LEFT JOIN persona p ON d.id = p.id_departamento 
WHERE p.id_departamento IS NULL OR p.tipo != 'profesor';

-- Profesores/as que no imparten ninguna asignatura
SELECT p.nombre, p.primer_apellido, p.segundo_apellido 
FROM persona p 
LEFT JOIN asignaturas a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;

-- Asignaturas sin profesor/a asignado
SELECT nombre_asignatura 
FROM asignaturas 
WHERE id_profesor IS NULL;

-- Departamentos sin asignaturas impartidas
SELECT d.nombre 
FROM departamentos d 
LEFT JOIN persona p ON d.id = p.id_departamento 
LEFT JOIN asignaturas a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;

-- Número total de alumnos
SELECT COUNT(*) AS total_alumnos 
FROM persona 
WHERE tipo = 'alumno';

-- Alumnos nacidos en 1999
SELECT COUNT(*) AS total_alumnos_1999 
FROM persona 
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Número de profesores/as por departamento (ordenado)
SELECT d.nombre, COUNT(p.id) AS numero_profesores 
FROM departamentos d 
JOIN persona p ON d.id = p.id_departamento 
WHERE p.tipo = 'profesor' 
GROUP BY d.nombre 
ORDER BY numero_profesores DESC;

-- Departamentos y número de profesores/as (incluye sin asociados)
SELECT d.nombre, COUNT(p.id) AS numero_profesores 
FROM departamentos d 
LEFT JOIN persona p ON d.id = p.id_departamento 
WHERE p.tipo = 'profesor' 
GROUP BY d.nombre;

-- Grados y número de asignaturas (incluye sin asignaturas)
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas 
FROM grados g 
LEFT JOIN asignaturas a ON g.id = a.id_grado 
GROUP BY g.nombre 
ORDER BY numero_asignaturas DESC;

-- Grados con más de 40 asignaturas
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas 
FROM grados g 
LEFT JOIN asignaturas a ON g.id = a.id_grado 
GROUP BY g.nombre 
HAVING COUNT(a.id) > 40;

-- Grados y suma de créditos por tipo de asignatura
SELECT g.nombre, a.tipo_asignatura, SUM(a.creditos) AS total_creditos 
FROM grados g 
JOIN asignaturas a ON g.id = a.id_grado 
GROUP BY g.nombre, a.tipo_asignatura;

-- Alumnos matriculados por curso escolar
SELECT c.ano_inicio, COUNT(DISTINCT m.id_alumno) AS numero_alumnos 
FROM matriculas m 
JOIN cursos c ON m.id_curso = c.id 
JOIN persona a ON m.id_alumno = a.id 
WHERE a.tipo = 'alumno' 
GROUP BY c.ano_inicio;

-- Número de asignaturas por profesor/a (incluye sin asignaturas)
SELECT p.id, p.nombre, p.primer_apellido, p.segundo_apellido, COUNT(a.id) AS numero_asignaturas 
FROM persona p 
LEFT JOIN asignaturas a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' 
GROUP BY p.id, p.nombre, p.primer_apellido, p.segundo_apellido 
ORDER BY numero_asignaturas DESC;

-- Datos del alumno/a más joven
SELECT * 
FROM persona 
WHERE tipo = 'alumno' 
ORDER BY fecha_nacimiento DESC 
LIMIT 1;

-- Profesores/as con departamento que no imparten asignaturas
SELECT p.nombre, p.primer_apellido, p.segundo_apellido, d.nombre AS departamento 
FROM persona p 
JOIN departamentos d ON p.id_departamento = d.id 
LEFT JOIN asignaturas a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;


