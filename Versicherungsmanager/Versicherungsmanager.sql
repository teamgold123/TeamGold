CREATE DATABASE  IF NOT EXISTS `versicherungscheck` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `versicherungscheck`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: versicherungscheck
-- ------------------------------------------------------
-- Server version	5.6.20

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
-- Table structure for table `auto`
--

DROP TABLE IF EXISTS `auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto` (
  `kennzeichen` int(11) NOT NULL AUTO_INCREMENT,
  `modell_id` int(11) DEFAULT NULL,
  `halter_id` int(11) DEFAULT NULL,
  `situation` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `erstzul` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finanzierung` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kennz_art` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zul_halter` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vers_beg` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kennzeichen`),
  KEY `halter.id_idx` (`halter_id`),
  KEY `modell_idx` (`modell_id`),
  CONSTRAINT `halter_id` FOREIGN KEY (`halter_id`) REFERENCES `halter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `model_id` FOREIGN KEY (`modell_id`) REFERENCES `modell` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto`
--

LOCK TABLES `auto` WRITE;
/*!40000 ALTER TABLE `auto` DISABLE KEYS */;
INSERT INTO `auto` VALUES (1,13,44,'Zweitwagen','April 1997','über Kreditinstitut finanziert','Normales Kennzeichen','Mai 2012','Donnerstag, 14. Mai 2015'),(6,13,46,'Zweitwagen','September 2003','über Kreditinstitut finanziert','Saisonkennzeichen','Mai 2015','Freitag, 8. Mai 2015'),(9,22,48,'Zweitwagen','Januar 1900','geleast','Normales Kennzeichen','Januar 1900','Dienstag, 5. Mai 2015'),(14,26,48,'null','Januar 1900','geleast','Normales Kennzeichen','Januar 1900','Dienstag, 5. Mai 2015');
/*!40000 ALTER TABLE `auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `halter`
--

DROP TABLE IF EXISTS `halter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `halter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vorname` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plz` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `halter`
--

LOCK TABLES `halter` WRITE;
/*!40000 ALTER TABLE `halter` DISABLE KEYS */;
INSERT INTO `halter` VALUES (2,'test2','test','12345','123@web.de'),(3,'test2','test','12548','test@gmx.de'),(4,'test2','tobi','',NULL),(5,'Hallo','Hallo','51255',NULL),(6,'test2','asdf','',NULL),(8,'test2','','12345',NULL),(10,'test2','','',NULL),(11,'test2',NULL,NULL,NULL),(12,'test2',NULL,NULL,NULL),(13,'test2','','',NULL),(14,'test2',NULL,NULL,NULL),(15,'test2','','',NULL),(16,'test2',NULL,NULL,NULL),(18,'test2',NULL,NULL,NULL),(19,'test2',NULL,NULL,NULL),(20,'test2',NULL,NULL,NULL),(21,'test2',NULL,NULL,NULL),(22,'test2',NULL,NULL,NULL),(23,'test2',NULL,NULL,NULL),(26,'test2',NULL,NULL,NULL),(27,'test2',NULL,NULL,NULL),(28,'test2',NULL,NULL,NULL),(29,'test2',NULL,NULL,NULL),(30,'test2',NULL,NULL,NULL),(32,'test2',NULL,NULL,NULL),(33,'test2',NULL,NULL,NULL),(34,'test2',NULL,NULL,NULL),(35,'test2',NULL,NULL,NULL),(36,'test2',NULL,NULL,NULL),(37,'test2',NULL,NULL,NULL),(38,'Gügel','Thomas','91301',NULL),(39,'Schmitt','Marco','9035',NULL),(40,'Scholz','Annika','91301','annika.scholz@web.de'),(41,'mueller','hans','4612','hans.mueller@gmx.net'),(42,'Scholz','Annika','789654','scholz.annika@web.de'),(43,'Scholz','Annika','9251','scholz.annika2@web.de'),(44,'mueller','hans','95125','annika.scholz@gmx.net'),(45,'','','',''),(46,'Zettelmeier','Johannes','96166','johannes.zettelmeier@live.de'),(47,'dfghj','fghj','656521','sdfghjk.de'),(48,'ghj','ghj','5231','test@web.de');
/*!40000 ALTER TABLE `halter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modell`
--

DROP TABLE IF EXISTS `modell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modell` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hsn` varchar(4) NOT NULL,
  `tsn` varchar(3) NOT NULL,
  `model` varchar(45) DEFAULT NULL,
  `leistung` varchar(45) DEFAULT NULL,
  `hubraum` varchar(45) DEFAULT NULL,
  `kraftstoff` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modell`
--

LOCK TABLES `modell` WRITE;
/*!40000 ALTER TABLE `modell` DISABLE KEYS */;
INSERT INTO `modell` VALUES (8,'8253','ady','Kia RIO 1.1 CRDI','75 PS (55 kW)','1120 ccm','Diesel'),(9,'8253','adz','Kia RIO 1.4 CRDI','90 PS (66 kW)','1396 ccm','Diesel'),(10,'8253','adx','Kia RIO 1.2','86 PS (63 kW)','1248 ccm','Benzin'),(11,'7106','aao','Subaru IMPREZA 2.5 STI STH ALLRAD','280 PS (206 kW)','2457 ccm','Benzin'),(13,'0588','607','Audi A4 1.9 TDI','110 PS (81 kW)','1896 ccm','Diesel'),(15,'0005','alg','BMW 320 I','163 PS (120 kW)','1995 ccm','Benzin'),(16,'0583','aex','Porsche PANAMERA TURBO S 4.8 V8','551 PS (405 kW)','4806 ccm','Benzin'),(17,'0999','409','Mercedes-Benz S 500','387 PS (285 kW)','5462 ccm','Benzin'),(18,'0588','606','Audi A8 3.7','230 PS (169 kW)','3697 ccm','Benzin'),(19,'','','','','',''),(20,'0603','apl','VW GOLF VI 2.0 GTI','211 PS (155 kW)','1984 ccm','Benzin'),(21,'0603','alk','VW GOLF V VARIANT 2.0 GTI','200 PS (147 kW)','1984 ccm','Benzin'),(22,'0603','ami','VW GOLF V 2.0 GTI','230 PS (169 kW)','1984 ccm','Benzin'),(23,'0603','ben','VW GOLF VI GTI 2.0 TSI','235 PS (173 kW)','1984 ccm','Benzin'),(24,'0603','adf','VW GOLF V 2.0 GTI','200 PS (147 kW)','1984 ccm','Benzin'),(25,'0603','bkl','VW GOLF VII GTI 2.0 TSI','220 PS (162 kW)','1984 ccm','Benzin'),(26,'0603','bkm','VW GOLF VII GTI 2.0 TSI','230 PS (169 kW)','1984 ccm','Benzin'),(28,'0603','akx','VW GOLF V 2.0 GTI','230 PS (169 kW)','1984 ccm','Benzin');
/*!40000 ALTER TABLE `modell` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-05 10:28:54
