-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema crime
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema crime
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crime` DEFAULT CHARACTER SET utf8 ;
USE `crime` ;

-- -----------------------------------------------------
-- Table `crime`.`user_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`user_tbl` (
  `userNum` INT AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(400) NOT NULL,
  `post` VARCHAR(45) NOT NULL,
  `phoneNum` VARCHAR(45) NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `addr` VARCHAR(45) NOT NULL,
  `addrDetail` VARCHAR(45) NOT NULL,
  `withDraw` VARCHAR(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`userNum`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `userNum_UNIQUE` (`userNum` ASC))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `crime`.`accidentBoard_tbl` (
  `accidentNum` INT AUTO_INCREMENT,
  `userNum` INT NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  `content` TEXT NOT NULL,
  `region` VARCHAR(20) NOT NULL,
  `viewCnt` INT NULL DEFAULT 0,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  `userHidden` VARCHAR(5) DEFAULT 'n',
  `uploadCheck` VARCHAR(5) DEFAULT 'n',
  PRIMARY KEY (`accidentNum`),
  INDEX `fk_accident_user_idx` (`userNum` ASC),
  UNIQUE INDEX `accidentNum_UNIQUE` (`accidentNum` ASC),
  CONSTRAINT `fk_accident_user`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

    desc supportboard_tbl;
    
-- -----------------------------------------------------Functions
-- Table `crime`.`re_accident_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`re_accident_tbl` (
  `commentNum` INT AUTO_INCREMENT,
  `accidentNum` INT NOT NULL,
  `userNum` INT NOT NULL,
  `content` TEXT NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `commentWriter` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`commentNum`),
  INDEX `fk_accidentBoardComment_user1_idx` (`userNum` ASC),
  INDEX `fk_accidentComment_tbl_accidentBoard_tbl1_idx` (`accidentNum` ASC),
  UNIQUE INDEX `commentNum_UNIQUE` (`commentNum` ASC),
  CONSTRAINT `fk_accidentBoardComment_user1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accidentComment_tbl_accidentBoard_tbl1`
    FOREIGN KEY (`accidentNum`)
    REFERENCES `crime`.`accidentBoard_tbl` (`accidentNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`ban_ip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`ban_ip` (
  `ip` VARCHAR(50),
  `cnt` INT NOT NULL DEFAULT 1,
  `bandate` TIMESTAMP NOT NULL DEFAULT now(),
  `email` VARCHAR(50)
  )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `crime`.`guardBoard_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`guardBoard_tbl` (
  `guardNum` INT AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `userNum` INT NOT NULL,
  `uploadCheck` VARCHAR(5) NULL DEFAULT 'n',
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `viewCnt` INT NULL DEFAULT 0,
  `region` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`guardNum`),
  INDEX `fk_guard_tbl_user_tbl1_idx` (`userNum` ASC),
  UNIQUE INDEX `guardNum_UNIQUE` (`guardNum` ASC),
  CONSTRAINT `fk_guard_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`supportBoard_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`supportBoard_tbl` (
  `supportNum` INT AUTO_INCREMENT,
  `region` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `writer` VARCHAR(45) NOT NULL,
  `enddate` TIMESTAMP NULL DEFAULT now(),
  `viewCnt` INT NULL DEFAULT 0,
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  `recm` VARCHAR(5) NULL DEFAULT 'n',
  `userNum` INT NOT NULL,
  `uploadCheck` VARCHAR(5) NULL DEFAULT 'n',
  PRIMARY KEY (`supportNum`),
  INDEX `fk_guard_support_tbl_user_tbl1_idx` (`userNum` ASC),
  UNIQUE INDEX `supportNum_UNIQUE` (`supportNum` ASC),
  CONSTRAINT `fk_guard_support_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`attach_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`attach_tbl` (
  `fullName` VARCHAR(200) default null,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `guardNum` INT default null,
  `supportNum` INT default null,
  `accidentNum` INT default null,
  INDEX `fk_attach_tbl_guard_tbl1_idx` (`guardNum` ASC),
  INDEX `fk_attach_tbl_guard_support_tbl1_idx` (`supportNum` ASC),
  INDEX `fk_attach_tbl_accidentBoard_tbl1_idx` (`accidentNum` ASC),
  CONSTRAINT `fk_attach_tbl_guard_tbl1`
    FOREIGN KEY (`guardNum`)
    REFERENCES `crime`.`guardBoard_tbl` (`guardNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_attach_tbl_guard_support_tbl1`
    FOREIGN KEY (`supportNum`)
    REFERENCES `crime`.`supportBoard_tbl` (`supportNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_attach_tbl_accidentBoard_tbl1`
    FOREIGN KEY (`accidentNum`)
    REFERENCES `crime`.`accidentBoard_tbl` (`accidentNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`notice_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`notice_tbl` (
  `noticeNum` INT AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `userNum` INT NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  `viewCnt` INT NOT NULL DEFAULT 0,
  INDEX `fk_notice_tbl_user_tbl1_idx` (`userNum` ASC),
  PRIMARY KEY (`noticeNum`),
  CONSTRAINT `fk_notice_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`qnaBoard_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`qnaBoard_tbl` (
  `qnaNum` INT AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `viewCnt` INT NULL DEFAULT 0,
  `uploadCheck` VARCHAR(5) NULL DEFAULT 'n',
  `userNum` INT NOT NULL,
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`qnaNum`),
  INDEX `fk_qna_tbl_user_tbl1_idx` (`userNum` ASC),
  CONSTRAINT `fk_qna_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`re_qna_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`re_qna_tbl` (
  `re_qnaNum` INT AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `origin` INT NULL DEFAULT 0,
  `dept` INT NULL DEFAULT 0,
  `seq` INT NULL DEFAULT 0,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  `viewCnt` INT NULL DEFAULT 0,
  `showBoard` VARCHAR(5) NULL DEFAULT 'n',
  `userNum` INT NOT NULL,
  PRIMARY KEY (`re_qnaNum`),
  INDEX `fk_re_qna_tbl_user_tbl1_idx` (`userNum` ASC),
  CONSTRAINT `fk_re_qna_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`re_guard_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`re_guard_tbl` (
  `re_guardNum` INT AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `userNum` INT NOT NULL,
  `guardNum` INT NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `commentWriter` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`re_guardNum`),
  INDEX `fk_re_guard_tbl_guard_tbl1_idx` (`guardNum` ASC),
  INDEX `fk_re_guard_tbl_user_tbl1_idx` (`userNum` ASC),
  CONSTRAINT `fk_re_guard_tbl_guard_tbl1`
    FOREIGN KEY (`guardNum`)
    REFERENCES `crime`.`guardBoard_tbl` (`guardNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_re_guard_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime`.`re_support_tbl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crime`.`re_support_tbl` (
  `re_supportNum` INT AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `userNum` INT NOT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `supportNum` INT NOT NULL,
  `commentWriter` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`re_supportNum`),
  INDEX `fk_re_support_tbl_user_tbl1_idx` (`userNum` ASC),
  INDEX `fk_re_support_tbl_guard_support_tbl1_idx` (`supportNum` ASC),
  CONSTRAINT `fk_re_support_tbl_user_tbl1`
    FOREIGN KEY (`userNum`)
    REFERENCES `crime`.`user_tbl` (`userNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_re_support_tbl_guard_support_tbl1`
    FOREIGN KEY (`supportNum`)
    REFERENCES `crime`.`supportBoard_tbl` (`supportNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
