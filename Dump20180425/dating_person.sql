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
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `ssn` char(11) NOT NULL,
  `password` char(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zipcode` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telephone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('111-11-1111','111@11','Veronica','Alvarado','	45 Rockefeller Plaza','New York','New York',10111,'Fusce@velitPellentesque.net','(612) 506-2244'),('123-45-6789','test','test','test',NULL,NULL,NULL,NULL,NULL,NULL),('222-22-2222','222@22','Bo','Osborne','45 Rockefeller Plaza','New York','New York',10111,'mattis.Integer.eu@elit.org','(592) 765-8277'),('333-33-3333','	333@33','Hashim','Ross','	350 5th Ave','	New York','	New York',10118,'vulputate@Curae.co.uk','	(276) 634-6949'),('444-44-4444','	444@44','Shaine','Terrell','	350 5th Ave','	New York','	New York',10118,'	tincidunt.nibh@risus.com','(600) 803-9508'),('555-55-5555','555@55','Isabelle','Odonnell','Schomburg Apartments, 350 Circle Road','Stony Brook','	New York',11790,'magna.tellus.faucibus@amet.edu','	(934) 241-3862'),('666-66-6666','666@66','Fletcher','Trujillo','700 Health Sciences Dr','Stony Brook','	New York',11790,'elementum.dui.quis@utlacus.net','(990) 760-1480'),('777-77-7777','777@77','Malachi','Vazquez','700 Health Sciences Dr','Stony Brook','	New York',11790,'tellus.lorem.eu@atlacus.org','(226) 193-8257'),('888-88-8888','888@88','Brenna','Cross','Schomburg Apartments, 350 Circle Road','Stony Brook','	New York',11790,'sed.turpis@vehiculaaliquet.com','(968) 409-7641'),('987-65-4321','test','temp','temp',NULL,NULL,NULL,NULL,NULL,NULL),('999-99-9999','999@99','Desirae','Berg','116th St & Broadway','	New York','	New York',10027,'vitae@magnased.com','(237) 321-3189');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
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
