-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gc3928_univ_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gc3928_univ_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gc3928_univ_db` DEFAULT CHARACTER SET utf8 ;
USE `gc3928_univ_db` ;

-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`DEPARTMENT` (
  `idDEPARTMENT` INT NOT NULL AUTO_INCREMENT,
  `dep_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDEPARTMENT`),
  UNIQUE INDEX `idDEPARTMENT_UNIQUE` (`idDEPARTMENT` ASC) VISIBLE,
  UNIQUE INDEX `dep_name_UNIQUE` (`dep_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`STUDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`STUDENT` (
  `idSTUDENT` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `admit_year` YEAR NOT NULL,
  `birthday` DATE NOT NULL,
  `DEPARTMENT_idDEPARTMENT` INT NOT NULL,
  PRIMARY KEY (`idSTUDENT`),
  UNIQUE INDEX `idSTUDENT_UNIQUE` (`idSTUDENT` ASC) VISIBLE,
  INDEX `fk_STUDENT_DEPARTMENT1_idx` (`DEPARTMENT_idDEPARTMENT` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENT_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_idDEPARTMENT`)
    REFERENCES `gc3928_univ_db`.`DEPARTMENT` (`idDEPARTMENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`PROFESSOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`PROFESSOR` (
  `idPROFESSOR` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `office_room` INT NULL,
  `start_office_hours` TIME NULL,
  `dur_office_hours` DECIMAL(10,2) NULL,
  `DEPARTMENT_idDEPARTMENT` INT NOT NULL,
  PRIMARY KEY (`idPROFESSOR`),
  UNIQUE INDEX `idPROFESSOR_UNIQUE` (`idPROFESSOR` ASC) VISIBLE,
  INDEX `fk_PROFESSOR_DEPARTMENT1_idx` (`DEPARTMENT_idDEPARTMENT` ASC) VISIBLE,
  CONSTRAINT `fk_PROFESSOR_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_idDEPARTMENT`)
    REFERENCES `gc3928_univ_db`.`DEPARTMENT` (`idDEPARTMENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`COURSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`COURSES` (
  `idCOURSES` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCOURSES`),
  UNIQUE INDEX `idCOURSES_UNIQUE` (`idCOURSES` ASC) VISIBLE,
  UNIQUE INDEX `course_name_UNIQUE` (`course_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`CLASSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`CLASSES` (
  `idCLASS` INT NOT NULL AUTO_INCREMENT,
  `section` INT(4) NOT NULL,
  `semester` VARCHAR(10) NOT NULL,
  `Year` YEAR NOT NULL,
  `day` VARCHAR(45) NOT NULL,
  `class_length` DECIMAL(10,2) NOT NULL,
  `start_time` TIME NOT NULL,
  `PROFESSOR_idPROFESSOR` INT NOT NULL,
  `COURSES_idCOURSES` INT NOT NULL,
  PRIMARY KEY (`idCLASS`, `COURSES_idCOURSES`),
  INDEX `fk_CLASSES_PROFESSOR1_idx` (`PROFESSOR_idPROFESSOR` ASC) VISIBLE,
  INDEX `fk_CLASSES_COURSES1_idx` (`COURSES_idCOURSES` ASC) VISIBLE,
  CONSTRAINT `fk_CLASSES_PROFESSOR1`
    FOREIGN KEY (`PROFESSOR_idPROFESSOR`)
    REFERENCES `gc3928_univ_db`.`PROFESSOR` (`idPROFESSOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CLASSES_COURSES1`
    FOREIGN KEY (`COURSES_idCOURSES`)
    REFERENCES `gc3928_univ_db`.`COURSES` (`idCOURSES`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`Final_Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`Final_Grade` (
  `course_id` INT NOT NULL,
  `semester` VARCHAR(10) NULL,
  `year` YEAR NULL,
  `grade` VARCHAR(5) NULL,
  `section` INT NULL,
  `STUDENT_idSTUDENT` INT NOT NULL,
  PRIMARY KEY (`STUDENT_idSTUDENT`),
  CONSTRAINT `fk_Final_Grade_STUDENT1`
    FOREIGN KEY (`STUDENT_idSTUDENT`)
    REFERENCES `gc3928_univ_db`.`STUDENT` (`idSTUDENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gc3928_univ_db`.`ENROLLED`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gc3928_univ_db`.`ENROLLED` (
  `STUDENT_idSTUDENT` INT NOT NULL,
  `COURSES_idCOURSES` INT NOT NULL,
  `section_id` INT NULL,
  `semester` VARCHAR(10) NULL,
  `CLASSES_idCLASS` INT NOT NULL,
  PRIMARY KEY (`STUDENT_idSTUDENT`, `COURSES_idCOURSES`),
  INDEX `fk_STUDENT_has_COURSES_COURSES1_idx` (`COURSES_idCOURSES` ASC) VISIBLE,
  INDEX `fk_STUDENT_has_COURSES_STUDENT1_idx` (`STUDENT_idSTUDENT` ASC) VISIBLE,
  INDEX `fk_ENROLLED_CLASSES1_idx` (`CLASSES_idCLASS` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENT_has_COURSES_STUDENT1`
    FOREIGN KEY (`STUDENT_idSTUDENT`)
    REFERENCES `gc3928_univ_db`.`STUDENT` (`idSTUDENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STUDENT_has_COURSES_COURSES1`
    FOREIGN KEY (`COURSES_idCOURSES`)
    REFERENCES `gc3928_univ_db`.`COURSES` (`idCOURSES`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENROLLED_CLASSES1`
    FOREIGN KEY (`CLASSES_idCLASS`)
    REFERENCES `gc3928_univ_db`.`CLASSES` (`idCLASS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
