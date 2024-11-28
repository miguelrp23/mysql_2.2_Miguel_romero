-- 1 Listado de alumnos/as, ordenado alfabéticamente
    SELECT 
        `universidad`.`persona`.`apellido1` AS `apellido1`,
        `universidad`.`persona`.`apellido2` AS `apellido2`,
        `universidad`.`persona`.`nombre` AS `nombre`
    FROM
        `universidad`.`persona`
    WHERE
        (`universidad`.`persona`.`tipo` = 'alumno')
    ORDER BY `universidad`.`persona`.`apellido1` , `universidad`.`persona`.`apellido2` , `universidad`.`persona`.`nombre`

-- 2 Alumnos que no han dado de alta su número de teléfono
 SELECT 
        `universidad`.`persona`.`nombre` AS `nombre`,
        `universidad`.`persona`.`apellido1` AS `apellido1`,
        `universidad`.`persona`.`apellido2` AS `apellido2`
    FROM
        `universidad`.`persona`
    WHERE
        ((`universidad`.`persona`.`tipo` = 'alumno')
            AND (`universidad`.`persona`.`telefono` IS NULL))

-- 3 Listado de los alumnos que nacieron en 1999
SELECT 
        `universidad`.`persona`.`nombre` AS `nombre`,
        `universidad`.`persona`.`apellido1` AS `apellido1`,
        `universidad`.`persona`.`apellido2` AS `apellido2`
    FROM
        `universidad`.`persona`
    WHERE
        ((`universidad`.`persona`.`tipo` = 'alumno')
            AND (YEAR(`universidad`.`persona`.`fecha_nacimiento`) = 1999))

-- 4  Profesores/as sin teléfono y NIF que acaba en K
 SELECT 
        `universidad`.`persona`.`nombre` AS `nombre`,
        `universidad`.`persona`.`apellido1` AS `apellido1`,
        `universidad`.`persona`.`apellido2` AS `apellido2`
    FROM
        `universidad`.`persona`
    WHERE
        ((`universidad`.`persona`.`tipo` = 'profesor')
            AND (`universidad`.`persona`.`telefono` IS NULL)
            AND (`universidad`.`persona`.`nif` LIKE '%K'))

-- 5 Asignaturas del primer cuatrimestre, tercer curso, grado 7
SELECT 
        `universidad`.`asignatura`.`nombre` AS `nombre`
    FROM
        `universidad`.`asignatura`
    WHERE
        ((`universidad`.`asignatura`.`cuatrimestre` = 1)
            AND (`universidad`.`asignatura`.`curso` = 3)
            AND (`universidad`.`asignatura`.`id_grado` = 7))

-- 6 Profesores/as y departamento, ordenado
 SELECT 
        `p`.`apellido1` AS `apellido1`,
        `p`.`apellido2` AS `apellido2`,
        `p`.`nombre` AS `nombre`,
        `d`.`nombre` AS `departamento_nombre`
    FROM
        (`universidad`.`persona` `p`
        JOIN `universidad`.`departamento` `d` ON ((`p`.`id` = `d`.`id`)))
    WHERE
        (`p`.`tipo` = 'profesor')
    ORDER BY `p`.`apellido1` , `p`.`apellido2` , `p`.`nombre`



-- 7  Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno/a con NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin , persona.nif 
FROM alumno_se_matricula_asignatura m inner JOIN curso_escolar 
ON m.id_curso_escolar =  curso_escolar.id inner JOIN asignatura 
ON m.id_asignatura= asignatura.id inner JOIN persona ON id_alumno=persona.id WHERE persona.nif='26902806M';

-- 8 Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id= profesor.id_departamento 
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor 
JOIN grado ON  asignatura.id_grado = grado.id 
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';


-- 9 Alumnos matriculados en 2018/2019
 SELECT DISTINCT
        `a`.`nombre` AS `nombre`,
        `a`.`apellido1` AS `apellido1`,
        `a`.`apellido2` AS `apellido2`
    FROM
        ((`universidad`.`persona` `a`
        JOIN `universidad`.`alumno_se_matricula_asignatura` `m` ON ((`a`.`id` = `m`.`id_alumno`)))
        JOIN `universidad`.`curso_escolar` `c` ON ((`m`.`id_curso_escolar` = `c`.`id`)))
    WHERE
        ((`a`.`tipo` = 'alumno')
            AND (`c`.`anyo_inicio` = 2018)
            AND (`c`.`anyo_fin` = 2019))


-- 10 Profesores/as y sus departamentos (LEFT JOIN)
   SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre 
   FROM departamento RIGHT JOIN profesor  ON departamento.id=profesor.id_departamento 
   LEFT JOIN persona ON persona.id=profesor.id_profesor ORDER BY  departamento.nombre;


-- 11  Devuelve un listado con los profesores/as que no están asociados a un departamento.

SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre FROM
 departamento RIGHT JOIN profesor  ON departamento.id=profesor.id_departamento 
 LEFT JOIN persona ON persona.id=profesor.id_profesor WHERE profesor.id_departamento IS NULL  
  ORDER BY  departamento.nombre;

-- 12 Devuelve un listado con los departamentos que no tienen profesores asociados.

SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre 
FROM departamento LEFT JOIN profesor  ON departamento.id=profesor.id_departamento 
LEFT JOIN persona ON persona.id=profesor.id_profesor 
WHERE profesor.id_departamento IS NULL ORDER BY  departamento.nombre;

-- 13 Profesores/as que no imparten ninguna asignatura
SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre
 FROM departamento RIGHT JOIN profesor  ON departamento.id=profesor.id_departamento 
 LEFT JOIN persona ON persona.id=profesor.id_profesor ORDER BY  departamento.nombre;

-- 14 Asignaturas sin profesor/a asignado
 SELECT 
        `universidad`.`asignatura`.`nombre` AS `nombre`
    FROM
        `universidad`.`asignatura`
    WHERE
        (`universidad`.`asignatura`.`id_profesor` IS NULL)

-- 15 Departamentos sin asignaturas impartidas
 SELECT 
        `d`.`nombre` AS `nombre`
    FROM
        ((`universidad`.`departamento` `d`
        LEFT JOIN `universidad`.`persona` `p` ON ((`d`.`id` = `p`.`id`)))
        LEFT JOIN `universidad`.`asignatura` `a` ON ((`p`.`id` = `a`.`id_profesor`)))
    WHERE
        ((`p`.`tipo` = 'profesor')
            AND (`a`.`id_profesor` IS NULL))
-- 16 Número total de alumnos
 SELECT 
        COUNT(0) AS `total_alumnos`
    FROM
        `universidad`.`persona`
    WHERE
        (`universidad`.`persona`.`tipo` = 'alumno')

-- 17 Alumnos nacidos en 1999
  SELECT 
        COUNT(0) AS `total_alumnos_1999`
    FROM
        `universidad`.`persona`
    WHERE
        ((`universidad`.`persona`.`tipo` = 'alumno')
            AND (YEAR(`universidad`.`persona`.`fecha_nacimiento`) = 1999))

-- 18 Número de profesores/as por departamento (ordenado)
 SELECT 
        `d`.`nombre` AS `nombre`,
        COUNT(`p`.`id`) AS `numero_profesores`
    FROM
        (`universidad`.`departamento` `d`
        JOIN `universidad`.`persona` `p` ON ((`d`.`id` = `p`.`id`)))
    WHERE
        (`p`.`tipo` = 'profesor')
    GROUP BY `d`.`nombre`
    ORDER BY `numero_profesores` DESC

-- 19 Grados y número de asignaturas (incluye sin asignaturas)
 SELECT 
        `g`.`nombre` AS `nombre`,
        COUNT(`a`.`id`) AS `numero_asignaturas`
    FROM
        (`universidad`.`grado` `g`
        LEFT JOIN `universidad`.`asignatura` `a` ON ((`g`.`id` = `a`.`id_grado`)))
    GROUP BY `g`.`nombre`
    ORDER BY `numero_asignaturas` DESC

--20 Grados con más de 40 asignaturas
   SELECT 
        `g`.`nombre` AS `nombre`,
        COUNT(`a`.`id`) AS `numero_asignaturas`
    FROM
        (`universidad`.`grado` `g`
        LEFT JOIN `universidad`.`asignatura` `a` ON ((`g`.`id` = `a`.`id_grado`)))
    GROUP BY `g`.`nombre`
    HAVING (COUNT(`a`.`id`) > 40)

-- 22 Grados y suma de créditos por tipo de asignatura
  SELECT 
        `g`.`nombre` AS `nombre`,
        `a`.`tipo` AS `tipo`,
        SUM(`a`.`creditos`) AS `total_creditos`
    FROM
        (`universidad`.`grado` `g`
        JOIN `universidad`.`asignatura` `a` ON ((`g`.`id` = `a`.`id_grado`)))
    GROUP BY `g`.`nombre` , `a`.`tipo`
-- 23 Alumnos matriculados por curso escolar
SELECT 
        `c`.`anyo_inicio` AS `anyo_inicio`,
        COUNT(DISTINCT `m`.`id_alumno`) AS `numero_alumnos`
    FROM
        ((`universidad`.`alumno_se_matricula_asignatura` `m`
        JOIN `universidad`.`curso_escolar` `c` ON ((`m`.`id_curso_escolar` = `c`.`id`)))
        JOIN `universidad`.`persona` `a` ON ((`m`.`id_alumno` = `a`.`id`)))
    WHERE
        (`a`.`tipo` = 'alumno')
    GROUP BY `c`.`anyo_inicio`

-- 24 Número de asignaturas por profesor/a (incluye sin asignaturas)
SELECT 
        `p`.`id` AS `id`,
        `p`.`nombre` AS `nombre`,
        `p`.`apellido1` AS `apellido1`,
        `p`.`apellido2` AS `apellido2`,
        COUNT(`a`.`id`) AS `numero_asignaturas`
    FROM
        (`universidad`.`persona` `p`
        LEFT JOIN `universidad`.`asignatura` `a` ON ((`p`.`id` = `a`.`id_profesor`)))
    WHERE
        (`p`.`tipo` = 'profesor')
    GROUP BY `p`.`id` , `p`.`nombre` , `p`.`apellido1` , `p`.`apellido2`
    ORDER BY `numero_asignaturas` DESC
-- 25 Datos del alumno/a más joven
SELECT * 
 SELECT 
        `universidad`.`persona`.`id` AS `id`,
        `universidad`.`persona`.`nif` AS `nif`,
        `universidad`.`persona`.`nombre` AS `nombre`,
        `universidad`.`persona`.`apellido1` AS `apellido1`,
        `universidad`.`persona`.`apellido2` AS `apellido2`,
        `universidad`.`persona`.`ciudad` AS `ciudad`,
        `universidad`.`persona`.`direccion` AS `direccion`,
        `universidad`.`persona`.`telefono` AS `telefono`,
        `universidad`.`persona`.`fecha_nacimiento` AS `fecha_nacimiento`,
        `universidad`.`persona`.`sexo` AS `sexo`,
        `universidad`.`persona`.`tipo` AS `tipo`
    FROM
        `universidad`.`persona`
    WHERE
        (`universidad`.`persona`.`tipo` = 'alumno')
    ORDER BY `universidad`.`persona`.`fecha_nacimiento` DESC
    LIMIT 1
    
-- 26 Profesores/as con departamento que no imparten asignaturas
SELECT persona.id, persona.nif, persona.nombre, persona.apellido1, persona.apellido2, persona.tipo, departamento.nombre AS Departamento, asignatura.id as id_asignatura FROM persona JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN 
asignatura ON asignatura.id_profesor=profesor.id_profesor LEFT JOIN 
departamento ON departamento.id=profesor.id_departamento WHERE asignatura.id IS NULL
