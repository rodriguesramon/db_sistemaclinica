-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema clinicasistema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinicasistema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinicasistema` DEFAULT CHARACTER SET utf8 ;
USE `clinicasistema` ;

-- -----------------------------------------------------
-- Table `clinicasistema`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`estado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  `sigla` VARCHAR(5) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`cidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idEstado` INT(11) NULL DEFAULT NULL,
  `descricao` VARCHAR(50) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idEstado` (`idEstado` ASC) VISIBLE,
  CONSTRAINT `cidade_ibfk_1`
    FOREIGN KEY (`idEstado`)
    REFERENCES `clinicasistema`.`estado` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`especialidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`medico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idEspecialidade` INT(11) NULL DEFAULT NULL,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  `crm` VARCHAR(20) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idEspecialidade` (`idEspecialidade` ASC) VISIBLE,
  CONSTRAINT `medico_ibfk_1`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `clinicasistema`.`especialidade` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`paciente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idCidade` INT(11) NULL DEFAULT NULL,
  `nome` INT(11) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idCidade` (`idCidade` ASC) VISIBLE,
  CONSTRAINT `paciente_ibfk_1`
    FOREIGN KEY (`idCidade`)
    REFERENCES `clinicasistema`.`cidade` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`consulta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idMedico` INT(11) NULL DEFAULT NULL,
  `idPaciente` INT(11) NULL DEFAULT NULL,
  `obs` VARCHAR(200) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idMedico` (`idMedico` ASC) VISIBLE,
  INDEX `idPaciente` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `consulta_ibfk_1`
    FOREIGN KEY (`idMedico`)
    REFERENCES `clinicasistema`.`medico` (`id`),
  CONSTRAINT `consulta_ibfk_2`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `clinicasistema`.`paciente` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`tipoExame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`tipoExame` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(80) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `clinicasistema`.`exame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicasistema`.`exame` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idConsulta` INT(11) NULL DEFAULT NULL,
  `idTipoExame` INT(11) NULL DEFAULT NULL,
  `obs` VARCHAR(200) NULL DEFAULT NULL,
  `dtCadastro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idConsulta` (`idConsulta` ASC) VISIBLE,
  INDEX `exame_ibfk_2_idx` (`idTipoExame` ASC) VISIBLE,
  CONSTRAINT `exame_ibfk_1`
    FOREIGN KEY (`idConsulta`)
    REFERENCES `clinicasistema`.`consulta` (`id`),
  CONSTRAINT `exame_ibfk_2`
    FOREIGN KEY (`idTipoExame`)
    REFERENCES `clinicasistema`.`tipoExame` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
