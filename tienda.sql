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
