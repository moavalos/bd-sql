USE Ejercicio2;
/*1. Hallar los números de vuelo desde el origen A hasta el destino F.*/
	SELECT vue.nro_vuelo
    FROM vuelo AS vue
	WHERE desde = 'A' AND hasta = 'F';
    
/*2. Hallar los nombres de pasajeros y números de vuelo para aquellos pasajeros que viajan desde A a D.*/
	SELECT pasa.nombre, vue.nro_vuelo
    FROM pasajero pasa JOIN vuelo vue ON pasa.nro_vuelo = vue.nro_vuelo
    WHERE desde = 'A' 
    AND hasta = 'D';

/*3. Hallar los tipos de avión para vuelos que parten desde C.*/
	SELECT a.tipo_avion
    FROM avion a JOIN vuelo vue ON vue.nro_avion =a.nro_avion
    WHERE vue.desde = 'C';

/*4. Listar los distintos tipo y nro. de avión que tienen a H como destino.*/
	SELECT DISTINCT a.tipo_avion, a.nro_avion 
    FROM avion a JOIN vuelo vue ON a.nro_avion = vue.nro_avion
    WHERE vue.hasta = 'H'
    GROUP BY a.nro_avion, a.tipo_avion;

/*5. Mostrar por cada Avión (número y modelo) la cantidad de vuelos en que se encuentra registrado.*/
	SELECT a.modelo, a.nro_avion, COUNT(*) 'cant vuelos'
    FROM avion a JOIN vuelo vue ON a.nro_avion = vue.nro_avion
    GROUP BY a.nro_avion, a.modelo
	ORDER BY COUNT(*) DESC;

/*6. Cuántos pasajeros diferentes han volado en un avión de modelo ‘B-777’. */
	SELECT DISTINCT COUNT(*)
    FROM pasajero pasa JOIN vuelo vue ON pasa.nro_vuelo = vue.nro_vuelo
						JOIN avion a ON a.nro_avion = vue.nro_avion
	WHERE a.modelo = 'B-777';

/*7. Listar la cantidad promedio de pasajeros transportados por los aviones de la compañía, por tipo de avión.*/
		
        
/*8. Hallar los tipos de avión que no son utilizados en algún vuelo que pase por B.*/
	SELECT DISTINCT a.tipo_avion
    FROM avion a JOIN vuelo vue ON a.nro_avion = vue.nro_avion
    WHERE vue.desde = 'B'
    AND vue.hasta = 'B';
    
