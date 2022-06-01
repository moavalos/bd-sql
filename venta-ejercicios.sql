USE Ejercicio3;
/*1. Listar la cantidad de productos que tiene la empresa.*/
	SELECT COUNT(*)
    FROM Producto;

/*2. Listar la descripción de productos en estado 'en stock' que tiene la empresa. */
	SELECT prod.descripcion
    FROM producto prod
    WHERE estado = 'en stock';

/*3. Listar los productos que nunca fueron vendidos.*/
	SELECT prod.id_producto
    FROM producto prod JOIN Detalle_Venta dv ON dv.id_producto = prod.id_producto
    WHERE dv.id_producto IS NULL;

/*4. Listar la cantidad total de unidades que fueron vendidas de cada producto (descripción).*/
	SELECT prod.descripcion, COUNT(*)
    FROM producto prod JOIN detalle_venta dv ON dv.id_producto = prod.id_producto
    GROUP BY prod.descripcion, prod.id_producto;

/*5. Listar el nombre de cada vendedor y la cantidad de ventas realizadas en el año 2015.*/
	SELECT vend.nombre, COUNT(*)
    FROM vendedor vend JOIN venta vent ON vent.id_vendedor = vend.id_vendedor
    WHERE vent.fecha BETWEEN '2015-01-01' AND '2016-01-01'
    GROUP BY vend.id_vendedor, vend.nombre;

/*6. Lista el monto total vendido por cada cliente (nombre)*/
	SELECT clie.nombre, SUM(dv.precio_unitario)
    FROM Cliente clie JOIN Venta vent ON clie.id_cliente = vent.id_cliente
					JOIN Detalle_Venta dv ON dv.nro_factura = vent.nro_factura
	GROUP BY clie.nombre = clie.id_cliente;

/*7. Listar la descripción de aquellos productos en estado ‘sin stock’ que se hayan vendido en el mes de Enero de 2015.*/
	SELECT prod.descripcion
    FROM producto prod
    WHERE prod.estado = 'sin stock'
		AND prod.id_producto IN (
									SELECT dv.id_producto
									FROM Detalle_Venta dv JOIN venta vent ON vent.nro_factura = dv.nro_factura
									WHERE vent.fecha BETWEEN '2015-01-01' AND '2015-01-31'

								);