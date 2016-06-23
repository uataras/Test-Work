-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Июн 23 2016 г., 05:00
-- Версия сервера: 5.6.17
-- Версия PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `cron_mail`
--

-- --------------------------------------------------------

--
-- Структура таблицы `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `title` varchar(150) NOT NULL DEFAULT '',
  `link` text,
  `descr` text,
  `isCheck` tinyint(1) NOT NULL DEFAULT '0',
  `publicated_to` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `items`
--

INSERT INTO `items` (`id`, `user_id`, `status`, `title`, `link`, `descr`, `isCheck`, `publicated_to`, `last_update`) VALUES
(1, 1, 2, 'title1', 'link1', 'desc1', 0, '2016-06-24 21:00:00', '0000-00-00 00:00:00'),
(2, 2, 2, 'title2', 'link2', 'desc2', 0, '2016-06-27 21:00:00', '0000-00-00 00:00:00'),
(3, 3, 2, 'title3', 'link3', 'desc3', 0, '2016-06-23 21:00:00', '0000-00-00 00:00:00'),
(4, 4, 2, 'title4', 'link4', 'desc4', 0, '2016-06-25 21:00:00', '2016-06-23 01:45:29'),
(5, 5, 2, 'title5', 'link5', 'desc5', 0, '2016-06-26 21:00:00', '2016-06-23 01:45:29'),
(6, 3, 2, 'title6', 'link6', 'desc6', 0, '2016-06-23 21:00:00', '0000-00-00 00:00:00'),
(7, 2, 2, 'title7', 'link7', 'desc7', 0, '2016-06-26 21:00:00', '2016-06-23 01:45:29'),
(8, 3, 2, 'title8', 'link8', 'desc8', 0, '2016-06-27 00:00:00', '2016-06-23 01:45:29'),
(9, 1, 2, 'title9', 'link9', 'desc9', 0, '2016-06-27 14:00:00', '0000-00-00 00:00:00'),
(10, 2, 2, 'title10', 'link10', 'desc10', 0, '2016-06-24 14:00:00', '0000-00-00 00:00:00'),
(11, 5, 2, 'title11', 'link11', 'desc11', 0, '2016-06-24 12:00:00', '0000-00-00 00:00:00'),
(12, 1, 2, 'title11', 'link11', 'desc11', 0, '2016-06-22 17:00:00', '2016-06-23 01:45:29');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `email`) VALUES
(1, 'user1@gmail.com'),
(2, 'user2@gmail.com'),
(3, 'user3@gmail.com'),
(4, 'user4@gmail.com'),
(5, 'user5@gmail.com');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
