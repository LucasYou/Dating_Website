-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dating
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `profile_id` char(20) NOT NULL,
  `owner_ssn` char(11) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `dating_age_range_start` int(11) DEFAULT NULL,
  `dating_age_range_end` int(11) DEFAULT NULL,
  `dating_geo_range` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `hobbies` varchar(1000) DEFAULT NULL,
  `heights` float DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `hair_color` varchar(20) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `last_mod_date` datetime NOT NULL,
  `geo_location` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `profile_ibfk_1` (`owner_ssn`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`owner_ssn`) REFERENCES `user` (`ssn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES ('Brenna_Berlin','888-88-8888',18,19,21,8,'Female','Dance, Acting',6,180,'Blonde','2014-10-04 20:20:55','2014-10-07 12:21:58','Theater'),('DesiraeBerg','999-99-9999',20,17,25,5,'Male','Water sports, Football',5.6,200,'Red','2014-10-04 19:13:18','2014-10-04 15:54:48',NULL),('Fletcher2013','666-66-6666',25,20,28,18,'Female','Reading, Basketball',5.6,150,'Brown','2014-10-04 19:21:37','2014-10-07 01:25:55',NULL),('Fletcher_Trujillo','666-66-6666',23,19,30,8,'Female','Shopping, Volleyball',5.6,150,'Brown','2014-10-04 18:26:49','2014-10-05 00:42:03',NULL),('Isabelle2013','555-55-5555',22,20,22,29,'Female','Shopping, Dance, Mountain Claiming',5.7,120,'Black','2014-10-04 00:37:12','2014-10-04 17:08:38',NULL),('Isabelle2014','555-55-5555',22,20,25,5,'Female','Shopping, Cooking',5.7,110,'Black','2014-10-04 22:43:25','2014-10-09 11:51:19',NULL),('VazquezFromAlajuela','777-77-7777',26,20,28,15,'Male','Hunting, Running',5.7,170,'Black','2014-10-04 17:13:30','2014-10-07 04:16:43',NULL);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-25 15:43:32
