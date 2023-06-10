-- MySQL Script generated by MySQL Workbench
-- Sat Jun 10 13:21:07 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Rede de Hoteis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cargo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `quantidade_quartos` INT NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `estrelas` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `funcionario` (
  `cpf` BIGINT(11) NOT NULL,
  `primeiro_nome` VARCHAR(10) NOT NULL,
  `ultimo_nome` VARCHAR(10) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `salário` DECIMAL(10,2) NOT NULL,
  `celular` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `cargo_id` INT NOT NULL,
  `hotel_id` INT NOT NULL,
  PRIMARY KEY (`cpf`),
  INDEX `fk_funcionario_cargo1_idx` (`cargo_id` ASC) VISIBLE,
  INDEX `fk_funcionario_hotel1_idx` (`hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dependentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dependentes` (
  `cpf` BIGINT(11) NOT NULL,
  `funcionario_cpf` BIGINT(11) NOT NULL,
  `primeiro_nome` VARCHAR(10) NOT NULL,
  `ultimo_nome` VARCHAR(10) NOT NULL,
  `parentesco` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`cpf`, `funcionario_cpf`),
  INDEX `fk_dependentes_funcionario1_idx` (`funcionario_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_dependentes_funcionario1`
    FOREIGN KEY (`funcionario_cpf`)
    REFERENCES `funcionario` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipo_quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_quarto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade_camas` INT NOT NULL,
  `qualidade` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quarto` (
  `numero_quarto` INT NOT NULL AUTO_INCREMENT,
  `hotel_id` INT NULL,
  `disponibilidade` CHAR(1) NOT NULL,
  `tipo_quarto_id` INT NOT NULL,
  PRIMARY KEY (`numero_quarto`, `hotel_id`),
  INDEX `fk_quarto_hotel1_idx` (`hotel_id` ASC) VISIBLE,
  INDEX `fk_quarto_tipo_quarto1_idx` (`tipo_quarto_id` ASC) VISIBLE,
  CONSTRAINT `fk_quarto_hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_quarto_tipo_quarto1`
    FOREIGN KEY (`tipo_quarto_id`)
    REFERENCES `tipo_quarto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `cpf` BIGINT(11) NOT NULL,
  `primeiro_nome` VARCHAR(45) NOT NULL,
  `nome_meio` CHAR(1) NOT NULL,
  `ultimo_nome` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `celular` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `valor` (
  `calculo` INT NOT NULL,
  `valor_base` INT NOT NULL,
  `serviço_de_quarto` INT NULL,
  `consumiveis` INT NULL,
  `tipo_quarto_id_tipo` INT NOT NULL,
  PRIMARY KEY (`calculo`),
  INDEX `fk_valor_tipo_quarto1_idx` (`tipo_quarto_id_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_valor_tipo_quarto1`
    FOREIGN KEY (`tipo_quarto_id_tipo`)
    REFERENCES `tipo_quarto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia_reserva` DATE NULL,
  `dia_entrada` DATE NOT NULL,
  `dia_saída` DATE NOT NULL,
  `hotel_id` INT NOT NULL,
  `valor_calculo` INT NOT NULL,
  `cliente_cpf` BIGINT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reserva_hotel1_idx` (`hotel_id` ASC) VISIBLE,
  INDEX `fk_reserva_valor1_idx` (`valor_calculo` ASC) VISIBLE,
  INDEX `fk_reserva_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_valor1`
    FOREIGN KEY (`valor_calculo`)
    REFERENCES `valor` (`calculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhente` (
  `cpf` BIGINT(11) NOT NULL,
  `cliente_cpf` BIGINT(11) NOT NULL,
  `primeiro_nome` VARCHAR(10) NOT NULL,
  `ultimo_nome` VARCHAR(10) NOT NULL,
  `relacionamento` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`cpf`, `cliente_cpf`),
  INDEX `fk_acompanhente_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_acompanhente_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `cliente` (`cpf`)
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
-- Insert Table `hotel`
-- -----------------------------------------------------
INSERT INTO `hotel` (`nome`,`endereço`,`cidade`,`quantidade_quartos`,`telefone`,`estrelas`)
VALUES
  ("Topo da Montanha","939-1678 A, Road","Vitória",27,"(27)99512-8548",5),
  ("Canto da Areia","P.O. Box 680, 6315 Arcu. Ave","Vila Velha",21,"(27)99684-9735",4),
  ("A Grande Árvore","Ap #142-7472 Sed Avenue","Vila Velha",25,"(27)99871-7086",5);

-- -----------------------------------------------------
-- Insert Table `cargo`
-- -----------------------------------------------------
INSERT INTO `cargo` (`nome`)
VALUES
  ("Gerente"),
  ("Arrumeiro"),
  ("Cozinheiro"),
  ("Balconista");

-- -----------------------------------------------------
-- Insert Table `funcionario`
-- -----------------------------------------------------
INSERT INTO `funcionario` (`cpf`,`primeiro_nome`,`ultimo_nome`,`data_nascimento`,`sexo`,`salário`,`celular`,`email`,`hotel_id`,`cargo_id`)
VALUES
  (74013193060,"Buffy","Cunningham","1993-10-24","M","8365.00","(55)25348-9954","buffy6799@hotmail.com",1,1),
  (08735675012,"Melissa","Hartman","1991-07-18","F","3396.00","(55)72234-1806","melissa750@icloud.com",2,2),
  (90219558060,"Tasha","Mccall","1985-12-08","F","3530.00","(55)41136-3928","tasha@hotmail.com",1,2),
  (47165234039,"Benjamin","Knowles","1977-04-10","M","4766.00","(55)77561-1221","benjamin@hotmail.com",1,3),
  (32074964072,"Prescott","Owens","1970-11-01","M","5896.00","(55)54623-8295","prescott@google.com",1,4),
  (22619399068,"Xyla","Rasmussen","1973-09-03","F","7697.00","(55)74442-4364","xyla2971@icloud.com",2,1),
  (38601549071,"Kevyn","Holt","1990-10-19","M","3179.00","(55)76954-3559","kevyn6907@icloud.com",2,2),
  (83646555076,"Hashim","Pate","1980-06-16","M","3235.00","(55)48076-2013","hashim@icloud.com",2,2),
  (75631257017,"Fleur","Randolph","1975-08-30","F","5780.00","(55)31514-7805","fleur@outlook.com",2,3),
  (95336839027,"Lyle","Tyson","1989-02-16","F","4787.00","(55)81759-7162","lyle@hotmail.com",2,4),
  (76355444033,"Channing","Melton","1982-03-24","F","8568.00","(55)54897-6653","channing4483@google.com",3,1),
  (53256349099,"Kirby","Cohen","1993-07-14","M","3654.00","(55)48932-5123","kirby@outlook.com",3,2),
  (50428588069,"Gwendolyn","Wilcox","1999-09-04","F","3308.00","(55)47885-7853","gwendolyn345@hotmail.com",3,2),
  (33715162023,"Anthony","Dunlap","1987-03-30","M","5886.00","(55)45913-4594","anthony@outlook.com",3,3),
  (96345235016,"Seth","Harmon","1979-09-10","M","4655.00","(55)26668-2699","seth1741@google.com",3,4);
  
-- -----------------------------------------------------
-- Insert Table `dependentes`
-- -----------------------------------------------------
INSERT IGNORE INTO `dependentes` (`cpf`,`funcionario_cpf`,`primeiro_nome`,`ultimo_nome`,`parentesco`,`sexo`,`data_nascimento`)
VALUES
  (97770289033,74013193060,"Kenneth Dixon","Wade","Filho","F","2004-10-03"),
  (38192726070,74013193060,"Emi House","Patience","Filho","F","2010-01-04"),
  (31129118061,32074964072,"Amela Velez","Xander","Filho","F","2002-09-01"),
  (11185990046,08735675012,"Randall Robinson","Clarke","Filho(a)","M","2010-03-22"),
  (58920624062,08735675012,"Timon Workman","Quin","Filho(a)","M","2012-12-04"),
  (42961281083,47165234039,"Aaron Meyers","Simon","Filho(a)","M","1984-11-13"),
  (90944228089,22619399068,"Hillary Jennings","Celeste","Filho(a)","F","2021-06-15"),
  (64992854044,22619399068,"Portia Calhoun","Sonia","Filho(a)","F","1986-01-20"),
  (34877595007,22619399068,"Jarrod Clayton","Lester","Filho(a)","M","1990-02-20"),
  (93433066019,38601549071,"Dolan Benton","Wylie","Filho(a)","M","2014-09-13"),
  (70815634064,75631257017,"Howard Gonzalez","Jermaine","Filho(a)","M","2005-04-10"),
  (00332024008,75631257017,"Lawrence Booker","Ahmed","Filho(a)","M","1987-09-14"),
  (77440773004,95336839027,"Karen Norris","Samuel","Filho(a)","F","1995-07-15"),
  (18570350031,95336839027,"Kevyn Chandler","Naida","Filho(a)","F","1985-06-14"),
  (80939057077,53256349099,"Wing Cervantes","Zephania","Filho(a)","M","2020-04-14"),
  (58823292050,50428588069,"Alexa Donaldson","Erich","Filho(a)","F","2015-05-09"),
  (36683287066,50428588069,"Hector Brady","Liberty","Filho(a)","M","2002-09-05"),
  (01478390093,33715162023,"Adam Pennington","Celeste","Filho(a)","M","2001-11-13"),
  (41367467098,96345235016,"Portia Greene","Brynn","Filho(a)","F","2011-12-29"),
  (33813703088,96345235016,"Bevis Pearson","Genevieve","Filho(a)","M","2005-01-08");
  
-- -----------------------------------------------------
-- Insert Table `tipo_quarto`
-- -----------------------------------------------------
INSERT INTO `tipo_quarto` (`quantidade_camas`,`qualidade`)
VALUES
  (1,5),
  (2,4),
  (3,4),
  (4,5);
  
-- -----------------------------------------------------
-- Insert Table `quarto`
-- -----------------------------------------------------
INSERT INTO `quarto` (`hotel_id`,`disponibilidade`,`tipo_quarto_id`)
VALUES
	(1,"S",1),
    (1,"N",1),
    (1,"S",2),
    (1,"S",2),
    (1,"N",2),
    (1,"N",3),
    (1,"S",3),
    (1,"N",3),
    (1,"S",4),
    (1,"S",4),
    (2,"N",1),
    (2,"N",1),
    (2,"S",2),
    (2,"S",2),
    (2,"N",2),
    (2,"N",2),
    (2,"N",3),
    (2,"S",3),
    (2,"S",3),
    (2,"S",4),
    (3,"N",1),
    (3,"N",1),
    (3,"N",2),
    (3,"N",2),
    (3,"S",3),
    (3,"S",3),
    (3,"S",3),
    (3,"N",4),
    (3,"S",4),
    (3,"N",4);
    
