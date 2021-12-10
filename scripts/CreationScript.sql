-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pokemon
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pokemon` ;

-- -----------------------------------------------------
-- Schema pokemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pokemon` DEFAULT CHARACTER SET utf8 ;
USE `pokemon` ;

-- -----------------------------------------------------
-- Table `pokemon`.`generation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`generation` (
  `generation_id` INT NOT NULL AUTO_INCREMENT,
  `generation_desc` VARCHAR(88) NOT NULL,
  PRIMARY KEY (`generation_id`),
  UNIQUE INDEX `idGeneration_UNIQUE` (`generation_id` ASC) VISIBLE,
  UNIQUE INDEX `Generationcol_UNIQUE` (`generation_desc` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE INDEX `location_id_UNIQUE` (`location_id` ASC) VISIBLE,
  UNIQUE INDEX `location_type_UNIQUE` (`location_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`rarity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`rarity` (
  `rarity_id` INT NOT NULL AUTO_INCREMENT,
  `rarity_name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`rarity_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`ability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`ability` (
  `ability_id` INT NOT NULL,
  `abiliity_name` VARCHAR(45) NOT NULL,
  `ability_desc` VARCHAR(256) NULL,
  PRIMARY KEY (`ability_id`),
  UNIQUE INDEX `idAbility_UNIQUE` (`ability_id` ASC) VISIBLE,
  UNIQUE INDEX `Abilitycol_UNIQUE` (`abiliity_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`type` (
  `type_id` INT NOT NULL,
  `type_name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE INDEX `idType_UNIQUE` (`type_id` ASC) VISIBLE,
  UNIQUE INDEX `Typecol_UNIQUE` (`type_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`color` (
  `color_id` INT NOT NULL AUTO_INCREMENT,
  `color_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`color_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`season` (
  `season_id` INT NOT NULL,
  `season_num` INT NOT NULL,
  PRIMARY KEY (`season_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`episode` (
  `episode_id` INT NOT NULL,
  `episode_num` INT NOT NULL,
  `season_id` INT NOT NULL,
  PRIMARY KEY (`episode_id`, `season_id`),
  INDEX `fk_episode_season1_idx` (`season_id` ASC) VISIBLE,
  CONSTRAINT `fk_episode_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `pokemon`.`season` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`pokemon_tv_appearance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`pokemon_tv_appearance` (
  `pokemon_tv_appearance_id` INT NOT NULL,
  `episode_id` INT NOT NULL,
  PRIMARY KEY (`pokemon_tv_appearance_id`, `episode_id`),
  INDEX `fk_pokemon_tv_appearance_episode1_idx` (`episode_id` ASC) VISIBLE,
  CONSTRAINT `fk_pokemon_tv_appearance_episode1`
    FOREIGN KEY (`episode_id`)
    REFERENCES `pokemon`.`episode` (`episode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`pokemon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`pokemon` (
  `pokemon_id` INT NOT NULL AUTO_INCREMENT,
  `pokemon_name` VARCHAR(45) NOT NULL,
  `generation_id` INT NOT NULL,
  `pokemon_weight` INT NOT NULL,
  `pokemon_height` INT NOT NULL,
  `location_id` INT NOT NULL,
  `rarity_id` INT NOT NULL,
  `ability1_id` INT NOT NULL,
  `ability2_id` INT NULL,
  `type1_id` INT NOT NULL,
  `type2_id` INT NOT NULL,
  `color_id` INT NOT NULL,
  `pokemon_tv_appearance_id` INT NOT NULL,
  PRIMARY KEY (`pokemon_id`, `pokemon_name`, `location_id`, `rarity_id`, `ability1_id`, `type1_id`, `type2_id`),
  UNIQUE INDEX `idPokemon ID_UNIQUE` (`pokemon_id` ASC) VISIBLE,
  UNIQUE INDEX `Pokemon name_UNIQUE` (`pokemon_name` ASC) VISIBLE,
  INDEX `fk_Pokemon_Generation_idx` (`generation_id` ASC) VISIBLE,
  INDEX `fk_pokemon_Location1_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_pokemon_Rarity1_idx` (`rarity_id` ASC) VISIBLE,
  INDEX `fk_pokemon_ability1_idx` (`ability1_id` ASC) VISIBLE,
  INDEX `fk_pokemon_ability2_idx` (`ability2_id` ASC) VISIBLE,
  INDEX `fk_pokemon_type1_idx` (`type1_id` ASC) VISIBLE,
  INDEX `fk_pokemon_type2_idx` (`type2_id` ASC) VISIBLE,
  INDEX `fk_pokemon_color1_idx` (`color_id` ASC) VISIBLE,
  INDEX `fk_pokemon_pokemon_tv_appearance1_idx` (`pokemon_tv_appearance_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pokemon_Generation`
    FOREIGN KEY (`generation_id`)
    REFERENCES `pokemon`.`generation` (`generation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_Location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `pokemon`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_Rarity1`
    FOREIGN KEY (`rarity_id`)
    REFERENCES `pokemon`.`rarity` (`rarity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_ability1`
    FOREIGN KEY (`ability1_id`)
    REFERENCES `pokemon`.`ability` (`ability_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_ability2`
    FOREIGN KEY (`ability2_id`)
    REFERENCES `pokemon`.`ability` (`ability_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_type1`
    FOREIGN KEY (`type1_id`)
    REFERENCES `pokemon`.`type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_type2`
    FOREIGN KEY (`type2_id`)
    REFERENCES `pokemon`.`type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_color1`
    FOREIGN KEY (`color_id`)
    REFERENCES `pokemon`.`color` (`color_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_pokemon_tv_appearance1`
    FOREIGN KEY (`pokemon_tv_appearance_id`)
    REFERENCES `pokemon`.`pokemon_tv_appearance` (`pokemon_tv_appearance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`pokemon_evolves_into`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`pokemon_evolves_into` (
  `evolution_id` INT NOT NULL,
  `stage` INT NOT NULL,
  `pokemon_id` INT NOT NULL,
  `target_pokemon_id` INT NOT NULL,
  `evolve_level` INT NOT NULL,
  PRIMARY KEY (`evolution_id`),
  UNIQUE INDEX `idEvolution_UNIQUE` (`evolution_id` ASC) VISIBLE,
  INDEX `fk_Evolution_Pokemon1_idx` (`pokemon_id` ASC) VISIBLE,
  INDEX `fk_Evolution_Pokemon2_idx` (`target_pokemon_id` ASC) VISIBLE,
  CONSTRAINT `fk_Evolution_Pokemon1`
    FOREIGN KEY (`pokemon_id`)
    REFERENCES `pokemon`.`pokemon` (`pokemon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evolution_Pokemon2`
    FOREIGN KEY (`target_pokemon_id`)
    REFERENCES `pokemon`.`pokemon` (`pokemon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`type_has_weakness`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`type_has_weakness` (
  `type_id` INT NOT NULL,
  `attacker_id` INT NOT NULL,
  `weakness_multiplier` FLOAT NOT NULL,
  PRIMARY KEY (`type_id`, `attacker_id`),
  INDEX `fk_Type_has_Type_Type2_idx` (`attacker_id` ASC) VISIBLE,
  INDEX `fk_Type_has_Type_Type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_Type_has_Type_Type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `pokemon`.`type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Type_has_Type_Type2`
    FOREIGN KEY (`attacker_id`)
    REFERENCES `pokemon`.`type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemon`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemon`.`game` (
  `game_id` INT NOT NULL AUTO_INCREMENT,
  `game_name` VARCHAR(45) NOT NULL,
  `generation_id` INT NOT NULL,
  PRIMARY KEY (`game_id`, `generation_id`),
  INDEX `fk_game_generation1_idx` (`generation_id` ASC) VISIBLE,
  CONSTRAINT `fk_game_generation1`
    FOREIGN KEY (`generation_id`)
    REFERENCES `pokemon`.`generation` (`generation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;