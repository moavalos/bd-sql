USE Ejercicio4;
/*1. Listar el nombre y ciudad de todas las personas que trabajan en la empresa “Banelco”.*/

	SELECT p.nombre, p.ciudad
	FROM Persona p JOIN Trabaja t ON p.nro_persona = t.nro_persona
					JOIN Empresa e ON e.nro_empresa = t.nro_empresa
	WHERE e.razon_social = 'Banelco';

/*2. Listar el nombre, calle y ciudad de todas las personas que trabajan para la empresa 
“Paulinas” y ganan más de $1500.*/

	SELECT p.nombre, p.calle, p.ciudad
    FROM persona p JOIN Trabaja t ON p.nro_persona = t.nro_persona
					JOIN Empresa e ON e.nro_empresa = t.nro_empresa
	WHERE e.razon_social = 'Paulinas'
    AND t.salario > 1.500;
    
/*3. Listar el nombre de personas que viven en la misma ciudad en la que se halla la empresa
 en donde trabajan.*/
 
	SELECT p.nombre
    FROM Persona p 
    WHERE EXISTS (
					SELECT 1
                    FROM Trabaja t JOIN Empresa e ON e.nro_empresa = t.nro_empresa
                    WHERE p.ciudad = e.ciudad);

/*4. Listar número y nombre de todas las personas que viven en la misma ciudad y en la misma 
calle que su supervisor.*/
	


/*5. Listar el nombre y ciudad de todas las personas que ganan más que cualquier
empleado de la empresa “Tecnosur”.*/

/*6. Listar las ciudades en las que todos los trabajadores que vienen en ellas ganan
más de $1000.*/

/*7. Listar el nombre de los empleados que hayan ingresado en mas de 4 Empresas en
el periodo 01-01-2000 y 31-03-2004./

