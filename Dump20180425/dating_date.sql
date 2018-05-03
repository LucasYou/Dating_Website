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
-- Table structure for table `date`
--

DROP TABLE IF EXISTS `date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date` (
  `profile_a` char(20) NOT NULL,
  `profile_b` char(20) NOT NULL,
  `cust_rep` char(11) DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `booking_fee` float DEFAULT NULL,
  `comments` text,
  `user1_rating` int(11) DEFAULT NULL,
  `user2_rating` int(11) DEFAULT NULL,
  `geo_location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`profile_a`,`profile_b`,`date_time`),
  KEY `date_ibfk_2` (`profile_b`),
  KEY `date_ibfk_3` (`cust_rep`),
  CONSTRAINT `date_ibfk_1` FOREIGN KEY (`profile_a`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE,
  CONSTRAINT `date_ibfk_2` FOREIGN KEY (`profile_b`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE,
  CONSTRAINT `date_ibfk_3` FOREIGN KEY (`cust_rep`) REFERENCES `employee` (`ssn`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date`
--

LOCK TABLES `date` WRITE;
/*!40000 ALTER TABLE `date` DISABLE KEYS */;
INSERT INTO `date` VALUES ('Brenna_Berlin','DesiraeBerg','333-33-3333','2014-10-06 12:21:06','The Mall',36.46,'Comments Here',2,3,NULL),('Fletcher2013','VazquezFromAlajuela','333-33-3333','2014-10-06 04:30:52','Ruvos Restaurant',42.75,'Comments Here',3,1,NULL),('Isabelle2013','DesiraeBerg','222-22-2222','2014-10-04 21:39:42','Port Jeff Cinema',65.25,'Comments Here	',4,5,NULL),('Isabelle2014','VazquezFromAlajuela','222-22-2222','2014-10-06 21:49:30','The Mall',90.91,'Comments Here',3,3,NULL),('VazquezFromAlajuela','Brenna_Berlin','444-44-4444','2014-10-06 05:34:04','Turkish Restaurant',69.26,'Comments Here',4,4,NULL);
/*!40000 ALTER TABLE `date` ENABLE KEYS */;
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
