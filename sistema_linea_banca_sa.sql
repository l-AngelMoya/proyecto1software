-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sistema_bd_linea_blanca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sistema_bd_linea_blanca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_bd_linea_blanca` DEFAULT CHARACTER SET utf8 ;
USE `sistema_bd_linea_blanca` ;

-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Empleado` (
  `num_cedula` CHAR(10) NOT NULL,
  `nombre` VARCHAR(250) NULL,
  `apellido` VARCHAR(250) NULL,
  `usuario` VARCHAR(64) NULL,
  `contraseña` VARCHAR(16) NULL,
  `empleado_eliminado` VARCHAR(45) NULL,
  PRIMARY KEY (`num_cedula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`ClienteCiudadano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`ClienteCiudadano` (
  `num_cedula` CHAR(10) NOT NULL,
  `nombre_persona` VARCHAR(250) NULL,
  `apellido_persona` VARCHAR(250) NULL,
  `direccion_persona` VARCHAR(250) NOT NULL,
  `ciudadano_eliminado` VARCHAR(45) NULL DEFAULT 0,
  PRIMARY KEY (`num_cedula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`ClienteEmpresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`ClienteEmpresa` (
  `RUC` CHAR(14) NOT NULL,
  `nombre_empresa` VARCHAR(250) NULL,
  `direccion_empresa` VARCHAR(250) NULL,
  `empresa_eliminada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`RUC`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`almacen` (
  `id_almacen` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NULL,
  `es_matriz` TINYINT NULL,
  `es_bodega` TINYINT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_ultima_modificacion` DATETIME NULL,
  `local_eliminado` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_almacen`),
  UNIQUE INDEX `idLocal_UNIQUE` (`id_almacen` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`directorio_telefonico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`directorio_telefonico` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `num_telefono` VARCHAR(13) NULL,
  `ClienteCiudadano_num_cedula` CHAR(10) NOT NULL DEFAULT 'null',
  `ClienteEmpresa_RUC` CHAR(14) NOT NULL DEFAULT 'null',
  `Empleado_num_cedula` VARCHAR(10) NOT NULL DEFAULT 'null',
  `Local_idLocal` INT UNSIGNED NOT NULL DEFAULT '0',
  `telefono_eliminado` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_telefono`),
  INDEX `fk_directorio_telefonico_ClienteCiudadano_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_directorio_telefonico_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_directorio_telefonico_Empleado1_idx` (`Empleado_num_cedula` ASC),
  INDEX `fk_directorio_telefonico_Local1_idx` (`Local_idLocal` ASC),
  CONSTRAINT `fk_directorio_telefonico_ClienteCiudadano`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_Local1`
    FOREIGN KEY (`Local_idLocal`)
    REFERENCES `sistema_bd_linea_blanca`.`almacen` (`id_almacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`cotizacion` (
  `id_cotizacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_hora_cotizacion` DATETIME NULL,
  `monto_estimado` FLOAT NULL,
  `ClienteCiudadano_num_cedula` CHAR(10) NULL,
  `ClienteEmpresa_RUC` CHAR(14) NULL,
  `Empleado_num_cedula` CHAR(10) NOT NULL,
  `cotizacion_eliminada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_cotizacion`),
  UNIQUE INDEX `id_cotizacion_UNIQUE` (`id_cotizacion` ASC),
  INDEX `fk_cotizacion_ClienteCiudadano1_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_cotizacion_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_cotizacion_Empleado1_idx` (`Empleado_num_cedula` ASC),
  CONSTRAINT `fk_cotizacion_ClienteCiudadano1`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`articulo` (
  `id_articulo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  `categoria` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  `precio_cliente` FLOAT UNSIGNED NULL,
  `costo_proveedor` FLOAT UNSIGNED NULL,
  `articulo_eliminado` VARCHAR(45) NULL,
  PRIMARY KEY (`id_articulo`),
  UNIQUE INDEX `id_articulo_UNIQUE` (`id_articulo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`articulos_asociados_cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`articulos_asociados_cotizacion` (
  `cotizacion_id_cotizacion` INT UNSIGNED NOT NULL,
  `articulo_id_articulo` INT UNSIGNED NOT NULL,
  `cantidad_articulo` INT NOT NULL,
  PRIMARY KEY (`cotizacion_id_cotizacion`, `articulo_id_articulo`),
  INDEX `fk_cotizacion_has_articulo_articulo1_idx` (`articulo_id_articulo` ASC),
  INDEX `fk_cotizacion_has_articulo_cotizacion1_idx` (`cotizacion_id_cotizacion` ASC),
  CONSTRAINT `fk_cotizacion_has_articulo_cotizacion1`
    FOREIGN KEY (`cotizacion_id_cotizacion`)
    REFERENCES `sistema_bd_linea_blanca`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_has_articulo_articulo1`
    FOREIGN KEY (`articulo_id_articulo`)
    REFERENCES `sistema_bd_linea_blanca`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`forma_de_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`forma_de_pago` (
  `id_forma_de_pago` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_forma_de_pago` VARCHAR(45) NULL,
  `tasa_forma_de_pago` FLOAT NULL,
  PRIMARY KEY (`id_forma_de_pago`),
  UNIQUE INDEX `id_forma_de_pago_UNIQUE` (`id_forma_de_pago` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`forma_de_pago_asociada_cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`forma_de_pago_asociada_cotizacion` (
  `cotizacion_id_cotizacion` INT UNSIGNED NOT NULL,
  `forma_de_pago_id_forma_de_pago` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cotizacion_id_cotizacion`, `forma_de_pago_id_forma_de_pago`),
  INDEX `fk_cotizacion_has_forma_de_pago_forma_de_pago1_idx` (`forma_de_pago_id_forma_de_pago` ASC),
  INDEX `fk_cotizacion_has_forma_de_pago_cotizacion1_idx` (`cotizacion_id_cotizacion` ASC),
  CONSTRAINT `fk_cotizacion_has_forma_de_pago_cotizacion1`
    FOREIGN KEY (`cotizacion_id_cotizacion`)
    REFERENCES `sistema_bd_linea_blanca`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_has_forma_de_pago_forma_de_pago1`
    FOREIGN KEY (`forma_de_pago_id_forma_de_pago`)
    REFERENCES `sistema_bd_linea_blanca`.`forma_de_pago` (`id_forma_de_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`compra` (
  `id_compra` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_hora_compra` DATETIME NULL,
  `ClienteEmpresa_RUC` CHAR(14) NULL,
  `ClienteCiudadano_num_cedula` CHAR(10) NULL,
  `monto` FLOAT NULL,
  `Empleado_num_cedula` CHAR(10) NOT NULL,
  `compra_eliminada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_compra`),
  UNIQUE INDEX `id_venta_UNIQUE` (`id_compra` ASC),
  INDEX `fk_compra_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_compra_ClienteCiudadano1_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_compra_Empleado1_idx` (`Empleado_num_cedula` ASC),
  CONSTRAINT `fk_compra_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_ClienteCiudadano1`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`forma_de_pago_asociado_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`forma_de_pago_asociado_compra` (
  `forma_de_pago_id_forma_de_pago` INT UNSIGNED NOT NULL,
  `compra_id_compra` INT UNSIGNED NOT NULL,
  `pago_verificado` TINYINT NULL,
  PRIMARY KEY (`forma_de_pago_id_forma_de_pago`, `compra_id_compra`),
  INDEX `fk_forma_de_pago_has_compra_compra1_idx` (`compra_id_compra` ASC),
  INDEX `fk_forma_de_pago_has_compra_forma_de_pago1_idx` (`forma_de_pago_id_forma_de_pago` ASC),
  CONSTRAINT `fk_forma_de_pago_has_compra_forma_de_pago1`
    FOREIGN KEY (`forma_de_pago_id_forma_de_pago`)
    REFERENCES `sistema_bd_linea_blanca`.`forma_de_pago` (`id_forma_de_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forma_de_pago_has_compra_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `sistema_bd_linea_blanca`.`compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`articulo_asociado_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`articulo_asociado_compra` (
  `articulo_id_articulo` INT UNSIGNED NOT NULL,
  `compra_id_compra` INT UNSIGNED NOT NULL,
  `cantidad_articulo` INT NULL,
  PRIMARY KEY (`articulo_id_articulo`, `compra_id_compra`),
  INDEX `fk_articulo_has_compra_compra1_idx` (`compra_id_compra` ASC),
  INDEX `fk_articulo_has_compra_articulo1_idx` (`articulo_id_articulo` ASC),
  CONSTRAINT `fk_articulo_has_compra_articulo1`
    FOREIGN KEY (`articulo_id_articulo`)
    REFERENCES `sistema_bd_linea_blanca`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_has_compra_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `sistema_bd_linea_blanca`.`compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`Empleado_asociado_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Empleado_asociado_local` (
  `Local_idLocal` INT UNSIGNED NOT NULL,
  `Empleado_num_cedula` VARCHAR(10) NOT NULL,
  `fecha_contratacion` DATETIME NULL,
  `fecha_despido_renuncia` DATETIME NULL,
  `cargo_actual_empleado` DATETIME NULL,
  `empleado_activo` TINYINT NULL,
  PRIMARY KEY (`Local_idLocal`, `Empleado_num_cedula`),
  INDEX `fk_Local_has_Empleado_Empleado1_idx` (`Empleado_num_cedula` ASC),
  INDEX `fk_Local_has_Empleado_Local1_idx` (`Local_idLocal` ASC),
  CONSTRAINT `fk_Local_has_Empleado_Local1`
    FOREIGN KEY (`Local_idLocal`)
    REFERENCES `sistema_bd_linea_blanca`.`almacen` (`id_almacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Local_has_Empleado_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`almacen_tiene_articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`almacen_tiene_articulo` (
  `Local_idLocal` INT UNSIGNED NOT NULL,
  `articulo_id_articulo` INT UNSIGNED NOT NULL,
  `fecha_llegada_articulo` VARCHAR(45) NULL,
  `cantidad_articulo_disponible` VARCHAR(45) NULL,
  `reabastecimiento_solicitado` VARCHAR(45) NULL,
  PRIMARY KEY (`Local_idLocal`, `articulo_id_articulo`),
  INDEX `fk_Local_has_articulo_articulo1_idx` (`articulo_id_articulo` ASC),
  INDEX `fk_Local_has_articulo_Local1_idx` (`Local_idLocal` ASC),
  CONSTRAINT `fk_Local_has_articulo_Local1`
    FOREIGN KEY (`Local_idLocal`)
    REFERENCES `sistema_bd_linea_blanca`.`almacen` (`id_almacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Local_has_articulo_articulo1`
    FOREIGN KEY (`articulo_id_articulo`)
    REFERENCES `sistema_bd_linea_blanca`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`comprobante_de_retencion_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`comprobante_de_retencion_cliente` (
  `id_comprobante_de_retencion` INT NOT NULL,
  `numero_autorizacion` VARCHAR(45) NOT NULL,
  `tipo_comprobante_venta` VARCHAR(45) NOT NULL,
  `valor_retenido` FLOAT NOT NULL,
  `tipo_de_impuesto` VARCHAR(45) NOT NULL,
  `ejercicio_fiscal` VARCHAR(250) NOT NULL,
  `codigo_del_impuesto` VARCHAR(45) NOT NULL,
  `porcentaje_de_retencion` INT NOT NULL,
  `compra_id_compra` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_comprobante_de_retencion`),
  INDEX `fk_comprobante_de_retencion_cliente_compra1_idx` (`compra_id_compra` ASC),
  UNIQUE INDEX `compra_id_compra_UNIQUE` (`compra_id_compra` ASC),
  CONSTRAINT `fk_comprobante_de_retencion_cliente_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `sistema_bd_linea_blanca`.`compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Log` (
  `id_transaccion` INT NOT NULL AUTO_INCREMENT,
  `fechahora_transaccion` DATETIME NOT NULL,
  `tipo_transaccion` VARCHAR(250) NOT NULL,
  `tipo_accion` VARCHAR(45) NOT NULL,
  `cotizacion_id_cotizacion` INT UNSIGNED NULL DEFAULT NULL,
  `compra_id_compra` INT UNSIGNED NULL DEFAULT NULL,
  `ClienteCiudadano_num_cedula` CHAR(10) NULL DEFAULT '9999999999',
  `ClienteEmpresa_RUC` CHAR(14) NULL DEFAULT '99999999999999',
  `Empleado_num_cedula` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  INDEX `fk_Log_cotizacion1_idx` (`cotizacion_id_cotizacion` ASC),
  INDEX `fk_Log_compra1_idx` (`compra_id_compra` ASC),
  INDEX `fk_Log_ClienteCiudadano1_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_Log_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_Log_Empleado1_idx` (`Empleado_num_cedula` ASC),
  CONSTRAINT `fk_Log_cotizacion1`
    FOREIGN KEY (`cotizacion_id_cotizacion`)
    REFERENCES `sistema_bd_linea_blanca`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Log_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `sistema_bd_linea_blanca`.`compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Log_ClienteCiudadano1`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Log_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `sistema_bd_linea_blanca`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Log_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `sistema_bd_linea_blanca`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#vistas de inventario
CREATE VIEW `vista_articulos_disponibles` AS  
	SELECT articulo.id_articulo as código, articulo.descripcion, articulo.marca, articulo.precio_cliente as precio, almacen_tiene_articulo.cantidad_articulo_disponible as cantidad_disponible
	from articulo
	JOIN almacen_tiene_articulo 
	ON articulo.id_articulo= almacen_tiene_articulo.articulo_id_articulo     
	where almacen_tiene_articulo.reabastecimiento_solicitado='0' and articulo.articulo_eliminado='0';

CREATE VIEW `vista_articulos_solicitados` AS  
	SELECT articulo.id_articulo as código, articulo.descripcion, articulo.marca, articulo.precio_cliente as precio
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
    
#vista de log

CREATE VIEW `vista_log_por_empleado` AS
	SELECT log.id_transaccion as id, log.fechahora_transaccion as fecha, log.tipo_transaccion as transaccion, log.tipo_accion as accion_realizada, concat(empleado.nombre,' ',empleado.apellido) as empleado, empleado.usuario as usuario, cotizacion_id_cotizacion as cotizacion_modificada, compra_id_compra as compra_modificada, ClienteCiudadano_num_cedula as cedula_cpersona_modificado, ClienteEmpresa_RUC as RUC_cempresa_modificado
	from log
    join empleado
    on empleado.num_cedula=log.Empleado_num_cedula
    group by empleado.usuario
    order by log.fechahora_transaccion asc;


#usuarios


CREATE USER 'gerente_lbsa' identified by 'manager1234';
CREATE USER 'administrador_lbsa' identified by 'root1234';
CREATE USER 'vendedor_lbsa' identified by 'vendor1234';

 
 #privilegios de los usuarios
 
GRANT SELECT ON TABLE `sistema_bd_linea_blanca`.* TO 'gerente_lbsa';
GRANT SELECT, INSERT, UPDATE ON TABLE `sistema_bd_linea_blanca`.* TO 'administrador_lbsa';
GRANT SELECT, INSERT ON TABLE `sistema_bd_linea_blanca`.* TO 'vendedor_lbsa';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
