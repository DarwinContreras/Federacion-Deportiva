-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 21, 2018 at 03:03 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `federacion`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `emparejar`(IN nombre_equipo VARCHAR(45))
BEGIN
DECLARE nombre_aux VARCHAR(45) DEFAULT '';
DECLARE cod1 INT default 0;
DECLARE cod2 INT default 0;
DECLARE DONE BOOL DEFAULT FALSE;
DECLARE cursorx CURSOR for SELECT nombre FROM equipos;
DECLARE CONTINUE HANDLER for NOT FOUND SET DONE = TRUE;
OPEN cursorx;
CICLO: LOOP
FETCH cursorx INTO nombre_aux;
IF DONE THEN
            LEAVE CICLO;
        END IF;
SET cod1 = (SELECT id_equipo FROM equipos WHERE nombre = nombre_equipo);
SET cod2 = (SELECT id_equipo FROM equipos WHERE nombre = nombre_aux);
if ( nombre_aux != nombre_equipo AND (SELECT COUNT(*) FROM partidos WHERE (equipo1 = cod1 AND equipo2 = cod2) OR (equipo2 = cod1 AND equipo1 = cod2))=0) THEN
INSERT INTO partidos (equipo1, equipo2) VALUES (cod1, cod2);
END IF;
END LOOP;
CLOSE cursorx;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `emparejar2`()
BEGIN
DECLARE nombre_aux VARCHAR(45) DEFAULT '';
DECLARE DONE BOOL DEFAULT FALSE;
DECLARE cursorx CURSOR for SELECT nombre FROM equipos;
DECLARE CONTINUE HANDLER for NOT FOUND SET DONE = TRUE;
OPEN cursorx;
CICLO: LOOP
FETCH cursorx INTO nombre_aux;
IF DONE THEN
            LEAVE CICLO;
END IF;
CALL emparejar(nombre_aux);
END LOOP;
CLOSE cursorx;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `equipos`
--

CREATE TABLE IF NOT EXISTS `equipos` (
  `id_equipo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  PRIMARY KEY (`id_equipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `equipos`
--

INSERT INTO `equipos` (`id_equipo`, `nombre`, `provincia`) VALUES
(8, 'Liga de Portoviejo', 'Manabí'),
(9, 'Barcelona', 'Guayas'),
(10, 'Emelec', 'Guayas'),
(11, 'Liga de Quito', 'Pichincha'),
(12, 'Independiente del Valle', 'Pichincha'),
(13, 'EquipoA', 'Azuay'),
(14, 'EquipoB', 'Azuay'),
(15, 'EquipoC', 'Azuay'),
(16, 'EquipoD', 'Azuay'),
(17, 'EquipoE', 'Azuay'),
(18, 'EquipoF', 'Azuay'),
(19, 'EquipoG', 'Azuay'),
(20, 'LIGA', 'Pichincha'),
(21, 'ligas del carmen', 'Manabí'),
(22, 'AUCAS', 'Pichincha');

-- --------------------------------------------------------

--
-- Table structure for table `jugadores`
--

CREATE TABLE IF NOT EXISTS `jugadores` (
  `cedula` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `nacionalidad` varchar(45) NOT NULL,
  `id_equipo` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cedula`) USING BTREE,
  KEY `FK_jugadores_1` (`id_equipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1723901909 ;

--
-- Dumping data for table `jugadores`
--

INSERT INTO `jugadores` (`cedula`, `nombre`, `apellido`, `nacionalidad`, `id_equipo`) VALUES
(1234102310, 'EDISON', 'MENDEZ', 'ECUATORIANA', 9),
(1723901908, 'Darwin ', 'Contreras', 'Ecuatoriana', 11);

-- --------------------------------------------------------

--
-- Table structure for table `partidos`
--

CREATE TABLE IF NOT EXISTS `partidos` (
  `id_partido` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `equipo1` int(10) unsigned NOT NULL,
  `equipo2` int(10) unsigned NOT NULL,
  `jugado` tinyint(1) NOT NULL DEFAULT '0',
  `equipo_1_goles` int(10) unsigned NOT NULL DEFAULT '0',
  `equipo_2_goles` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_partido`),
  KEY `FK_partidos_1` (`equipo1`),
  KEY `FK_partidos_2` (`equipo2`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1051 ;

--
-- Dumping data for table `partidos`
--

INSERT INTO `partidos` (`id_partido`, `equipo1`, `equipo2`, `jugado`, `equipo_1_goles`, `equipo_2_goles`) VALUES
(946, 8, 9, 0, 0, 0),
(947, 8, 10, 0, 0, 0),
(948, 8, 11, 0, 0, 0),
(949, 8, 12, 0, 0, 0),
(950, 8, 13, 0, 0, 0),
(951, 8, 14, 0, 0, 0),
(952, 8, 15, 0, 0, 0),
(953, 8, 16, 0, 0, 0),
(954, 8, 17, 0, 0, 0),
(955, 8, 18, 0, 0, 0),
(956, 8, 19, 0, 0, 0),
(957, 8, 20, 0, 0, 0),
(958, 8, 21, 0, 0, 0),
(959, 8, 22, 0, 0, 0),
(960, 9, 10, 0, 0, 0),
(961, 9, 11, 0, 0, 0),
(962, 9, 12, 0, 0, 0),
(963, 9, 13, 0, 0, 0),
(964, 9, 14, 0, 0, 0),
(965, 9, 15, 0, 0, 0),
(966, 9, 16, 0, 0, 0),
(967, 9, 17, 0, 0, 0),
(968, 9, 18, 0, 0, 0),
(969, 9, 19, 0, 0, 0),
(970, 9, 20, 0, 0, 0),
(971, 9, 21, 0, 0, 0),
(972, 9, 22, 0, 0, 0),
(973, 10, 11, 0, 0, 0),
(974, 10, 12, 0, 0, 0),
(975, 10, 13, 0, 0, 0),
(976, 10, 14, 0, 0, 0),
(977, 10, 15, 0, 0, 0),
(978, 10, 16, 0, 0, 0),
(979, 10, 17, 0, 0, 0),
(980, 10, 18, 0, 0, 0),
(981, 10, 19, 0, 0, 0),
(982, 10, 20, 0, 0, 0),
(983, 10, 21, 0, 0, 0),
(984, 10, 22, 0, 0, 0),
(985, 11, 12, 0, 0, 0),
(986, 11, 13, 0, 0, 0),
(987, 11, 14, 0, 0, 0),
(988, 11, 15, 0, 0, 0),
(989, 11, 16, 0, 0, 0),
(990, 11, 17, 0, 0, 0),
(991, 11, 18, 0, 0, 0),
(992, 11, 19, 0, 0, 0),
(993, 11, 20, 0, 0, 0),
(994, 11, 21, 0, 0, 0),
(995, 11, 22, 0, 0, 0),
(996, 12, 13, 0, 0, 0),
(997, 12, 14, 0, 0, 0),
(998, 12, 15, 0, 0, 0),
(999, 12, 16, 0, 0, 0),
(1000, 12, 17, 0, 0, 0),
(1001, 12, 18, 0, 0, 0),
(1002, 12, 19, 0, 0, 0),
(1003, 12, 20, 0, 0, 0),
(1004, 12, 21, 0, 0, 0),
(1005, 12, 22, 0, 0, 0),
(1006, 13, 14, 0, 0, 0),
(1007, 13, 15, 0, 0, 0),
(1008, 13, 16, 0, 0, 0),
(1009, 13, 17, 0, 0, 0),
(1010, 13, 18, 0, 0, 0),
(1011, 13, 19, 0, 0, 0),
(1012, 13, 20, 0, 0, 0),
(1013, 13, 21, 0, 0, 0),
(1014, 13, 22, 0, 0, 0),
(1015, 14, 15, 0, 0, 0),
(1016, 14, 16, 0, 0, 0),
(1017, 14, 17, 0, 0, 0),
(1018, 14, 18, 0, 0, 0),
(1019, 14, 19, 0, 0, 0),
(1020, 14, 20, 0, 0, 0),
(1021, 14, 21, 0, 0, 0),
(1022, 14, 22, 0, 0, 0),
(1023, 15, 16, 0, 0, 0),
(1024, 15, 17, 0, 0, 0),
(1025, 15, 18, 0, 0, 0),
(1026, 15, 19, 0, 0, 0),
(1027, 15, 20, 0, 0, 0),
(1028, 15, 21, 0, 0, 0),
(1029, 15, 22, 0, 0, 0),
(1030, 16, 17, 0, 0, 0),
(1031, 16, 18, 0, 0, 0),
(1032, 16, 19, 0, 0, 0),
(1033, 16, 20, 0, 0, 0),
(1034, 16, 21, 0, 0, 0),
(1035, 16, 22, 0, 0, 0),
(1036, 17, 18, 0, 0, 0),
(1037, 17, 19, 0, 0, 0),
(1038, 17, 20, 0, 0, 0),
(1039, 17, 21, 0, 0, 0),
(1040, 17, 22, 0, 0, 0),
(1041, 18, 19, 0, 0, 0),
(1042, 18, 20, 0, 0, 0),
(1043, 18, 21, 0, 0, 0),
(1044, 18, 22, 0, 0, 0),
(1045, 19, 20, 0, 0, 0),
(1046, 19, 21, 0, 0, 0),
(1047, 19, 22, 0, 0, 0),
(1048, 20, 21, 0, 0, 0),
(1049, 20, 22, 0, 0, 0),
(1050, 21, 22, 0, 0, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jugadores`
--
ALTER TABLE `jugadores`
  ADD CONSTRAINT `FK_jugadores_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`);

--
-- Constraints for table `partidos`
--
ALTER TABLE `partidos`
  ADD CONSTRAINT `FK_partidos_1` FOREIGN KEY (`equipo1`) REFERENCES `equipos` (`id_equipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_partidos_2` FOREIGN KEY (`equipo2`) REFERENCES `equipos` (`id_equipo`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
