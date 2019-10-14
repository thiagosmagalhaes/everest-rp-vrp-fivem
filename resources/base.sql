-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 14-Out-2019 às 15:58
-- Versão do servidor: 10.4.8-MariaDB
-- versão do PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `vrp`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num such owner',
  `num` varchar(10) NOT NULL COMMENT 'Reference number of the contact',
  `incoming` int(11) NOT NULL COMMENT 'Defined if we are at the origin of the calls',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Calls accept or not'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `policia`
--

CREATE TABLE `policia` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `dkey` varchar(45) COLLATE utf8_bin NOT NULL,
  `dvalue` text COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `datahora` datetime DEFAULT NULL,
  `id_pai` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_characters`
--

CREATE TABLE `vrp_characters` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_character_data`
--

CREATE TABLE `vrp_character_data` (
  `character_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_global_data`
--

CREATE TABLE `vrp_global_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_server_data`
--

CREATE TABLE `vrp_server_data` (
  `id` varchar(100) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_srv_data`
--

CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_users`
--

CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `last_login` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  `banned` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_data`
--

CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_homes`
--

CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `dono` int(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_identities`
--

CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `foragido` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_ids`
--

CREATE TABLE `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_moneys`
--

CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_user_vehicles`
--

CREATE TABLE `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT 0,
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `policia`
--
ALTER TABLE `policia`
  ADD PRIMARY KEY (`id`,`dkey`,`user_id`);

--
-- Índices para tabela `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices para tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- Índices para tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_tweets_twitter_accounts` (`authorId`);

--
-- Índices para tabela `vrp_characters`
--
ALTER TABLE `vrp_characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_characters_users` (`user_id`);

--
-- Índices para tabela `vrp_character_data`
--
ALTER TABLE `vrp_character_data`
  ADD PRIMARY KEY (`character_id`,`dkey`);

--
-- Índices para tabela `vrp_global_data`
--
ALTER TABLE `vrp_global_data`
  ADD PRIMARY KEY (`dkey`);

--
-- Índices para tabela `vrp_server_data`
--
ALTER TABLE `vrp_server_data`
  ADD PRIMARY KEY (`id`,`dkey`);

--
-- Índices para tabela `vrp_srv_data`
--
ALTER TABLE `vrp_srv_data`
  ADD PRIMARY KEY (`dkey`);

--
-- Índices para tabela `vrp_users`
--
ALTER TABLE `vrp_users`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD PRIMARY KEY (`user_id`,`dkey`);

--
-- Índices para tabela `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD PRIMARY KEY (`user_id`,`home`);

--
-- Índices para tabela `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `registration` (`registration`),
  ADD KEY `phone` (`phone`);

--
-- Índices para tabela `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `fk_user_ids_users` (`user_id`);

--
-- Índices para tabela `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD PRIMARY KEY (`user_id`);

--
-- Índices para tabela `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `policia`
--
ALTER TABLE `policia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=282;

--
-- AUTO_INCREMENT de tabela `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `vrp_characters`
--
ALTER TABLE `vrp_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `vrp_users`
--
ALTER TABLE `vrp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);

--
-- Limitadores para a tabela `vrp_characters`
--
ALTER TABLE `vrp_characters`
  ADD CONSTRAINT `fk_characters_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_character_data`
--
ALTER TABLE `vrp_character_data`
  ADD CONSTRAINT `fk_character_data_characters` FOREIGN KEY (`character_id`) REFERENCES `vrp_characters` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
