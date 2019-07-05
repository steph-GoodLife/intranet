-- MySQL Script generated by MySQL Workbench
-- Mon Jun 17 15:21:21 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema intranetv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema intranetv2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `intranetv2` DEFAULT CHARACTER SET utf8 ;
USE `intranetv2` ;

-- -----------------------------------------------------
-- Table `intranetv2`.`lutilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`lutilisateur` (
  `idlutilisateur` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lenomutilisateur` VARCHAR(80) NOT NULL,
  `lemotdepasse` VARCHAR(255) NOT NULL COMMENT 'crypt with password_hash - PASSWORD_DEFAULT ',
  `lenom` VARCHAR(45) NOT NULL,
  `leprenom` VARCHAR(45) NOT NULL,
  `lemail` VARCHAR(180) NOT NULL,
  `luniqueid` CHAR(26) NOT NULL COMMENT 'create with uniqid(key,true) string(26)',
  PRIMARY KEY (`idlutilisateur`),
  UNIQUE INDEX `lenomutilisateur_UNIQUE` (`lenomutilisateur` ASC),
  UNIQUE INDEX `lemail_UNIQUE` (`lemail` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`lerole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`lerole` (
  `idlerole` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lintitule` VARCHAR(60) NOT NULL,
  `ladescription` VARCHAR(300) NULL,
  PRIMARY KEY (`idlerole`),
  UNIQUE INDEX `intitule_UNIQUE` (`lintitule` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`utilisateur_has_lerole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`utilisateur_has_lerole` (
  `lutilisateur_idutilisateur` INT UNSIGNED NOT NULL,
  `lerole_idlerole` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`lutilisateur_idutilisateur`, `lerole_idlerole`),
  INDEX `fk_utilisateur_has_lerole_lerole1_idx` (`lerole_idlerole` ASC),
  INDEX `fk_utilisateur_has_lerole_utilisateur_idx` (`lutilisateur_idutilisateur` ASC),
  CONSTRAINT `fk_utilisateur_has_lerole_utilisateur`
    FOREIGN KEY (`lutilisateur_idutilisateur`)
    REFERENCES `intranetv2`.`lutilisateur` (`idlutilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_utilisateur_has_lerole_lerole1`
    FOREIGN KEY (`lerole_idlerole`)
    REFERENCES `intranetv2`.`lerole` (`idlerole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`ledroit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`ledroit` (
  `idledroit` INT UNSIGNED NOT NULL,
  `lintitule` VARCHAR(60) NOT NULL,
  `ladescription` VARCHAR(300) NULL,
  PRIMARY KEY (`idledroit`),
  UNIQUE INDEX `theintitule_UNIQUE` (`lintitule` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`lerole_has_ledroit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`lerole_has_ledroit` (
  `lerole_idlerole` SMALLINT UNSIGNED NOT NULL,
  `ledroit_idledroit` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`lerole_idlerole`, `ledroit_idledroit`),
  INDEX `fk_lerole_has_ledroit_ledroit1_idx` (`ledroit_idledroit` ASC),
  INDEX `fk_lerole_has_ledroit_lerole1_idx` (`lerole_idlerole` ASC),
  CONSTRAINT `fk_lerole_has_ledroit_lerole1`
    FOREIGN KEY (`lerole_idlerole`)
    REFERENCES `intranetv2`.`lerole` (`idlerole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lerole_has_ledroit_ledroit1`
    FOREIGN KEY (`ledroit_idledroit`)
    REFERENCES `intranetv2`.`ledroit` (`idledroit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`lafiliere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`lafiliere` (
  `idlafiliere` TINYINT(3) UNSIGNED NOT NULL,
  `lenom` VARCHAR(45) NULL,
  `lacronyme` VARCHAR(45) NULL,
  `lacouleur` VARCHAR(45) NULL,
  `lepicto` VARCHAR(45) NULL,
  PRIMARY KEY (`idlafiliere`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`lasession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`lasession` (
  `idlasession` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lenom` VARCHAR(45) NULL,
  `lacronyme` VARCHAR(45) NULL,
  `lannee` YEAR(4) NULL,
  `lenumero` TINYINT(1) UNSIGNED NULL,
  `letype` TINYINT(1) UNSIGNED NULL,
  `debut` DATE NULL,
  `fin` DATE NULL,
  `lafiliere_idfiliere` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`idlasession`, `lafiliere_idfiliere`),
  INDEX `fk_session_filiere1_idx` (`lafiliere_idfiliere` ASC),
  CONSTRAINT `fk_session_filiere1`
    FOREIGN KEY (`lafiliere_idfiliere`)
    REFERENCES `intranetv2`.`lafiliere` (`idlafiliere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranetv2`.`linscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranetv2`.`linscription` (
  `idlinscription` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `debut` DATE NULL,
  `fin` DATE NULL,
  `utilisateur_idutilisateur` INT UNSIGNED NOT NULL,
  `lasession_idsession` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idlinscription`, `utilisateur_idutilisateur`, `lasession_idsession`),
  INDEX `fk_inscription_utilisateur1_idx` (`utilisateur_idutilisateur` ASC),
  INDEX `fk_inscription_session1_idx` (`lasession_idsession` ASC),
  CONSTRAINT `fk_inscription_utilisateur1`
    FOREIGN KEY (`utilisateur_idutilisateur`)
    REFERENCES `intranetv2`.`lutilisateur` (`idlutilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscription_session1`
    FOREIGN KEY (`lasession_idsession`)
    REFERENCES `intranetv2`.`lasession` (`idlasession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;