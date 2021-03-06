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
-- Table structure for table `suggestedby`
--

DROP TABLE IF EXISTS `suggestedby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggestedby` (
  `cust_rep` char(11) NOT NULL,
  `profile_a` char(20) NOT NULL,
  `profile_b` char(20) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`cust_rep`,`profile_a`,`profile_b`,`date_time`),
  KEY `suggestedby_ibfk_1` (`profile_a`),
  KEY `suggestedby_ibfk_2` (`profile_b`),
  CONSTRAINT `suggestedby_ibfk_1` FOREIGN KEY (`profile_a`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE,
  CONSTRAINT `suggestedby_ibfk_2` FOREIGN KEY (`profile_b`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE,
  CONSTRAINT `suggestedby_ibfk_3` FOREIGN KEY (`cust_rep`) REFERENCES `employee` (`ssn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestedby`
--

LOCK TABLES `suggestedby` WRITE;
/*!40000 ALTER TABLE `suggestedby` DISABLE KEYS */;
INSERT INTO `suggestedby` VALUES ('222-22-2222','Fletcher2013','DesiraeBerg','2014-10-05 15:07:44');
/*!40000 ALTER TABLE `suggestedby` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-25 15:43:33
