

use sistema_bd_linea_blanca;

#vistas de inventario
CREATE VIEW `vista_articulos_disponibles` AS  
	SELECT articulo.id_articulo as código, articulo.descripcion, articulo.marca, articulo.precio_cliente as precio, almacen_tiene_articulo.cantidad_articulo_disponible as cantidad_disponible
	from articulo
	JOIN almacen_tiene_articulo 
	ON articulo.id_articulo= almacen_tiene_articulo.articulo_id_articulo     
	where almacen_tiene_articulo.reabastecimiento_solicitado='0' and articulo.articulo_eliminado='0';

CREATE VIEW `vista_articulos_solicitados` AS  
	SELECT articulo.id_articulo as código, articulo.descripcion, articulo.marca, articulo.precio_cliente as precio, almacen_tiene_articulo.cantidad_articulo_disponible as cantidad_disponible
	from articulo
	JOIN almacen_tiene_articulo 
	ON articulo.id_articulo = almacen_tiene_articulo.articulo_id_articulo     
	where almacen_tiene_articulo.reabastecimiento_solicitado='1' and articulo.articulo_eliminado='0';

CREATE VIEW `vista_articulos_todos` AS
	SELECT articulo.id_articulo as código, articulo.descripcion, articulo.marca, articulo.precio_cliente as precio, almacen_tiene_articulo.cantidad_articulo_disponible as cantidad_disponible
	from articulo
	JOIN almacen_tiene_articulo 
	ON articulo.id_articulo = almacen_tiene_articulo.articulo_id_articulo     
	where articulo.articulo_eliminado='0';



