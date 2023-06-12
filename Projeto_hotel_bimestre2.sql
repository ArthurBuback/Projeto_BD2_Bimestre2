-- MySQL Script generated by MySQL Workbench
-- Sun Jun 11 21:05:01 2023
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
  `primeiro_nome` VARCHAR(45) NOT NULL,
  `ultimo_nome` VARCHAR(45) NOT NULL,
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
-- Table `dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dependente` (
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
  `numero_quarto` INT NOT NULL,
  `hotel_id` INT NOT NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `calculo` INT NOT NULL,
  `valor_diaria` INT NOT NULL,
  `serviço_de_quarto` INT NULL,
  `consumiveis` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia_reserva` DATE NULL,
  `dia_entrada` DATE NOT NULL,
  `dia_saida` DATE NOT NULL,
  `cliente_cpf` BIGINT(11) NOT NULL,
  `valor_id` INT NOT NULL,
  `quarto_numero_quarto` INT NOT NULL,
  `quarto_hotel_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reserva_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  INDEX `fk_reserva_valor1_idx` (`valor_id` ASC) VISIBLE,
  INDEX `fk_reserva_quarto1_idx` (`quarto_numero_quarto` ASC, `quarto_hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_valor1`
    FOREIGN KEY (`valor_id`)
    REFERENCES `valor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_quarto1`
    FOREIGN KEY (`quarto_numero_quarto` , `quarto_hotel_id`)
    REFERENCES `quarto` (`numero_quarto` , `hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `acompanhante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `acompanhante` (
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
-- Insert `hotel`
-- -----------------------------------------------------
INSERT INTO `hotel` (`nome`,`endereço`,`cidade`,`quantidade_quartos`,`telefone`,`estrelas`)
VALUES
  ("Topo da Montanha","939-1678 A, Road","Vitória",9,"(27)99512-8548",5),
  ("Canto da Areia","P.O. Box 680, 6315 Arcu. Ave","Vila Velha",9,"(27)99684-9735",4),
  ("A Grande Árvore","Ap #142-7472 Sed Avenue","Vila Velha",9,"(27)99871-7086",5);

-- -----------------------------------------------------
-- Insert `cargo`
-- -----------------------------------------------------
INSERT INTO `cargo` (`nome`)
VALUES
  ("Gerente"),
  ("Arrumeiro"),
  ("Cozinheiro"),
  ("Balconista");

-- -----------------------------------------------------
-- Insert `funcionario`
-- -----------------------------------------------------
INSERT INTO `funcionario` (`cpf`,`primeiro_nome`,`ultimo_nome`,`data_nascimento`,`sexo`,`salário`,`celular`,`email`,`cargo_id`,`hotel_id`)
VALUES
  (74013193060,"Buffy","Cunningham","1993-10-24","M","8365.00","(55)25348-9954","buffy6799@hotmail.com",1,1),
  (08735675012,"Melissa","Hartman","1991-07-18","F","3396.00","(55)72234-1806","melissa750@icloud.com",2,1),
  (90219558060,"Tasha","Mccall","1985-12-08","F","3530.00","(55)41136-3928","tasha@hotmail.com",2,1),
  (47165234039,"Benjamin","Knowles","1977-04-10","M","4766.00","(55)77561-1221","benjamin@hotmail.com",3,1),
  (32074964072,"Prescott","Owens","1970-11-01","M","5896.00","(55)54623-8295","prescott@google.com",4,1),
  (22619399068,"Xyla","Rasmussen","1973-09-03","F","7697.00","(55)74442-4364","xyla2971@icloud.com",1,2),
  (38601549071,"Kevyn","Holt","1990-10-19","M","3179.00","(55)76954-3559","kevyn6907@icloud.com",2,2),
  (83646555076,"Hashim","Pate","1980-06-16","M","3235.00","(55)48076-2013","hashim@icloud.com",2,2),
  (75631257017,"Fleur","Randolph","1975-08-30","F","5780.00","(55)31514-7805","fleur@outlook.com",3,2),
  (95336839027,"Lyle","Tyson","1989-02-16","F","4787.00","(55)81759-7162","lyle@hotmail.com",4,2),
  (76355444033,"Channing","Melton","1982-03-24","F","8568.00","(55)54897-6653","channing4483@google.com",1,3),
  (53256349099,"Kirby","Cohen","1993-07-14","M","3654.00","(55)48932-5123","kirby@outlook.com",2,3),
  (50428588069,"Gwendolyn","Wilcox","1999-09-04","F","3308.00","(55)47885-7853","gwendolyn345@hotmail.com",2,3),
  (33715162023,"Anthony","Dunlap","1987-03-30","M","5886.00","(55)45913-4594","anthony@outlook.com",3,3),
  (96345235016,"Seth","Harmon","1979-09-10","M","4655.00","(55)26668-2699","seth1741@google.com",4,3);
  
-- -----------------------------------------------------
-- Insert `dependente`
-- -----------------------------------------------------
INSERT INTO `dependente` (`cpf`,`funcionario_cpf`,`primeiro_nome`,`ultimo_nome`,`parentesco`,`sexo`,`data_nascimento`)
VALUES
  (97770289033,74013193060,"Kenneth","Wade","Filho(a)","F","2004-10-03"),
  (38192726070,74013193060,"Emi","Patience","Filho(a)","F","2010-01-04"),
  (31129118061,32074964072,"Amela","Xander","Filho(a)","F","2002-09-01"),
  (11185990046,08735675012,"Randall","Clarke","Filho(a)","M","2010-03-22"),
  (58920624062,08735675012,"Timon","Quin","Filho(a)","M","2012-12-04"),
  (42961281083,47165234039,"Aaron","Simon","Filho(a)","M","1984-11-13"),
  (90944228089,22619399068,"Hillary","Celeste","Filho(a)","F","2021-06-15"),
  (64992854044,22619399068,"Portia","Sonia","Filho(a)","F","1986-01-20"),
  (34877595007,22619399068,"Jarrod","Lester","Filho(a)","M","1990-02-20"),
  (93433066019,38601549071,"Dolan","Wylie","Filho(a)","M","2014-09-13"),
  (70815634064,75631257017,"Howard","Jermaine","Filho(a)","M","2005-04-10"),
  (00332024008,75631257017,"Lawrence","Ahmed","Filho(a)","M","1987-09-14"),
  (77440773004,95336839027,"Karen","Samuel","Filho(a)","F","1995-07-15"),
  (18570350031,95336839027,"Kevyn","Naida","Filho(a)","F","1985-06-14"),
  (80939057077,53256349099,"Wing","Zephania","Filho(a)","M","2020-04-14"),
  (58823292050,50428588069,"Alexa","Erich","Filho(a)","F","2015-05-09"),
  (36683287066,50428588069,"Hector","Liberty","Filho(a)","M","2002-09-05"),
  (01478390093,33715162023,"Adam","Celeste","Filho(a)","M","2001-11-13"),
  (41367467098,96345235016,"Portia","Brynn","Filho(a)","F","2011-12-29"),
  (33813703088,96345235016,"Bevis","Genevieve","Filho(a)","M","2005-01-08");
  
-- -----------------------------------------------------
-- Insert `tipo_quarto`
-- -----------------------------------------------------
INSERT INTO `tipo_quarto` (`quantidade_camas`,`qualidade`)
VALUES
  (1,5),
  (2,4),
  (3,4),
  (4,5);
  
-- -----------------------------------------------------
-- Insert `quarto`
-- -----------------------------------------------------
INSERT INTO `quarto` (`numero_quarto`,`hotel_id`,`disponibilidade`,`tipo_quarto_id`)
VALUES
  (11,1,"S",1),
  (12,1,"N",1),
  (13,1,"S",2),
  (21,1,"S",2),
  (22,1,"N",2),
  (23,1,"N",3),
  (31,1,"S",3),
  (32,1,"N",3),
  (33,1,"S",4),
  (11,2,"N",1),
  (12,2,"N",1),
  (13,2,"S",2),
  (21,2,"S",2),
  (22,2,"N",2),
  (23,2,"N",2),
  (31,2,"N",3),
  (32,2,"S",3),
  (33,2,"S",4),
  (11,3,"N",1),
  (12,3,"N",1),
  (13,3,"N",2),
  (21,3,"N",2),
  (22,3,"S",3),
  (23,3,"S",3),
  (31,3,"S",3),
  (32,3,"N",4),
  (33,3,"S",4);

-- -----------------------------------------------------
-- Insert `cliente`
-- -----------------------------------------------------
INSERT INTO `cliente` (`cpf`,`primeiro_nome`,`ultimo_nome`,`sexo`,`celular`,`email`)
VALUES
  (08558537003,"Constance","Nixon","M","26196-1641","c_nixon@outlook.com"),
  (14349631011,"Dai","Tate","M","83731-1158","d-tate6177@icloud.com"),
  (66212317097,"Jocelyn","Winters","F","51648-9352","pjocelyn3743@hotmail.com"),
  (87561694008,"Keely","Daniel","F","22556-4417","daniel-keely@outlook.com"),
  (29971420082,"Cruz","Lynch","M","76445-1374","cruz_lynch@outlook.com"),
  (71408479087,"Vernon","Joseph","M","53522-1878","josephvernon@icloud.com"),
  (07626868048,"Ulric","Williamson","M","77765-3455","w_ulric6551@hotmail.com"),
  (46024072007,"Carla","Foster","F","31722-8769","foster.kenyon5157@yahoo.com"),
  (89651755008,"Lucy","Boyd","F","54385-3075","boyd-lucy@outlook.com"),
  (84570256007,"Jaime","White","M","52712-9816","white_jaime1265@google.com"),
  (82382463007,"Ezra","Koch","F","64703-6533","ezra_koch5898@yahoo.com"),
  (15390964080,"Shana","Silva","F","94729-1437","s-dalton7923@icloud.com"),
  (85238997078,"Bianca","Hines","F","75007-5020","bianca-hines@hotmail.com"),
  (02261830092,"Carlos","Piloto","M","96452-5438","carlos-piloto@hotmail.com");

-- -----------------------------------------------------
-- Insert `valor`
-- -----------------------------------------------------
INSERT INTO `valor` (`calculo`,`valor_diaria`,`serviço_de_quarto`,`consumiveis`)
VALUES
  (26020,1599,136,300),
  (8144,828,192,500),
  (15522,1706,48,120),
  (4404,1556,92,1200),
  (7320,1326,190,500),
  (10751,1181,22,100),
  (6652,909,69,220),
  (6147,1192,7,180),
  (5748,1338,98,760),
  (3608,1394,40,780),
  (4622,1722,198,980),
  (13112,1973,187,450),
  (12479,872,95,970),
  (5904,1722,198,540);
  
-- -----------------------------------------------------
-- Insert `reserva`
-- -----------------------------------------------------
INSERT INTO `reserva` (`dia_reserva`,`dia_entrada`,`dia_saida`,`cliente_cpf`,`valor_id`,`quarto_numero_quarto`,`quarto_hotel_id`)
VALUES
  ("2022-04-04","2022-06-06","2022-06-08",08558537003,4,32,3),
  ("2022-05-24","2022-05-30","2022-06-04",14349631011,5,11,2),
  ("2022-03-21","2022-05-23","2022-06-01",66212317097,2,22,1),
  ("2022-03-12","2022-05-22","2022-06-07",87561694008,1,12,1),
  ("2022-04-23","2022-05-31","2022-06-02",29971420082,10,11,3),
  ("2022-03-22","2022-05-23","2022-06-01",71408479087,3,23,1),
  ("2022-03-22","2022-06-04","2022-06-07",07626868048,14,32,1),
  ("2022-05-27","2022-05-30","2022-06-05",46024072007,12,13,3),
  ("2022-03-11","2022-05-22","2022-05-31",89651755008,6,12,2),
  ("2022-05-23","2022-05-30","2022-06-04",84570256007,8,23,2),
  ("2022-03-18","2022-06-02","2022-06-09",82382463007,7,22,2),
  ("2022-03-05","2022-05-26","2022-05-28",15390964080,11,12,3),
  ("2022-04-29","2022-05-25","2022-06-07",85238997078,13,21,3),
  ("2022-04-08","2022-05-22","2022-06-07",02261830092,9,31,2);
  
-- -----------------------------------------------------
-- Insert `acompanhente`
-- -----------------------------------------------------
INSERT INTO `acompanhante` (`cpf`,`cliente_cpf`,`primeiro_nome`,`ultimo_nome`,`relacionamento`,`sexo`,`data_nascimento`)
VALUES
  (08508465017,08558537003,"Eve","Nixon","Filho(a)","M","1992-09-08"),
  (08889177080,08558537003,"TaShya","Nixon","Filho(a)","M","2003-03-19"),
  (96816182030,08558537003,"Lilah","Nixon","Cônjuge","F","2013-08-29"),
  (67823953048,66212317097,"Tiger","Winters","Cônjuge","M","1994-12-12"),
  (93759969054,87561694008,"Joel","Daniel","Filho(a)","M","1987-06-19"),
  (70551078065,87561694008,"Colette","Daniel","Filho(a)","F","1997-06-19"),
  (19563212096,29971420082,"Francesca","Lynch","Filho(a)","M","2003-05-19"),
  (73007755000,29971420082,"Xaviera","Lynch","Cônjuge","F","1999-10-28"),
  (11455376000,71408479087,"Riley","Joseph","Cônjuge","F","1986-03-29"),
  (47291283035,71408479087,"Candace","Joseph","Filho(a)","F","2004-05-12"),
  (72458028071,46024072007,"Harley","Foster","Filho(a)","F","2013-04-06"),
  (71614573000,84570256007,"Connor","Anderson","Filho(a)","M","2004-04-16"),
  (10708331009,84570256007,"Orlando","Anderson","Cônjuge","M","2010-02-17"),
  (96778144009,85238997078,"Illana","Carpenter","Cônjuge","F","1989-06-19"),
  (81134044062,85238997078,"Pascale","Hines","Filho(a)","M","1994-12-08"),
  (74781581021,15390964080,"Fredericka","Silva","Filho(a)","M","2003-12-29"),
  (68311260060,15390964080,"Hakeem","Silva","Filho(a)","M","1989-12-09"),
  (63798194017,15390964080,"Kevyn","Silva","Cônjuge","M","1991-01-28"),
  (22268554082,07626868048,"Heather","Williamson","Cônjuge","F","1996-11-02"),
  (43122361000,07626868048,"Adam","Williamson","Filho(a)","M","1989-03-01");





-- -----------------------------------------------------
-- QUESTÃO 3
-- -----------------------------------------------------
/*Todos os quartos disponíveis*/
select hotel.nome, quarto.numero_quarto AS 'Número do Quarto'
from hotel INNER JOIN quarto
ON hotel.id = quarto.hotel_id AND quarto.disponibilidade = "S"

/*Quantidade de dias permanecidos por cada cliente*/
SELECT CONCAT(C.primeiro_nome, ' ', C.ultimo_nome) 'Nome do Cliente', R.id As 'Id da Reserva',
	DATEDIFF(R.dia_saida, R.dia_entrada) AS 'Quantidade de dias permanecidos'
FROM cliente C INNER JOIN reserva R
On C.cpf = R.cliente_cpf

/*Quantidade de dias permanecidos por cada cliente separados por hoteis*/
SELECT CONCAT(C.primeiro_nome, ' ', C.ultimo_nome) 'Nome do Cliente', H.nome as 'Nome do Hotel', 
	DATEDIFF(R.dia_saida, R.dia_entrada) 'Dias Permanecidos'
FROM hotel H INNER JOIN quarto Q INNER JOIN reserva R INNER JOIN cliente C
ON H.id = Q.hotel_id AND Q.numero_quarto = R.quarto_numero_quarto 
and Q.hotel_id = R.quarto_hotel_id AND C.cpf = R.cliente_cpf

/*O nome de todos os Acompanhantes dos Clientes e seus respectivos graus de Parentesco, ordenados por ordem alfabetica dos clientes*/
SELECT CONCAT(C.primeiro_nome, ' ', C.ultimo_nome) 'Nome do Cliente', 
	CONCAT(A.primeiro_nome, ' ', A.ultimo_nome) 'Nome do Acompanhante',
	A.relacionamento AS 'Parentesco'
FROM cliente C INNER JOIN acompanhante A
ON C.cpf = A.cliente_cpf
ORDER BY C.primeiro_nome





-- -----------------------------------------------------
-- QUESTÃO 4
-- -----------------------------------------------------
/*Todas essas indexações são utilizadas para facilitar a realização de consultas, tornando mais facil a pesquisa de nomes 
	respectivamentes dos clientes, dependentes, funcionarios e acompanhantes.*/

CREATE INDEX cliente_primeiro_nome_ultimo_nome_idx
ON cliente (ultimo_nome, primeiro_nome);

CREATE INDEX dependente_primeiro_nome_ultimo_nome_idx
ON dependente (ultimo_nome, primeiro_nome);

CREATE INDEX funcionario_primeiro_nome_ultimo_nome_idx
on funcionario (ultimo_nome, primeiro_nome);

CREATE INDEX acompanhante_primeiro_nome_ultimo_nome_idx
ON acompanhante (ultimo_nome, primeiro_nome);

CREATE INDEX hotel_nome_idx
ON hotel (nome);











-- -----------------------------------------------------
-- QUESTÃO 5
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Triggers para `acompanhente`
-- -----------------------------------------------------
CREATE TRIGGER acompanhante_cpf_trg BEFORE INSERT ON acompanhante
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cpf < 0 OR NEW.cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER acompanhante_cliente_cpf_trg BEFORE INSERT ON acompanhante
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cliente_cpf < 0 OR NEW.cliente_cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER acompanhante_relacionamento_trg BEFORE INSERT ON acompanhante
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.relacionamento <> 'Filho(a)' AND NEW.relacionamento <> 'Cônjuge' THEN
        SET msg = 'O relacionamente deve ser apenas Filho(a) ou Cônjuge';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER acompanhante_sexo_trg BEFORE INSERT ON acompanhante
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.sexo <> 'F' AND NEW.sexo <> 'M' THEN
        SET msg = 'O sexo deve ser masculino (M) ou feminino (F) apenas.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER acompanhante_data_nascimento_trg BEFORE INSERT ON acompanhante
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.data_nascimento < '1960-01-01' OR NEW.data_nascimento > '2023-07-01' THEN
        SET msg = 'Preencha com uma datá válida (entre 1960-01-01 e 2024-01-01)';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;


-- -----------------------------------------------------
-- Triggers para `cliente`
-- -----------------------------------------------------
CREATE TRIGGER cliente_cpf_trg BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cpf < 0 OR NEW.cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;


CREATE TRIGGER cliente_sexo_trg BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.sexo <> 'F' AND NEW.sexo <> 'M' THEN
        SET msg = 'O sexo deve ser apenas masculino (M) ou feminino (F).';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;


-- -----------------------------------------------------
-- Triggers para `dependente`
-- -----------------------------------------------------
CREATE TRIGGER dependente_cpf_trg BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cpf < 0 OR NEW.cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER dependente_funcionario_cpf_trg BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.funcionario_cpf < 0 OR NEW.funcionario_cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER dependente_relacionamento_trg BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.parentesco <> 'Filho(a)' AND NEW.parentesco <> 'Cônjuge' THEN
        SET msg = 'O relacionamente deve ser apenas Filho(a) ou Cônjuge';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER dependente_sexo_trg BEFORE INSERT ON dependente
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.sexo <> 'F' AND NEW.sexo <> 'M' THEN
        SET msg = 'O sexo deve ser apenas masculino (M) ou feminino (F).';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

-- -----------------------------------------------------
-- Triggers para `funcionario`
-- -----------------------------------------------------
CREATE TRIGGER funcionario_cpf_trg BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cpf < 0 OR NEW.cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER funcionario_data_nascimento_trg BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.data_nascimento < '1960-01-01' OR NEW.data_nascimento > '2023-07-01' THEN
        SET msg = 'Preencha com uma datá válida (entre 1960-01-01 e 2024-01-01)';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER funcionario_sexo_trg BEFORE INSERT ON funcionario
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.sexo <> 'F' AND NEW.sexo <> 'M' THEN
        SET msg = 'O sexo deve ser apenas masculino (M) ou feminino (F).';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

-- -----------------------------------------------------
-- Triggers para `quarto`
-- -----------------------------------------------------
CREATE TRIGGER quarto_disponibilidade_trg BEFORE INSERT ON quarto
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.disponibilidade <> 'S' AND NEW.disponibilidade <> 'N' THEN
        SET msg = 'A disponibilidade deve ser apenas Sim (S) ou Não (N).';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

-- -----------------------------------------------------
-- Triggers para `reserva`
-- -----------------------------------------------------
CREATE TRIGGER reserva_dia_reserva_trg BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.dia_reserva < '2022-01-01' OR NEW.dia_reserva > '2023-01-01' THEN
        SET msg = 'Preencha com uma datá válida (entre 2022-01-01 e 2023-01-01)';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER reserva_dia_entrada_trg BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.dia_entrada < '2022-01-01' OR NEW.dia_entrada > '2023-01-01' THEN
        SET msg = 'Preencha com uma datá válida (entre 2022-01-01 e 2023-01-01)';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER reserva_dia_saida_trg BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.dia_saida < '2022-01-01' OR NEW.dia_saida > '2023-01-01' THEN
        SET msg = 'Preencha com uma datá válida (entre 2022-01-01 e 2023-01-01)';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

CREATE TRIGGER reserva_cliente_cpf_trg BEFORE INSERT ON reserva
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(200);
    IF NEW.cliente_cpf < 0 OR NEW.cliente_cpf > 99999999999 THEN
        SET msg = 'Insira um cpf de 11 dígitos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END;

-- -----------------------------------------------------
-- Triggers para `valor`
-- -----------------------------------------------------
CREATE TRIGGER valor_calculo_trg BEFORE INSERT ON `valor`
FOR EACH ROW
BEGIN
  DECLARE tempo_estadia INT;
  SELECT DATEDIFF(reserva.dia_saida, reserva.dia_entrada) INTO tempo_estadia 
  	FROM reserva WHERE id = NEW.id;
  
  SET NEW.calculo = NEW.valor_diaria * tempo_estadia + 
  	NEW.serviço_de_quarto + NEW.consumiveis;
END;
