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
-- Temporary view structure for view `total_revenue`
--

DROP TABLE IF EXISTS `total_revenue`;
/*!50001 DROP VIEW IF EXISTS `total_revenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_revenue` AS SELECT 
 1 AS `firstname`,
 1 AS `lastname`,
 1 AS `customer_rep`,
 1 AS `revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `most_active`
--

DROP TABLE IF EXISTS `most_active`;
/*!50001 DROP VIEW IF EXISTS `most_active`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `most_active` AS SELECT 
 1 AS `profile`,
 1 AS `number_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `all_revenue`
--

DROP TABLE IF EXISTS `all_revenue`;
/*!50001 DROP VIEW IF EXISTS `all_revenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `all_revenue` AS SELECT 
 1 AS `customer`,
 1 AS `revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `total_revenue`
--

/*!50001 DROP VIEW IF EXISTS `total_revenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_revenue` AS select `p`.`firstname` AS `firstname`,`p`.`lastname` AS `lastname`,`d`.`cust_rep` AS `customer_rep`,sum(`d`.`booking_fee`) AS `revenue` from (`date` `d` join `person` `p`) where (`d`.`cust_rep` = `p`.`ssn`) group by `d`.`cust_rep` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `most_active`
--

/*!50001 DROP VIEW IF EXISTS `most_active`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `most_active` AS select `a`.`ID` AS `profile`,sum(`a`.`counts`) AS `number_date` from (select `d`.`profile_a` AS `ID`,count(`d`.`profile_a`) AS `counts` from `dating`.`date` `d` group by `ID` union select `d`.`profile_b` AS `ID`,count(`d`.`profile_b`) AS `counts` from `dating`.`date` `d` group by `ID`) `a` group by `a`.`ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_revenue`
--

/*!50001 DROP VIEW IF EXISTS `all_revenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_revenue` AS select `a`.`profile_a` AS `customer`,sum(`a`.`booking_fee`) AS `revenue` from (select `d`.`profile_a` AS `profile_a`,`d`.`booking_fee` AS `booking_fee` from `dating`.`date` `d` union select `d`.`profile_b` AS `profile_b`,`d`.`booking_fee` AS `booking_fee` from `dating`.`date` `d`) `a` group by `a`.`profile_a` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-25 15:43:33
