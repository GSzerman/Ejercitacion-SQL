-- Ejercicio A

SELECT cxp.cod_practica, pr.descripcion, sum(costo_total) precio_total, sum(cantidad) total_consultas, '2019' anio
FROM Consultas c 
INNER JOIN Consultas_x_Practicas cxp ON c.nro_consulta = cxp.nro_consulta
INNER JOIN Practica pr ON cxp.cod_practica = pr.cod_practica              
WHERE datepart(yy,fecha_consulta) = 2019                                  
GROUP BY cxp.cod_practica, pr.descripcion                   


-- Ejercicio B

SELECT l.cod_localidad codigo, l.nombre_local nombre, sum(costo_total) costo 
FROM Consultas c
INNER JOIN Pacientes p ON c.cod_paciente = p.cod_paciente
INNER JOIN Localidades l ON p.cod_localidad = l.cod_localidad
WHERE c.fecha_consulta = cast(getdate() as date)		  
GROUP BY l.cod_localidad, l.nombre_local			
HAVING sum(costo_total) > 5000 
ORDER BY sum(costo_total) DESC


-- Ejercicio C

SELECT h.cod_padre, h.fecha_alta, p.cod_paciente
FROM Pacientes h                             
INNER JOIN pacientes p ON p.cod_padre = h.cod_paciente	
WHERE p.edad <= 18


-- EJERCICIO D

SELECT cxp.cod_practica INTO #practicas_anio_actual
FROM Consultas c 
INNER JOIN Consultas_x_Practicas cxp ON c.nro_consulta = cxp.nro_consulta
WHERE datepart(yy,fecha_consulta)  = datepart(yy,getdate()) 

SELECT p.cod_practica, descripcion
FROM Practica p
WHERE p.cod_practica NOT IN (SELECT cod_practica FROM #practicas_anio_actual)


-- EJERCICIO E

SELECT distinct c.legajo_medico INTO #si_atendieron_a_gaston
FROM Consultas c
INNER JOIN Medicos m ON c.legajo_medico = m.legajo_medico
INNER JOIN Pacientes p ON c.cod_paciente = p.cod_paciente
WHERE p.nombre_apellido = 'Gaston Aizpurua'

SELECT distinct legajo_medico, nombre, apellido 
FROM Medicos
WHERE legajo_medico NOT IN (SELECT legajo_medico FROM #si_atendieron_a_gaston)

