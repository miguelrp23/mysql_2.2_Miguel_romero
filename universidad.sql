-- Listado de alumnos/as, ordenado alfabéticamente
SELECT apellido1, apellido2, nombre 
FROM persona 
WHERE tipo = 'alumno' 
ORDER BY apellido1, apellido2, nombre;

-- Alumnos que no han dado de alta su número de teléfono
SELECT nombre, apellido1, apellido2 
FROM persona 
WHERE tipo = 'alumno' AND telefono IS NULL;

-- Listado de los alumnos que nacieron en 1999
SELECT nombre, apellido1, apellido2 
FROM persona 
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Profesores/as sin teléfono y NIF que acaba en K
SELECT nombre, apellido1, apellido2 
FROM persona 
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- Asignaturas del primer cuatrimestre, tercer curso, grado 7
SELECT nombre_asignatura 
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- Profesores/as y departamento, ordenado
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento 
FROM persona p 
JOIN departamento d ON p.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- Asignaturas de un alumno con NIF 26902806M
SELECT a.nombre_asignatura, c.anyo_inicio, c.anyo_fin 
FROM asignatura a 
JOIN alumno_se_matricula_asignatura m ON a.id = m.id_asignatura 
JOIN curso_escolar c ON m.id_curso_escolar = c.id 
JOIN persona al ON m.id_alumno = al.id 
WHERE al.tipo = 'alumno' AND al.nif = '26902806M';

-- Departamentos con profesores que imparten en Ingeniería Informática
SELECT DISTINCT d.nombre 
FROM departamento d 
JOIN persona p ON d.id = p.id_departamento 
JOIN asignatura a ON p.id = a.id_profesor 
JOIN grado g ON a.id_grado = g.id 
WHERE p.tipo = 'profesor' AND g.nombre = 'Grado en Ingeniería Informática' AND g.nombre = '2015';

-- Alumnos matriculados en 2018/2019
SELECT DISTINCT a.nombre, a.apellido1, a.apellido2
FROM persona a 
JOIN  alumno_se_matricula_asignatura m ON a.id = m.id_alumno 
JOIN curso_escolar c ON m.id_curso_escolar = c.id 
WHERE a.tipo = 'alumno' AND c.anyo_inicio = 2018 AND c.anyo_fin = 2019;

-- Profesores/as y sus departamentos (LEFT JOIN)
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre 
FROM persona p 
LEFT JOIN departamento d ON p.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- Profesores/as que no tienen departamento
SELECT p.nombre, p.apellido1, p.apellido2 
FROM persona p 
WHERE p.tipo = 'profesor' AND p.id_departamento IS NULL;

-- Departamentos sin profesores asociados
SELECT d.nombre 
FROM departamento d 
LEFT JOIN persona p ON d.id = p.id_departamento 
WHERE p.id_departamento IS NULL OR p.tipo != 'profesor';

-- Profesores/as que no imparten ninguna asignatura
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p 
LEFT JOIN asignatura a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;

-- Asignaturas sin profesor/a asignado
SELECT nombre_asignatura 
FROM asignatura 
WHERE id_profesor IS NULL;

-- Departamentos sin asignaturas impartidas
SELECT d.nombre 
FROM departamento d 
LEFT JOIN persona p ON d.id = p.id_departamento 
LEFT JOIN asignatura a ON p.id = a.id_profesor 
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
FROM departamento d 
JOIN persona p ON d.id = p.id_departamento 
WHERE p.tipo = 'profesor' 
GROUP BY d.nombre 
ORDER BY numero_profesores DESC;

-- Departamentos y número de profesores/as (incluye sin asociados)
SELECT d.nombre, COUNT(p.id) AS numero_profesores 
FROM departamento d 
LEFT JOIN persona p ON d.id = p.id_departamento 
WHERE p.tipo = 'profesor' 
GROUP BY d.nombre;

-- Grados y número de asignaturas (incluye sin asignaturas)
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas 
FROM grado g 
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre 
ORDER BY numero_asignaturas DESC;

-- Grados con más de 40 asignaturas
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas 
FROM grado g 
LEFT JOIN asignaturas a ON g.id = a.id_grado 
GROUP BY g.nombre 
HAVING COUNT(a.id) > 40;

-- Grados y suma de créditos por tipo de asignatura
SELECT g.nombre, a.tipo_asignatura, SUM(a.creditos) AS total_creditos 
FROM grado g 
JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre, a.tipo_asignatura;

-- Alumnos matriculados por curso escolar
SELECT c.ano_inicio, COUNT(DISTINCT m.id_alumno) AS numero_alumnos 
FROM  alumno_se_matricula_asignatura m
JOIN curso_escolar c ON m.id_curso = c.id 
JOIN persona a ON m.id_alumno = a.id 
WHERE a.tipo = 'alumno' 
GROUP BY c.ano_inicio;

-- Número de asignaturas por profesor/a (incluye sin asignaturas)
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas 
FROM persona p 
LEFT JOIN asignatura a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' 
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 
ORDER BY numero_asignaturas DESC;

-- Datos del alumno/a más joven
SELECT * 
FROM persona 
WHERE tipo = 'alumno' 
ORDER BY fecha_nacimiento DESC 
LIMIT 1;

-- Profesores/as con departamento que no imparten asignaturas
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS departamento 
FROM persona p 
JOIN departamento d ON p.id_departamento = d.id 
LEFT JOIN asignatura a ON p.id = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;
