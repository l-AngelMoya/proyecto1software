-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SISTEMA LINEA BLANCA SA 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SISTEMA LINEA BLANCA SA 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_bd_linea_blanca` DEFAULT CHARACTER SET utf8 ;
USE `sistema_bd_linea_blanca` ;

-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Empleado` (
  `num_cedula` VARCHAR(10) NOT NULL,
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
-- Table `sistema_bd_linea_blanca`.`Local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Local` (
  `idLocal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NULL,
  `es_matriz` TINYINT NULL,
  `es_bodega` TINYINT NULL,
  `fecha_creacion` DATETIME NULL,
  `fecha_ultima_modificacion` DATETIME NULL,
  `local_eliminado` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idLocal`),
  UNIQUE INDEX `idLocal_UNIQUE` (`idLocal` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`directorio_telefonico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`directorio_telefonico` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `num_telefono` VARCHAR(13) NULL,
  `ClienteCiudadano_num_cedula` CHAR(10) NULL,
  `ClienteEmpresa_RUC` CHAR(14) NULL,
  `Empleado_num_cedula` VARCHAR(10) NULL,
  `Local_idLocal` INT NULL,
  `telefono_eliminado` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_telefono`),
  INDEX `fk_directorio_telefonico_ClienteCiudadano_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_directorio_telefonico_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_directorio_telefonico_Empleado1_idx` (`Empleado_num_cedula` ASC),
  INDEX `fk_directorio_telefonico_Local1_idx` (`Local_idLocal` ASC),
  CONSTRAINT `fk_directorio_telefonico_ClienteCiudadano`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `mydb`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `mydb`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `mydb`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directorio_telefonico_Local1`
    FOREIGN KEY (`Local_idLocal`)
    REFERENCES `mydb`.`Local` (`idLocal`)
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
  `Empleado_num_cedula` VARCHAR(10) NOT NULL,
  `cotizacion_eliminada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_cotizacion`),
  UNIQUE INDEX `id_cotizacion_UNIQUE` (`id_cotizacion` ASC),
  INDEX `fk_cotizacion_ClienteCiudadano1_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_cotizacion_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_cotizacion_Empleado1_idx` (`Empleado_num_cedula` ASC),
  CONSTRAINT `fk_cotizacion_ClienteCiudadano1`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `mydb`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `mydb`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `mydb`.`Empleado` (`num_cedula`)
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
    REFERENCES `mydb`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_has_articulo_articulo1`
    FOREIGN KEY (`articulo_id_articulo`)
    REFERENCES `mydb`.`articulo` (`id_articulo`)
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
    REFERENCES `mydb`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cotizacion_has_forma_de_pago_forma_de_pago1`
    FOREIGN KEY (`forma_de_pago_id_forma_de_pago`)
    REFERENCES `mydb`.`forma_de_pago` (`id_forma_de_pago`)
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
  `Empleado_num_cedula` VARCHAR(10) NOT NULL,
  `compra_eliminada` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_compra`),
  UNIQUE INDEX `id_venta_UNIQUE` (`id_compra` ASC),
  INDEX `fk_compra_ClienteEmpresa1_idx` (`ClienteEmpresa_RUC` ASC),
  INDEX `fk_compra_ClienteCiudadano1_idx` (`ClienteCiudadano_num_cedula` ASC),
  INDEX `fk_compra_Empleado1_idx` (`Empleado_num_cedula` ASC),
  CONSTRAINT `fk_compra_ClienteEmpresa1`
    FOREIGN KEY (`ClienteEmpresa_RUC`)
    REFERENCES `mydb`.`ClienteEmpresa` (`RUC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_ClienteCiudadano1`
    FOREIGN KEY (`ClienteCiudadano_num_cedula`)
    REFERENCES `mydb`.`ClienteCiudadano` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `mydb`.`Empleado` (`num_cedula`)
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
    REFERENCES `mydb`.`forma_de_pago` (`id_forma_de_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forma_de_pago_has_compra_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `mydb`.`compra` (`id_compra`)
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
    REFERENCES `mydb`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_has_compra_compra1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `mydb`.`compra` (`id_compra`)
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
    REFERENCES `mydb`.`Local` (`idLocal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Local_has_Empleado_Empleado1`
    FOREIGN KEY (`Empleado_num_cedula`)
    REFERENCES `mydb`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_bd_linea_blanca`.`Local_almacena_articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_bd_linea_blanca`.`Local_almacena_articulo` (
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
    REFERENCES `mydb`.`Local` (`idLocal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Local_has_articulo_articulo1`
    FOREIGN KEY (`articulo_id_articulo`)
    REFERENCES `mydb`.`articulo` (`id_articulo`)
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
  `Empleado_num_cedula1` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_transaccion`, `Empleado_num_cedula1`),
  INDEX `fk_Log_Empleado2_idx` (`Empleado_num_cedula1` ASC),
  CONSTRAINT `fk_Log_Empleado2`
    FOREIGN KEY (`Empleado_num_cedula1`)
    REFERENCES `mydb`.`Empleado` (`num_cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
