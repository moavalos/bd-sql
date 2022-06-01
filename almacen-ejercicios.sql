USE almacen;

/*1. Listar los números de artículos cuyo precio se encuentre entre $100 y $1000 y su
descripción comience con la letra A.*/
	SELECT cod_art
    FROM articulo
    WHERE precio BETWEEN 100 AND 1000
		AND descrip LIKE 'A%';
    
/*2. Listar todos los datos de todos los proveedores.*/
	SELECT *
    FROM proveedor;
    
/*3. Listar la descripción de los materiales de código 1, 3, 6, 9 y 18 */
	SELECT descrip
    FROM material
    WHERE cod_mat IN (1,3,6,9,18);
    
/*4. Listar código y nombre de proveedores de la calle Suipacha, que hayan sido dados de alta en el año 2001.*/
	SELECT cod_prov, nombre
    FROM proveedor
    WHERE domicilio LIKE '%Suipacha%'
		AND fecha_alta >= '2001-01-01' 
        AND fecha_alta < '2002-01-01';
    
/*5. Listar nombre de todos los proveedores y de su ciudad. */
	SELECT prov.nombre, ciu.nombre
    FROM proveedor prov LEFT JOIN ciudad ciu ON prov.cod_ciu = ciu.cod_ciu;
    
/*6. Listar los nombres de los proveedores de la ciudad de La Plata*/
	SELECT prov.nombre
    FROM proveedor AS prov JOIN ciudad AS ciu ON prov.cod_ciu = ciu.cod_ciu 
    WHERE ciu.nombre = 'La Plata';
    
/*7.  Listar los números de almacenes que almacenan el artículo de descripción A.*/
	SELECT cont.nro
    FROM contiene AS cont JOIN articulo AS art ON cont.cod_art = art.cod_art
    WHERE art.descrip = 'A';
    
/*8. Listar los materiales (código y descripción) provistos por proveedores de la ciudad de Rosario*/
	SELECT mat.cod_mat, mat.descrip
    FROM material mat JOIN provisto_por pp ON mat.cod_mat = pp.cod_mat
					JOIN proveedor prov ON pp.cod_prov = prov.cod_prov
					JOIN ciudad ciu ON prov.cod_ciu = ciu.cod_ciu
	WHERE ciu.nombre = 'Rosario';
    
/*9. Listar los nombres de los proveedores que proveen materiales para artículos ubicados en almacenes que Martín Gómez tiene a su cargo.*/
	SELECT prov.nombre
    FROM proveedor prov JOIN provisto_por pp ON prov.cod_prov = pp.cod_prov
						JOIN compuesto_por cp ON pp.cod_mat = cp.cod_mat
                        JOIN contiene cont ON cp.cod_art = cont.cod_art
                        JOIN almacen1 a ON cont.nro = a.nro
	WHERE a.responsable = 'Martín Gómez';

/*10. Mover los artículos almacenados en el almacén de número 10 al de número 20*/
	
/*11. Eliminar a los proveedores que contengan la palabra ABC en su nombre*/

/*12. Indicar la cantidad de proveedores que comienzan con la letra F.*/
	SELECT COUNT(*) AS 'cantidad de proveedores'
    FROM proveedor
    WHERE nombre LIKE 'F%';
    
/*13. Listar el promedio de precios de los artículos por cada almacén (nombre)*/
	SELECT a.nombre, AVG(art.precio)
    FROM almacen1 a JOIN contiene cont ON a.nro = cont.nro
					JOIN articulo art ON cont.cod_art = art.cod_art
	GROUP BY a.nro, a.nombre;
    
/*14. Listar la descripción de artículos compuestos por al menos 2 materiales.*/
	SELECT art.descrip
    FROM articulo art JOIN compuesto_por cp ON art.cod_art = cp.cod_art
	GROUP BY art.cod_art, art.descrip
    HAVING COUNT(*) >= 2;
    
/*15. Listar cantidad de materiales que provee cada proveedor (código, nombre y domicilio)*/
	SELECT p.cod_prov, p.nombre, p.domicilio, COUNT(pp.cod_mat)
    FROM proveedor p LEFT JOIN provisto_por pp ON p.cod_prov = pp.cod_prov
    GROUP BY p.cod_prov, p.nombre, p.domicilio;
    
/*16. Cuál es el precio máximo de los artículos que proveen los proveedores de la ciudad de Zárate.*/
	SELECT MAX(art.precio)
    FROM proveedor prov JOIN provisto_por pp ON prov.cod_prov = pp.cod_prov
						JOIN compuesto_por cp ON pp.cod_mat = cp.cod_mat
                        JOIN articulo art ON cp.cod_art = art.cod_art
                        JOIN ciudad ciu ON ciu.cod_ciu = prov.cod_ciu
	WHERE ciu.nombre = 'Zárate';
    
/*17. Listar los nombres de aquellos proveedores que no proveen ningún material.*/
	SELECT prov.nombre
    FROM proveedor prov 
    WHERE NOT EXISTS (SELECT 1 
						FROM provisto_por pp
                        WHERE pp.cod_prov = prov.cod_prov);
    
/*18. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el proveedor 15.*/
	SELECT mat.cod_mat
    FROM material mat
    WHERE EXISTS (SELECT 1
					FROM provisto_por pp 
                    WHERE mat.cod_mat = pp.cod_mat
                    AND pp.cod_prov = 10)
	AND NOT EXISTS (SELECT 1
					FROM provisto_por pp2
                    WHERE mat.cod_mat = pp2.cod_mat
                    AND pp2.cod_prov = 15);
						
/*19. Listar número y nombre de almacenes que contienen los artículos de descripción A y los de descripción B (ambos).*/
	SELECT a.nro, a.nombre 
    FROM almacen1 a
    WHERE EXISTS (SELECT 1
					FROM contiene cont JOIN articulo art ON cont.cod_art = art.cod_art
                    WHERE a.nro = cont.nro 
                    AND art.descrip = 'A')
		AND EXISTS (SELECT 1
					FROM contiene cont JOIN articulo art2 ON cont.cod_art = art2.cod_art
                    WHERE a.nro = cont.nro
                    AND art2.descrip = 'B');

/*20. Listar la descripción de artículos compuestos por todos los materiales.*/
	SELECT art.descrip
    FROM articulo art
    WHERE NOT EXISTS 	(SELECT 1
						FROM material mat
                        WHERE NOT EXISTS 	(SELECT 1
											FROM compuesto_por cp
                                            WHERE cp.cod_art = art.cod_art
                                            AND cp.cod_mat = mat.cod_mat));

/*21. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo cuyo precio es mayor a $100.*/
	SELECT prov.cod_prov, prov.nombre
    FROM proveedor prov 
	WHERE EXISTS (SELECT 1
				FROM provisto_por pp JOIN compuesto_por cp ON pp.cod_mat = cp.cod_mat	
									JOIN articulo art ON cp.cod_art = art.cod_art
				WHERE art.precio > 100
                AND pp.cod_prov = prov.cod_prov);

/*22. Listar la descripción de los artículos de mayor precio.*/
	SELECT art.descrip
    FROM articulo art
    WHERE precio = (SELECT MAX(PRECIO)
					FROM articulo art2);
    
/*23. Listar los nombres de proveedores de Capital Federal que sean únicos proveedores de algún material.*/
	SELECT DISTINCT prov.nombre
    FROM proveedor prov JOIN ciudad ciu ON prov.cod_ciu = ciu.cod_ciu
						JOIN provisto_por pp ON pp.cod_prov = prov.cod_prov
    WHERE ciu.nombre = 'Capital Federal'
    AND pp.cod_mat IN (
						SELECT pp.cod_mat 
						FROM provisto_por pp			
						GROUP BY pp.cod_mat
						HAVING COUNT(*)=1
		);
                
/*24. Listar los nombres de almacenes que almacenan la mayor cantidad de artículos.*/
	SELECT a.nombre
    FROM almacen1 a JOIN contiene cont ON a.nro = cont.nro
    GROUP BY a.nro, a.nombre
	HAVING COUNT(*) =
					(
					SELECT MAX(nroAlm.cantArt)
					FROM 
						(
							SELECT COUNT(*) AS cantArt
							FROM contiene AS co2
							GROUP BY co2.nro
						) AS nroAlm );
    
/*25. Listar la ciudades donde existan proveedores que proveen todos los materiales.*/
	SELECT distinct ciu.nombre
    FROM proveedor prov JOIN ciudad ciu ON ciu.cod_ciu = prov.cod_ciu
    WHERE NOT EXISTS (SELECT 1
						FROM material mat
                        WHERE NOT EXISTS (SELECT 1
											FROM provisto_por pp
                                            WHERE pp.cod_prov = prov.cod_prov
                                            AND pp.cod_mat = mat.cod_mat));
    
/*26. Listar los números de almacenes que tienen todos los artículos que incluyen el material con código 123.*/
	SELECT a.nro
    FROM almacen1 a
    WHERE NOT EXISTS (SELECT 1
					FROM articulo art JOIN compuesto_por cp ON art.cod_art = cp.cod_art
                    WHERE cp.cod_mat = 123
                    AND NOT EXISTS (SELECT 1
									FROM contiene cont 
                                    WHERE cont.nro = a.nro
                                    AND cont.cod_art = art.cod_art));
