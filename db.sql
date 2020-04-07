-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Апр 07 2020 г., 14:50
-- Версия сервера: 5.5.64-MariaDB
-- Версия PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `added` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `admins`
--

INSERT INTO `admins` (`id`, `uid`, `created`, `added`) VALUES
(8, 8, 1583273432, 2),
(14, 14, 1583325538, 2),
(17, 17, 1583694282, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `apps`
--

CREATE TABLE `apps` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `type` int(11) NOT NULL,
  `datereg` int(11) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `apps`
--

INSERT INTO `apps` (`id`, `title`, `description`, `type`, `datereg`, `secret`, `deleted`) VALUES
(1, 'Авторизация на сайте', 'Основное приложение для авторизации пользователей на сайте', 0, 1580606520, 'e37379a73099d51ac9d36a9ca24986c2', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `app_sessions`
--

CREATE TABLE `app_sessions` (
  `id` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `type` int(11) NOT NULL,
  `ip` text NOT NULL,
  `last_call` int(11) NOT NULL,
  `call_count` int(11) NOT NULL,
  `block_lvl` int(11) NOT NULL,
  `block_time` int(11) NOT NULL,
  `user_agent` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `app_sessions`
--

INSERT INTO `app_sessions` (`id`, `aid`, `uid`, `created`, `token`, `type`, `ip`, `last_call`, `call_count`, `block_lvl`, `block_time`, `user_agent`) VALUES
(1, 1, 1, 1582625060, '7ee9d1b04acf4994b4b761b5de1d517f', 0, '95.32.85.110', 1582625060, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.2.177 Yowser/2.5 Safari/537.36'),
(2, 1, 1, 1582625754, '058451333ad79219759c1147698949ed', 0, '195.211.23.207', 1582625754, 0, 0, 0, 'Mozilla/5.0 (compatible; vkShare; +http://vk.com/dev/Share)'),
(3, 1, 1, 1583060714, '0d949eff664e33aa52945450c2c7a57d', 0, '10.100.13.110', 1583060714, 0, 0, 0, ''),
(4, 1, 1, 1583060985, 'c55cd98c7cd39c20ec5156f5de8b06a8', 0, '10.100.13.110', 1583060985, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(5, 1, 1, 1583060990, 'b83bd5b18e21acec894f73bb76cdf714', 0, '10.100.13.110', 1583060990, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(6, 1, 1, 1583061099, 'e0f2a8c7f11a9f3aeef637257d481386', 0, '10.100.13.110', 1583061099, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(7, 1, 1, 1583061150, 'fa59df96c0b2772a79c75053a0fb1e51', 0, '10.100.13.110', 1583061150, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(8, 1, 1, 1583061150, '34a043cd9048c8391195f30721e0ccac', 0, '10.100.13.110', 1583061150, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(9, 1, 1, 1583061236, '2b05b167a59f5125531c0d7bb2a141a3', 0, '10.100.13.110', 1583061236, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(10, 1, 1, 1583061265, '7ea254d3e23d09fb7cd86113c0d406cb', 0, '10.100.13.110', 1583061265, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(11, 1, 1, 1583061412, '3b605a978dd39d2fb8de8b58be1e00f5', 0, '10.100.13.110', 1583061412, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(12, 1, 1, 1583061632, '8755e05596a9619bab67c5d31c62ac91', 0, '10.100.13.110', 1583061632, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(13, 1, 1, 1583061816, '73d9bb2a2b561027803576eb23bc7a2e', 0, '10.100.13.110', 1583061816, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(14, 1, 1, 1583061923, '1f501108d837e3f788d006a0c3f42c9e', 0, '10.100.13.110', 1583061923, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(15, 1, 1, 1583062060, 'e40e9b2ccda26666d7bbaef61e562a36', 0, '10.100.13.110', 1583062060, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(19, 1, 1, 1583152175, '2acf7f3f0648bd3a8666ff6e8a770269', 0, '10.100.13.110', 1583152175, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(25, 1, 1, 1583186011, '07564a32899133f017b974ef0cc2d5b6', 0, '10.100.13.110', 1583186011, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(26, 1, 2, 1583230662, 'f44ff9d1b0754626ce3ce1d91c700a87', 0, '10.100.13.110', 1583230662, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(32, 1, 2, 1583242664, '5c3f62647a5c6bb057a7a32b2f4ba5ed', 0, '10.100.13.110', 1583242664, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(33, 1, 2, 1583242670, '31765f9c7dbfd5db90d8a1b9fc806828', 0, '10.100.13.110', 1583242670, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(38, 1, 2, 1583242985, '4624d25e729c63af4109f6ad2d5b7e0f', 0, '10.100.13.110', 1583242985, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(39, 1, 2, 1583243011, '85fac34db6689e81226780a43132256b', 0, '10.100.13.110', 1583243011, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(40, 1, 2, 1583243011, '9eab6a2b7dedab2c2014bdd8f95fb393', 0, '10.100.13.110', 1583243011, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(42, 1, 2, 1583243017, 'd719fe49c071545dae74e78dc72ce111', 0, '10.100.13.110', 1583243017, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(43, 1, 2, 1583243017, 'cdaefaa5ba75af1ec85dead5f9711ba4', 0, '10.100.13.110', 1583243017, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(44, 1, 2, 1583243017, '2759682b003f65a02ad9281275f2fd5d', 0, '10.100.13.110', 1583243017, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(45, 1, 2, 1583243017, '5b2617a375a12a340fb36baaa38b31a4', 0, '10.100.13.110', 1583243017, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(46, 1, 2, 1583243018, '2875e75a851356f589d9f841aaecbecf', 0, '10.100.13.110', 1583243018, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(47, 1, 2, 1583243018, 'e0d1097a0e015ce2e13cd2acfcd74d50', 0, '10.100.13.110', 1583243018, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(48, 1, 2, 1583243018, 'f34f1a8264857619c16e3abe719e4f82', 0, '10.100.13.110', 1583243018, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(50, 1, 2, 1583243024, '52d5005c16fb24fffbb7fa41b2d4a351', 0, '10.100.13.110', 1583243024, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(51, 1, 2, 1583243024, 'c2251219cbaf8559a63c109a46a2540a', 0, '10.100.13.110', 1583243024, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(52, 1, 2, 1583243025, '4dc1a4967f82664e97aa043967197578', 0, '10.100.13.110', 1583243025, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(53, 1, 2, 1583243025, 'ce8372fabf71c1aefba39cbe96ee40ea', 0, '10.100.13.110', 1583243025, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(54, 1, 2, 1583243025, '7bd5f5acb3bc7601eb385e274d940511', 0, '10.100.13.110', 1583243025, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(55, 1, 2, 1583243026, '3dfc9b3980eb41d60aac3404d43bbaf3', 0, '10.100.13.110', 1583243026, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(56, 1, 2, 1583243026, 'f7cd77f1f483ce948d1b8273d1e1a820', 0, '10.100.13.110', 1583243026, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(57, 1, 2, 1583243026, 'ecb69cab9cd55afb6bfafeb956afa8a0', 0, '10.100.13.110', 1583243026, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(58, 1, 2, 1583243027, 'c4bcfe8b81c7c70b30244371cdb78ce0', 0, '10.100.13.110', 1583243027, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(60, 1, 2, 1583243114, '0fcf7bbfc7d0685f5d18097ef3da6782', 0, '10.100.13.110', 1583243114, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(62, 1, 2, 1583243118, 'edfe74d2e7a864735c88337c29e29ef3', 0, '10.100.13.110', 1583243118, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(63, 1, 2, 1583243118, 'cff25bce2ff76271643d7128708a1500', 0, '10.100.13.110', 1583243118, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(64, 1, 2, 1583243120, '73e61535590ff353ee4b20cebcc9ba99', 0, '10.100.13.110', 1583243120, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(65, 1, 2, 1583243120, '42224c2d2080b35f8ce3cc9bbf67f77a', 0, '10.100.13.110', 1583243120, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(66, 1, 2, 1583243120, '04560b2d273b3c2a5b077cb9d6e576c0', 0, '10.100.13.110', 1583243120, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(67, 1, 2, 1583243121, '023362d1bb80fb3721aa62d1f1fd1d81', 0, '10.100.13.110', 1583243121, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(68, 1, 2, 1583243121, '7a9fedf384d8f352ca712b14623cb87d', 0, '10.100.13.110', 1583243121, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(70, 1, 2, 1583243152, '5994f44628a90b5321a617b19cbf8bd0', 0, '10.100.13.110', 1583243152, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(71, 1, 2, 1583243152, 'a6d531bf03185747acc4e0af9247cf33', 0, '10.100.13.110', 1583243152, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(72, 1, 2, 1583243152, '0a1efc570edc865b7d05e283a1231b71', 0, '10.100.13.110', 1583243152, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(73, 1, 2, 1583243152, 'f94a999776469caf6bc85c3b19330720', 0, '10.100.13.110', 1583243152, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(74, 1, 2, 1583243153, '806ee036bef79145e9e65aed8db79e94', 0, '10.100.13.110', 1583243153, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(75, 1, 2, 1583243153, 'fb4ac00a060da32861bc154278c31886', 0, '10.100.13.110', 1583243153, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(76, 1, 2, 1583243154, '9eaa567c80914ac5b7e8fdc3accea17a', 0, '10.100.13.110', 1583243154, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(77, 1, 2, 1583243154, '5c1dd8c23bb1ed9db2924d01ae35f046', 0, '10.100.13.110', 1583243154, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(78, 1, 2, 1583243154, '1d769c57df4ada80d88ac2e61deb6b52', 0, '10.100.13.110', 1583243154, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(79, 1, 2, 1583243155, '1df08975809ba1c52ac2ad0543e4c22a', 0, '10.100.13.110', 1583243155, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(80, 1, 2, 1583243155, '045f9e75f353f5d7a672d3ad100e13af', 0, '10.100.13.110', 1583243155, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(81, 1, 2, 1583243156, '68f51c31115d47a1052c62032b7fa147', 0, '10.100.13.110', 1583243156, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(82, 1, 2, 1583243156, 'f5bfe1eced953c211eddb0bab51ce671', 0, '10.100.13.110', 1583243156, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(83, 1, 2, 1583243156, '0657cbf009680022bfb86837ad66bb45', 0, '10.100.13.110', 1583243156, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(85, 1, 2, 1583243165, 'aa3335bce588c6b0de3aec0368128330', 0, '10.100.13.110', 1583243165, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(86, 1, 2, 1583243165, 'ac04e14f6562de7f629e1dd58e989b50', 0, '10.100.13.110', 1583243165, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(87, 1, 2, 1583243166, '7ef5a63791b2e51cb3e6756b623fc5ba', 0, '10.100.13.110', 1583243166, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(88, 1, 2, 1583243171, '8df1c5a0f991b9b1d0d1dbcdb9e58cf1', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(89, 1, 2, 1583243171, 'e99613b1810aaf7790a5fa7789004e1b', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(90, 1, 2, 1583243171, '79d52a34b8761d82df20659b99e9faa1', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(91, 1, 2, 1583243171, 'd1a918676ca77a7282bf60f861fa00fd', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(92, 1, 2, 1583243171, '8f3aa3b4d8ae6b2908f0f882628b1e79', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(93, 1, 2, 1583243171, '5141ce3b283f69b7c1eab11c37bb3cf7', 0, '10.100.13.110', 1583243171, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(94, 1, 2, 1583243173, '007c207dcd6376363018d46e9c6f0230', 0, '10.100.13.110', 1583243173, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(95, 1, 2, 1583243173, 'd6ec0e8028f27d1026d9f468bebb6f7d', 0, '10.100.13.110', 1583243173, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(96, 1, 2, 1583243173, '57c4688562eb5eb47a476cc5a767ed0f', 0, '10.100.13.110', 1583243173, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(97, 1, 2, 1583243173, 'd702e90defcd38c52e36c826470a85da', 0, '10.100.13.110', 1583243173, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(98, 1, 2, 1583243174, 'c557a48acba806608b45f845529fc8f4', 0, '10.100.13.110', 1583243174, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(99, 1, 2, 1583243174, '54ee3474ccab2847569927084ac8efc2', 0, '10.100.13.110', 1583243174, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(100, 1, 2, 1583243175, '8511934d9ba19f98ae0ba83232ce13d5', 0, '10.100.13.110', 1583243175, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(101, 1, 2, 1583243175, '239e45c2c89af27193467b5a7edaad86', 0, '10.100.13.110', 1583243175, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(102, 1, 2, 1583243176, 'f7024c40b33a0dada1a1bf10376db820', 0, '10.100.13.110', 1583243176, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(103, 1, 2, 1583243176, 'a01805adc58bec6c0b694ed68f869105', 0, '10.100.13.110', 1583243176, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(104, 1, 2, 1583243177, 'ed2302fa47529acb2ebef803fc3d606d', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(105, 1, 2, 1583243177, '6fd12ee5b4018b514e04673b178496fe', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(106, 1, 2, 1583243177, 'ad20ed271eae7ef96572b318826381c1', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(107, 1, 2, 1583243177, '470366dde141f5637cc2d19c6041a23b', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(108, 1, 2, 1583243177, '4b0a6cfa6718f85b50f3eabfb5d0c3ee', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(109, 1, 2, 1583243177, '4b90a2cdcf994f44f05e188c1c4a6232', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(110, 1, 2, 1583243177, '217283715278e10dd034acec89e9397a', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(111, 1, 2, 1583243177, 'a3a2ac437f9fe12e901eb49c94f588ce', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(112, 1, 2, 1583243177, 'b36e01b61140f5802cad0fc35bcb116b', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(113, 1, 2, 1583243177, 'a82f7f3a38a13aeeec0f170e2d113b59', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(114, 1, 2, 1583243177, '704609ee0636e36c943a66cf4e7df3c8', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(115, 1, 2, 1583243177, '0ce8db02f8e305fa44645f01ba30fe58', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(116, 1, 2, 1583243177, '87ea87a9ff59e0b469b16e4667c86199', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(117, 1, 2, 1583243177, '403ea70ef267e1e1a0e3252263e970c2', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(118, 1, 2, 1583243177, 'b86b140669788eb541c400b618f33928', 0, '10.100.13.110', 1583243177, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(119, 1, 2, 1583243178, 'b4035aae94369c90aa8ba0b335dae288', 0, '10.100.13.110', 1583243178, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(121, 1, 2, 1583243204, '6b455efe3344cfc183bf68a2897431d9', 0, '10.100.13.110', 1583243204, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(122, 1, 2, 1583243206, '2096ab8c6cd0e3bcc685eebf89d2a3c7', 0, '10.100.13.110', 1583243206, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(123, 1, 2, 1583243206, '5103fb14e7c685e132455ec8b2606cc4', 0, '10.100.13.110', 1583243206, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(124, 1, 2, 1583243206, '2e6baaf8a4ecd01d009efad51f096af0', 0, '10.100.13.110', 1583243206, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(125, 1, 2, 1583243206, '6624367a04f153329fb0f558c92b748f', 0, '10.100.13.110', 1583243206, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(127, 1, 2, 1583243211, 'c5d78638a6f6148d85367c0b2fc09efd', 0, '10.100.13.110', 1583243211, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(128, 1, 2, 1583243211, '926074e2576ddf8d1cf6e65e60b50ed9', 0, '10.100.13.110', 1583243211, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(129, 1, 2, 1583243212, '742f08ff9643e310a9a749c39e79a3ef', 0, '10.100.13.110', 1583243212, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(132, 1, 2, 1583243385, '29ddf0be42d86d985a8cae6bf53f98cc', 0, '10.100.13.110', 1583243385, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(133, 1, 2, 1583243385, 'be42d97a4b13dd0881b3b7dd716c98a3', 0, '10.100.13.110', 1583243385, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(134, 1, 2, 1583243386, 'ec5279ed5c6af57bf48692d521b55941', 0, '10.100.13.110', 1583243386, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(136, 1, 2, 1583243399, '3f8dc26cc952a299663976674f0c587b', 0, '10.100.13.110', 1583243399, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(137, 1, 2, 1583243399, 'd945cb8e4b3cf741eb9960fea5d80559', 0, '10.100.13.110', 1583243399, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(138, 1, 2, 1583243399, '6575856457155808a6a9b2741d71d6b6', 0, '10.100.13.110', 1583243399, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(139, 1, 2, 1583243400, 'f670e01257579fd1ded6ccc5ac1f5be0', 0, '10.100.13.110', 1583243400, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(140, 1, 2, 1583243400, '70f2f2e6e40ea71736d8e14396390843', 0, '10.100.13.110', 1583243400, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(141, 1, 2, 1583243401, '07f47b941da84b2cbbaa668adf3f8b57', 0, '10.100.13.110', 1583243401, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(142, 1, 2, 1583243401, '09b18b7e3bd38c75f8ddc2572c16fdf9', 0, '10.100.13.110', 1583243401, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(143, 1, 2, 1583243401, '46fd51bb7dd60b1d1e6ef283ab530e1e', 0, '10.100.13.110', 1583243401, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(145, 1, 2, 1583243477, 'bd102f0d2ab0c16254f449bf2803f062', 0, '10.100.13.110', 1583243477, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.3.213 Yowser/2.5 Safari/537.36'),
(149, 1, 2, 1583256944, 'e9a19925ece2a4e746c2584713b46a2d', 0, '10.100.13.110', 1583256944, 0, 0, 0, 'Mozilla/5.0 (Linux; Android 8.1.0; Redmi 6A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 Mobile Safari/537.36'),
(150, 1, 2, 1583256947, 'aa9dd42d8b84e5e7903b94f9828f5aea', 0, '10.100.13.110', 1583256947, 0, 0, 0, 'Mozilla/5.0 (Linux; Android 8.1.0; Redmi 6A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 Mobile Safari/537.36'),
(153, 1, 2, 1583269952, '9cdf0b508e485dc46a5077d6fd3985b0', 0, '10.100.13.110', 1583269952, 0, 0, 0, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36'),
(154, 1, 2, 1583271005, '02b412ceb4a060b89a01661b14a0d16a', 0, '10.100.13.110', 1583271005, 0, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.5 Mobile/15E148 Safari/604.1'),
(155, 1, 2, 1583273393, '414e7640ad49eebc5e259febfb7648c1', 0, '10.100.13.110', 1583273393, 0, 0, 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36'),
(157, 1, 16, 1583325957, 'e5c161acd80df189785504023f2a57a7', 0, '10.100.13.110', 1583325957, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.4.143 Yowser/2.5 Safari/537.36'),
(158, 1, 16, 1583326023, 'f2dcb7749c3c8f39480cb974a5f30cdb', 0, '10.100.13.110', 1583326023, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.4.143 Yowser/2.5 Safari/537.36'),
(161, 1, 2, 1583536803, '59da985e74a06b26098ac69405a15b76', 0, '10.100.13.110', 1583536803, 0, 0, 0, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.136 YaBrowser/20.2.4.143 Yowser/2.5 Safari/537.36'),
(164, 1, 17, 1583694289, '9d63b0260c346bc22b663b8759cf7042', 0, '10.100.13.110', 1583694289, 0, 0, 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'),
(169, 1, 2, 1583955736, '0ba55e6c39d0a42564a7759f33b57d3b', 0, '10.100.13.110', 1583955736, 0, 0, 0, 'Mozilla/5.0 (Linux; arm; Android 10; SNE-LX1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 YaBrowser/20.2.2.128.00 Mobile Safari/537.36'),
(182, 1, 2, 1584310402, '371f1a2364db3b86416dd4042a405b44', 0, '10.100.13.110', 1584310402, 0, 0, 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'),
(185, 1, 27, 1584525929, 'f1d0f9905b27c820f1ef37c03e475690', 0, '134.17.27.106', 1584525929, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(188, 1, 2, 1584528662, '8a4e0b1028f52d0975903d9c23910433', 0, '10.100.13.110', 1584528662, 0, 0, 0, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36'),
(192, 1, 28, 1584540108, '9032f8933852b53c5489fee549ad1c53', 0, '134.17.27.106', 1584540108, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(225, 1, 32, 1584641826, '77580fc4dd8ee3e6c7c0b901228be50e', 0, '46.56.233.71', 1584641826, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(227, 1, 2, 1584745997, '5cf97900331b487f9bfca73d69547bd4', 0, '10.100.13.110', 1584745997, 0, 0, 0, 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 YaBrowser/20.3.0.1223 Yowser/2.5 Yptp/1.23 Safari/537.36'),
(231, 1, 18, 1584990523, '6ae1f61c94af007baf9bdbc11864c7bf', 0, '37.214.78.220', 1584990523, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(240, 1, 34, 1585070655, 'd3193754cf6ee92856f2fa26edc5e5ab', 0, '134.17.27.106', 1585070655, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(248, 1, 33, 1585083343, 'f241d30e742cbc176529a5906f5d2e54', 0, '37.214.77.220', 1585083343, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(257, 1, 35, 1585141941, 'c64646d9797f790679e731305d1d89b0', 0, '46.56.236.35', 1585141941, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(260, 1, 36, 1585220759, '38d5a9de4bc757413cab95ea83bbcafc', 0, '46.56.236.179', 1585220759, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(262, 1, 19, 1585261397, '39cffeb41ee08460c4a60400a9521ec0', 0, '37.214.78.220', 1585261397, 0, 0, 0, 'Dart/2.8 (dart:io)'),
(265, 1, 20, 1585474501, '6a836b5d1f2d6e459903637453d9296c', 0, '46.56.240.64', 1585474501, 0, 0, 0, 'Dart/2.8 (dart:io)');

-- --------------------------------------------------------

--
-- Структура таблицы `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `text` longtext NOT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `history`
--

INSERT INTO `history` (`id`, `uid`, `type`, `text`, `created`) VALUES
(1, 2, 0, 'Зарегистрировал администратора test', 1583246277),
(2, 2, 0, 'Зарегистрировал администратора test2', 1583248245),
(3, 2, 0, 'Зарегистрировал администратора andreu_piska_9cm', 1583273432),
(4, 2, 0, 'Удалил администратора ', 1583320466),
(5, 2, 0, 'Удалил администратора test2', 1583320499),
(6, 2, 0, 'Зарегистрировал администратора test', 1583322665),
(7, 2, 0, 'Удалил администратора test', 1583323038),
(8, 2, 0, 'Зарегистрировал администратора test', 1583323154),
(9, 2, 0, 'Зарегистрировал администратора test1', 1583323170),
(10, 2, 0, 'Зарегистрировал администратора tester', 1583323999),
(11, 2, 0, 'Удалил администратора tester', 1583324728),
(12, 2, 0, 'Удалил администратора test1', 1583324736),
(13, 2, 0, 'Зарегистрировал администратора adm', 1583325448),
(14, 2, 0, 'Зарегистрировал администратора stepa_lox', 1583325538),
(15, 2, 0, 'Удалил администратора test', 1583325756),
(16, 2, 0, 'Зарегистрировал администратора test', 1583325811),
(17, 2, 0, 'Удалил администратора test', 1583325942),
(18, 2, 0, 'Удалил администратора adm', 1583325944),
(19, 2, 0, 'Зарегистрировал администратора test', 1583325954),
(20, 2, 0, 'Удалил администратора test', 1583326039),
(21, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1583344410),
(22, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1583350406),
(23, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1583350463),
(24, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1583350478),
(25, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1583350537),
(26, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1583350591),
(27, 2, 0, 'Зарегистрировал администратора lol', 1583694282),
(28, 18, 1, 'Зарегистрировался', 1584038634),
(29, 19, 1, 'Зарегистрировался', 1584125523),
(30, 20, 1, 'Зарегистрировался', 1584128252),
(31, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584218015),
(32, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1584218027),
(33, 2, 0, 'Зарегистрировал администратора test', 1584264682),
(34, 2, 0, 'Зарегистрировал администратора test', 1584264844),
(35, 2, 0, 'Перенёс  в группу технической поддержки', 1584266580),
(36, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266602),
(37, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266605),
(38, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266609),
(39, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266610),
(40, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584266614),
(41, 2, 0, 'Перенёс lol в группу технической поддержки', 1584266618),
(42, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266620),
(43, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266621),
(44, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584266623),
(45, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266623),
(46, 2, 0, 'Перенёс lol в группу технической поддержки', 1584266627),
(47, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584266697),
(48, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266698),
(49, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584266699),
(50, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584266699),
(51, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1584266701),
(52, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584266702),
(53, 2, 0, 'Перенёс lol в группу администраторов', 1584266702),
(54, 2, 0, 'Перенёс lol в группу технической поддержки', 1584266703),
(55, 2, 0, 'Перенёс lol в группу администраторов', 1584266704),
(56, 2, 0, 'Перенёс lol в группу технической поддержки', 1584266705),
(57, 2, 0, 'Перенёс lol в группу администраторов', 1584266706),
(58, 2, 0, 'Перенёс lol в группу технической поддержки', 1584266710),
(59, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584266880),
(60, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1584266884),
(61, 2, 0, 'Перенёс lol в группу администраторов', 1584266884),
(62, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267210),
(63, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267213),
(64, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267443),
(65, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267446),
(66, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267524),
(67, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267541),
(68, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267616),
(69, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267617),
(70, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267633),
(71, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267635),
(72, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267638),
(73, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584267638),
(74, 2, 0, 'Перенёс lol в группу технической поддержки', 1584267639),
(75, 2, 0, 'Перенёс test в группу технической поддержки', 1584267640),
(76, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267641),
(77, 2, 0, 'Перенёс stepa_lox в группу администраторов', 1584267642),
(78, 2, 0, 'Перенёс lol в группу администраторов', 1584267642),
(79, 2, 0, 'Перенёс test в группу администраторов', 1584267643),
(80, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267644),
(81, 2, 0, 'Перенёс stepa_lox в группу технической поддержки', 1584267645),
(82, 2, 0, 'Перенёс lol в группу технической поддержки', 1584267646),
(83, 2, 0, 'Перенёс test в группу технической поддержки', 1584267646),
(84, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267693),
(85, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267693),
(86, 2, 0, 'Перенёс andreu_piska_9cm в группу администраторов', 1584267694),
(87, 2, 0, 'Перенёс andreu_piska_9cm в группу технической поддержки', 1584267694),
(88, 2, 0, 'Удалил администратора test', 1584267884),
(89, 23, 1, 'Зарегистрировался', 1584466174),
(90, 24, 1, 'Зарегистрировался', 1584470229),
(91, 25, 1, 'Зарегистрировался', 1584471719),
(92, 26, 1, 'Зарегистрировался', 1584525675),
(93, 27, 1, 'Зарегистрировался', 1584525913),
(94, 28, 1, 'Зарегистрировался', 1584540090),
(95, 29, 1, 'Зарегистрировался', 1584540174),
(96, 30, 1, 'Зарегистрировался', 1584541702),
(97, 31, 1, 'Зарегистрировался', 1584549371),
(98, 32, 1, 'Зарегистрировался', 1584641822),
(99, 33, 1, 'Зарегистрировался', 1585058100),
(100, 34, 1, 'Зарегистрировался', 1585070650),
(101, 35, 1, 'Зарегистрировался', 1585141918),
(102, 36, 1, 'Зарегистрировался', 1585220729);

-- --------------------------------------------------------

--
-- Структура таблицы `rents`
--

CREATE TABLE `rents` (
  `id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `start_location` text NOT NULL,
  `end_location` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `rents`
--

INSERT INTO `rents` (`id`, `created`, `uid`, `tid`, `start_location`, `end_location`, `status`) VALUES
(1, 1584189070, 18, 0, 'г. Москва, ул. Проектируемый проезд, д. 228', '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `replenishments`
--

CREATE TABLE `replenishments` (
  `id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `replenishments`
--

INSERT INTO `replenishments` (`id`, `value`, `created`, `type`, `uid`, `status`) VALUES
(1, 100, 1584189070, 0, 1, 1),
(2, 0, 1584189070, 0, 1, 0),
(3, 0, 1584189070, 0, 1, 0),
(4, 0, 1584189070, 0, 1, 0),
(5, 50, 1584990022, 0, 1, 0),
(6, 50, 1585060665, 0, 19, 0),
(7, 50, 1585061367, 0, 19, 0),
(8, 50, 1585061440, 1, 19, 2),
(9, 50, 1585062660, 0, 19, 2),
(10, 50, 1585062751, 0, 19, 2),
(11, 50, 1585062786, 1, 19, 2),
(12, 50, 1585062789, 0, 19, 2),
(13, 50, 1585062912, 1, 19, 2),
(14, 20, 1585063033, 0, 19, 2),
(15, 20, 1585063078, 0, 19, 2),
(16, 25, 1585063178, 1, 19, 2),
(17, 200, 1585067941, 0, 19, 2),
(18, 12, 1585070350, 0, 19, 2),
(19, 200, 1585070687, 0, 34, 2),
(20, 23, 1585071169, 0, 19, 2),
(21, 50, 1585082605, 0, 19, 2),
(22, 1200, 1585083110, 0, 19, 2),
(23, 120, 1585088812, 0, 19, 2),
(24, 200, 1585129964, 0, 19, 2),
(25, 100, 1585131361, 0, 20, 2),
(26, 200, 1585132304, 0, 20, 2),
(27, 200, 1585132311, 0, 20, 2),
(28, 25, 1585134837, 0, 20, 2),
(29, 50, 1585138149, 0, 19, 2),
(30, 200, 1585140399, 0, 20, 2),
(31, 300, 1585141978, 0, 35, 2),
(32, 200, 1585146106, 0, 19, 2),
(33, 30, 1585219443, 0, 19, 2),
(34, 20, 1585219475, 0, 19, 2),
(35, 222, 1585220660, 0, 35, 2),
(36, 222, 1585220780, 0, 36, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `transports`
--

CREATE TABLE `transports` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `sid` text NOT NULL,
  `created` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `transports`
--

INSERT INTO `transports` (`id`, `type`, `sid`, `created`, `status`, `uid`) VALUES
(1, 0, '000001001', 1584189070, 0, 0),
(2, 1, '000002001', 1584189070, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `phone` text NOT NULL,
  `password` text NOT NULL,
  `created` int(11) NOT NULL,
  `verify_block` int(11) NOT NULL DEFAULT '0',
  `verify_block_time` int(11) NOT NULL,
  `verify_code` int(11) NOT NULL,
  `verify_created` int(11) NOT NULL,
  `verify_checked` int(11) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `admin` int(11) NOT NULL DEFAULT '0',
  `support` int(11) NOT NULL DEFAULT '0',
  `rent` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `phone`, `password`, `created`, `verify_block`, `verify_block_time`, `verify_code`, `verify_created`, `verify_checked`, `balance`, `admin`, `support`, `rent`) VALUES
(1, '77777777777', '', 1582620638, 0, 0, 5895, 1582622407, 3, 0, 0, 0, 0),
(2, 'admin', '$2y$10$1jHCQEYSJIjsMxUO48tdmuZsKa71ybpAbw7n5nQ9ohhztNFwiwVCK', 1582620638, 0, 0, 0, 0, 0, 0, 1, 0, 0),
(8, 'andreu_piska_9cm', '$2y$10$9KTkOKjupCkxcgzMKuhUk.0g2RBuepvz5nOaopjrQfMFSTZrH1Bb6', 1583273432, 0, 0, 0, 0, 0, 0, 1, 1, 0),
(14, 'stepa_lox', '$2y$10$pR85UqS6XsGBrwR15LIP1u8TNK1UVpW.vdX9ZAze2aBuWVPlRf0Sa', 1583325538, 0, 0, 0, 0, 0, 0, 1, 1, 0),
(17, 'lol', '$2y$10$w6WH6wvFiuDs1gQUUF5UqOqenSzZU19wJ9icNmg51Z.WFr9sd/RJy', 1583694282, 0, 0, 0, 0, 0, 0, 1, 1, 0),
(18, '7777777777', '', 1584038634, 1, 0, 0, 1584990516, 3, 0, 0, 0, 1),
(19, '375291181186', '', 1584125523, 3, 1584526342, 0, 1585261388, 3, 2470, 0, 0, 0),
(20, '375447300499', '', 1584128252, 0, 0, 0, 1585474495, 3, 725, 0, 0, 0),
(23, '447300499', '', 1584466174, 0, 0, 3254, 1584466174, 3, 0, 0, 0, 0),
(24, '375356588888', '', 1584470229, 0, 0, 6269, 1584471561, 3, 0, 0, 0, 0),
(25, '375555555585', '', 1584471719, 0, 0, 3071, 1584471719, 3, 0, 0, 0, 0),
(26, '3751234', '', 1584525675, 0, 0, 3533, 1584525675, 3, 0, 0, 0, 0),
(27, '375291181189', '', 1584525913, 3, 1584525943, 6606, 1584525935, 2, 0, 0, 0, 0),
(28, '375297575785', '', 1584540090, 0, 0, 0, 1584540090, 2, 0, 0, 0, 0),
(29, '3757676767', '', 1584540174, 0, 0, 9133, 1584540174, 3, 0, 0, 0, 0),
(30, '375494976769', '', 1584541702, 0, 0, 2651, 1584541758, 3, 0, 0, 0, 0),
(31, '375261181186', '', 1584549371, 0, 0, 7007, 1584549371, 3, 0, 0, 0, 0),
(32, '375447308499', '', 1584641822, 0, 0, 0, 1584641822, 3, 0, 0, 0, 0),
(33, '375291231231', '', 1585058100, 0, 0, 0, 1585083340, 3, 0, 0, 0, 0),
(34, '375291863861', '', 1585070650, 0, 0, 0, 1585070650, 3, 200, 0, 0, 0),
(35, '375296544057', '', 1585141918, 0, 0, 0, 1585141918, 2, 522, 0, 0, 0),
(36, '375295273566', '', 1585220729, 0, 0, 0, 1585220729, 3, 222, 0, 0, 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `app_sessions`
--
ALTER TABLE `app_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rents`
--
ALTER TABLE `rents`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `replenishments`
--
ALTER TABLE `replenishments`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `transports`
--
ALTER TABLE `transports`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `apps`
--
ALTER TABLE `apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `app_sessions`
--
ALTER TABLE `app_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=266;

--
-- AUTO_INCREMENT для таблицы `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT для таблицы `rents`
--
ALTER TABLE `rents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `replenishments`
--
ALTER TABLE `replenishments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `transports`
--
ALTER TABLE `transports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
