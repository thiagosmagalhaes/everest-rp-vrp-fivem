-- --------------------------------------------------------
-- Host :                        127.0.0.1
-- Server version:               10.3.7-MariaDB - mariadb.org binary distribution
-- OS of the server:             Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE IF NOT EXISTS `vrp_users` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`last_login` varchar(255) NOT NULL,
		`ip` varchar(255) NOT NULL,
		`whitelisted` tinyint(1) DEFAULT NULL,
		`banned` tinyint(1) DEFAULT NULL,
		PRIMARY KEY (`id`)
	  ) ENGINE=InnoDB AUTO_INCREMENT=1;

	  ALTER TABLE `vrp`.`vrp_users` 
		CHANGE COLUMN `last_login` `last_login` VARCHAR(255) NULL ,
		CHANGE COLUMN `ip` `ip` VARCHAR(255) NULL ,
		CHANGE COLUMN `whitelisted` `whitelisted` TINYINT(1) NOT NULL DEFAULT 0 ,
		CHANGE COLUMN `banned` `banned` TINYINT(1) NOT NULL DEFAULT 0 ;

	  
		CREATE TABLE IF NOT EXISTS `vrp`.`policia` (
			`id` INT(11) NOT NULL AUTO_INCREMENT,
			`user_id` INT(11) NOT NULL,
			`dkey` VARCHAR(45) NOT NULL,
			`dvalue` TEXT NULL DEFAULT NULL,
			`img` VARCHAR(150) NULL DEFAULT NULL,
			`valor` DECIMAL(10,2) NULL DEFAULT NULL,
			`datahora` DATETIME NULL DEFAULT NULL,
			`id_pai` INT(11) NULL DEFAULT '0',
			PRIMARY KEY (`id`, `dkey`, `user_id`))
		  ENGINE = InnoDB
		  AUTO_INCREMENT = 282
		  DEFAULT CHARACTER SET = utf8
		  COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS vrp_user_ids(
  identifier VARCHAR(100),
  user_id INTEGER,
  CONSTRAINT pk_user_ids PRIMARY KEY(identifier),
  CONSTRAINT fk_user_ids_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_characters(
  id INTEGER AUTO_INCREMENT,
  user_id INTEGER,
  CONSTRAINT pk_characters PRIMARY KEY(id),
  CONSTRAINT fk_characters_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_user_data(
  user_id INTEGER,
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_user_data PRIMARY KEY(user_id,dkey),
  CONSTRAINT fk_user_data_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_character_data(
  character_id INTEGER,
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_character_data PRIMARY KEY(character_id,dkey),
  CONSTRAINT fk_character_data_characters FOREIGN KEY(character_id) REFERENCES vrp_characters(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS vrp_server_data(
  id VARCHAR(100),
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_server_data PRIMARY KEY(id, dkey)
);
CREATE TABLE IF NOT EXISTS vrp_global_data(
  dkey VARCHAR(100),
  dvalue BLOB,
  CONSTRAINT pk_global_data PRIMARY KEY(dkey)
);
CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `dono` INT(1) NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foto` VARCHAR(200) NULL DEFAULT NULL,
  `foragido` INT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT '0',
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT '1000',
  `body` int(4) NOT NULL DEFAULT '1000',
  `fuel` int(3) NOT NULL DEFAULT '100',
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB;


-- Export the structure of the table gta rp. phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- The exported data was not selected.
-- Export the structure of the table gta rp. phone calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num such owner',
  `num` varchar(10) NOT NULL COMMENT 'Reference number of the contact',
  `incoming` int(11) NOT NULL COMMENT 'Defined if we are at the origin of the calls',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Calls accept or not',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- The exported data was not selected.
-- Export the structure of the table gta rp. phone messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- The exported data was not selected.
-- Export the structure of the table gta rp. phone users contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;



-- Exported data was not selected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
