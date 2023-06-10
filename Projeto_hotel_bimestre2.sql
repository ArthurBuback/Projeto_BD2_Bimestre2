-- MySQL Script generated by MySQL Workbench
-- Thu Jun  8 19:04:34 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Rede de Hoteis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- QUESTÃO 1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel` (
  `id_hotel` INT NOT NULL AUTO_INCREMENT,
  `hotel_nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `quantidade_quartos` INT NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `estrelas` INT NOT NULL,
  PRIMARY KEY (`id_hotel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cargo` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nome_cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionario` (
  `cpf_func` INT NOT NULL AUTO_INCREMENT,
  `primeiro_nome` VARCHAR(10) NOT NULL,
  `ultimo_nome` VARCHAR(10) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `salário` DECIMAL(10,2) NOT NULL,
  `celular` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `hotel_id_hotel` INT NOT NULL,
  `cargo_id_cargo` INT NOT NULL,
  PRIMARY KEY (`cpf_func`),
  INDEX `fk_funcionario_hotel1_idx` (`hotel_id_hotel` ASC) VISIBLE,
  INDEX `fk_funcionario_cargo1_idx` (`cargo_id_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_hotel1`
    FOREIGN KEY (`hotel_id_hotel`)
    REFERENCES `hotel` (`id_hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_id_cargo`)
    REFERENCES `cargo` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dependentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dependentes` (
  `cpf_dependente` INT NOT NULL AUTO_INCREMENT,
  `funcionario_cpf_func` INT NULL,
  `sexo` CHAR(1) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`cpf_dependente`, `funcionario_cpf_func`),
  INDEX `fk_dependentes_funcionario1_idx` (`funcionario_cpf_func` ASC) VISIBLE,
  CONSTRAINT `fk_dependentes_funcionario1`
    FOREIGN KEY (`funcionario_cpf_func`)
    REFERENCES `funcionario` (`cpf_func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipo_quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_quarto` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `quantidade_camas` INT NOT NULL,
  `qualidade` INT NOT NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quarto` (
  `numero_quarto` INT NOT NULL AUTO_INCREMENT,
  `hotel_id_hotel` INT NOT NULL,
  `disponibilidade` CHAR(1) NOT NULL,
  `tipo_quarto_id_tipo` INT NOT NULL,
  PRIMARY KEY (`numero_quarto`, `hotel_id_hotel`),
  INDEX `fk_quarto_hotel1_idx` (`hotel_id_hotel` ASC) VISIBLE,
  INDEX `fk_quarto_tipo_quarto1_idx` (`tipo_quarto_id_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_quarto_hotel1`
    FOREIGN KEY (`hotel_id_hotel`)
    REFERENCES `hotel` (`id_hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_quarto_tipo_quarto1`
    FOREIGN KEY (`tipo_quarto_id_tipo`)
    REFERENCES `tipo_quarto` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `primeiro_nome` VARCHAR(45) NOT NULL,
  `nome_meio` CHAR(1) NOT NULL,
  `ultimo_nome` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `celular` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valor` (
  `calculo_valor` INT NOT NULL,
  `valor_base` INT NOT NULL,
  `serviço_de_quarto` INT NULL,
  `consumiveis` INT NULL,
  `tipo_quarto_id_tipo` INT NOT NULL,
  PRIMARY KEY (`calculo_valor`),
  INDEX `fk_valor_tipo_quarto1_idx` (`tipo_quarto_id_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_valor_tipo_quarto1`
    FOREIGN KEY (`tipo_quarto_id_tipo`)
    REFERENCES `tipo_quarto` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `dia_reserva` VARCHAR(45) NULL,
  `dia_entrada` VARCHAR(45) NOT NULL,
  `dia_saída` VARCHAR(45) NOT NULL,
  `hotel_id_hotel` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `valor_calculo_valor` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_hotel1_idx` (`hotel_id_hotel` ASC) VISIBLE,
  INDEX `fk_reserva_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_reserva_valor1_idx` (`valor_calculo_valor` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_hotel1`
    FOREIGN KEY (`hotel_id_hotel`)
    REFERENCES `hotel` (`id_hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_valor1`
    FOREIGN KEY (`valor_calculo_valor`)
    REFERENCES `valor` (`calculo_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- -----------------------------------------------------
-- QUESTÃO 2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `funcionario`
-- -----------------------------------------------------
INSERT INTO `funcionario` (`cpf_func`,`primeiro_nome`,`ultimo_nome`,`data_nascimento`,`sexo`,`salário`,`celular`,`email`)
VALUES
  ("10166085458","Buffy","Cunningham","1993-10-24","H","63 365","(46)25348-9954","buffy6799@hotmail.com"),
  ("34632625534","Melissa","Hartman","1991-07-18","H","32 396","(67)72234-1806","melissa750@icloud.com"),
  ("51226637949","Tasha","Mccall","1985-12-08","M","68 530","(33)41136-3928","tasha@hotmail.com"),
  ("21553585256","Benjamin","Knowles","1977-04-10","M","2 766","(49)77561-1221","benjamin@hotmail.com"),
  ("73288326247","Prescott","Owens","1970-11-01","H","81 896","(65)54623-8295","prescott@google.com"),
  ("94939874225","Xyla","Rasmussen","1973-09-03","H","76 697","(97)74442-4364","xyla2971@icloud.com"),
  ("40571813886","Kevyn","Holt","1990-10-19","H","23 779","(38)76954-3559","kevyn6907@icloud.com"),
  ("34283570181","Hashim","Pate","1980-06-16","M","75 235","(58)48076-2013","hashim@icloud.com"),
  ("61765680788","Fleur","Randolph","1975-08-30","M","23 780","(31)31514-7805","fleur@outlook.com"),
  ("17481213950","Lyle","Tyson","1989-02-16","H","77 787","(54)81759-7162","lyle@hotmail.com"),
  ("18792978824","Channing","Melton","1982-03-24","H","40 568","(68)54897-6653","channing4483@google.com"),
  ("11112753173","Kirby","Cohen","1993-07-14","H","80 654","(82)48932-5123","kirby@outlook.com"),
  ("21545262462","Gwendolyn","Wilcox","1999-09-04","M","44 308","(26)47885-7853","gwendolyn345@hotmail.com"),
  ("48468543335","Anthony","Dunlap","1987-03-30","M","9 086","(93)45913-4594","anthony@outlook.com"),
  ("53908381126","Seth","Harmon","1979-09-10","H","70 655","(70)26668-2699","seth1741@google.com");
