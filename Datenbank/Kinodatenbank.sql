CREATE DATABASE  IF NOT EXISTS `kino_db` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `kino_db`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kino_db
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
-- Table structure for table `filme`
--

DROP TABLE IF EXISTS `filme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filme` (
  `Filme_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Spiellaenge` int(11) NOT NULL,
  `Genre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Inhalt` varchar(2500) COLLATE utf8_unicode_ci NOT NULL,
  `Bild` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Filme_ID`,`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filme`
--

LOCK TABLES `filme` WRITE;
/*!40000 ALTER TABLE `filme` DISABLE KEYS */;
INSERT INTO `filme` VALUES (1,'Interstellar',169,'Adventure, Sci-Fi','In the near future, Earth has been devastated by drought and famine, causing a scarcity in food and extreme changes in climate. When humanity is facing extinction, a mysterious rip in the space-time continuum is discovered, giving mankind the opportunity to widen its lifespan. A group of explorers must travel beyond our solar system in search of a planet that can sustain life. The crew of the Endurance are required to think bigger and go further than any human in history as they embark on an interstellar voyage into the unknown. Coop, the pilot of the Endurance, must decide between seeing his children again and the future of the human race.','http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX214_AL_.jpg'),(2,'Rambo',93,'Action, Thriller','John J. Rambo is a former United States Special Forces soldier who fought in Vietnam and won the Congressional Medal of Honor, but his time in Vietnam still haunts him. As he came to Hope, Washington to visit a friend, he was guided out of town by the Sheriff William Teasel who insults Rambo, but what Teasel does not know that his insult angered Rambo to the point where Rambo became violent and was arrested, as he was at the county jail being cleaned, he escapes and goes on a rampage through the forest to try to escape from the sheriffs who want to kill him. Then, as Rambo\'s commanding officer, Colonel Samuel Trautman tries to save both the Sheriff\'s department and Rambo before the situation gets out of hand.','http://ia.media-imdb.com/images/M/MV5BNzk5NDc4MDQyNV5BMl5BanBnXkFtZTgwNzg5NTYxMTE@._V1_SY317_CR0,0,214,317_AL_.jpg'),(3,'Iron Man',126,'Action, Adventure, Sci-Fi','Tony Stark. Genius, billionaire, playboy, philanthropist. Son of legendary inventor and weapons contractor Howard Stark. When Tony Stark is assigned to give a weapons presentation to an Iraqi unit led by Lt. Col. James Rhodes, he\'s given a ride on enemy lines. That ride ends badly when Stark\'s Humvee that he\'s riding in is attacked by enemy combatants. He survives - barely - with a chest full of shrapnel and a car battery attached to his heart. In order to survive he comes up with a way to miniaturize the battery and figures out that the battery can power something else. Thus Iron Man is born. He uses the primitive device to escape from the cave in Iraq. Once back home, he then begins work on perfecting the Iron Man suit. But the man who was put in charge of Stark Industries has plans of his own to take over Tony\'s technology for other matters.','http://ia.media-imdb.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX214_AL_.jpg'),(4,'Armageddon - Das jungste Gericht',151,'Action, Adventure, Sci-Fi, Thriller','It is just another day at the National Aeronautics and Space Administration (NASA), a few astronauts were repairing a satellite until, out of nowhere, a series of asteroids came crashing into the shuttle, destroying it. These asteroids also decimated New York soon thereafter. Then, NASA discovered that there is an asteroid roughly the size of Texas heading towards the Earth, and when it does hit the Earth, the planet itself and all of its inhabitants will be obliterated, worse, the asteroid will hit the Earth in 18 days. Unfortunately, NASA\'s plans to destroy the asteroid are irrelevant. That is when the U.S. military decides to use a nuclear warhead to blow the asteroid to pieces. Then, scientists decide to blow the asteroid with the warhead inside the asteroid itself. The only man to do it, is an oil driller named Harry Stamper and his group of misfit drillers and geologists. As he and his drill team prepare for space excavation, the asteroid is still heading towards the Earth. When...','http://ia.media-imdb.com/images/M/MV5BMTc3NzA4MDIyNV5BMl5BanBnXkFtZTcwMzc1OTM2MQ@@._V1_SX214_AL_.jpg'),(5,'Harry Potter und der Stein der Weisen',152,'Adventure, Family, Fantasy','Harry Potter and the Sorcerer\'s Stone is the first film in the Harry Potter series based on the novels by J.K. Rowling. It is the tale of Harry Potter, an ordinary 11-year-old boy serving as a sort of slave for his aunt and uncle who learns that he is actually a wizard and has been invited to attend the Hogwarts School for Witchcraft and Wizardry. Harry is snatched away from his mundane existence by Hagrid, the grounds keeper for Hogwarts, and quickly thrown into a world completely foreign to both him and the viewer. Famous for an incident that happened at his birth, Harry makes friends easily at his new school. He soon finds, however, that the wizarding world is far more dangerous for him than he would have imagined, and he quickly learns that not all wizards are ones to be trusted.','http://ia.media-imdb.com/images/M/MV5BMTYwNTM5NDkzNV5BMl5BanBnXkFtZTYwODQ4MzY5._V1_SY317_CR8,0,214,317_AL_.jpg'),(6,'Spider-Man',121,'Action, Adventure','Based on Marvel Comics\' superhero character, this is a story of Peter Parker who is a nerdy high-schooler. He was orphaned as a child, bullied by jocks, and can\'t confess his crush for his stunning neighborhood girl Mary Jane Watson. To say his life is \"miserable\" is an understatement. But one day while on an excursion to a laboratory a runaway radioactive spider bites him... and his life changes in a way no one could have imagined. Peter acquires a muscle-bound physique, clear vision, ability to cling to surfaces and crawl over walls, shooting webs from his wrist ... but the fun isn\'t going to last. An eccentric millionaire Norman Osborn administers a performance enhancing drug on himself and his maniacal alter ego Green Goblin emerges. Now Peter Parker has to become Spider-Man and take Green Goblin to the task... or else Goblin will kill him. They come face to face and the war begins in which only one of them will survive at the end.','http://ia.media-imdb.com/images/M/MV5BMzk3MTE5MDU5NV5BMl5BanBnXkFtZTYwMjY3NTY3._V1_SY317_CR0,0,214,317_AL_.jpg'),(7,'Dei Mudder sei Gesicht',91,'Comedy, Crime','Kermet, Ogrem and Lorenzo meet in prison after commiting different crimes. They escape and steal a car to meet Albaner. Lorenzo leaves them to get a haircut. While he is away the others get into trouble... Plot Summary | Add Synopsis','http://ia.media-imdb.com/images/M/MV5BMTAwOTc2NDk1NDNeQTJeQWpwZ15BbWU4MDk1NTUwMzEx._V1_SY317_CR5,0,214,317_AL_.jpg'),(8,'Stirb langsam 4.0',128,'Action, Adventure, Thriller','When someone hacks into the computers at the FBI\'s Cyber Crime Division; the Director decides to round up all the hackers who could have done this. When he\'s told that because it\'s the 4th of July most of their agents are not around so they might have trouble getting people to get the hackers. So he instructs them to get local PD\'S to take care of it. And one of the cops they ask is John McClane who is tasked with bringing a hacker named Farrell to the FBI. But as soon as he gets there someone starts shooting at them. McClane manages to get them out but they\'re still being pursued. And it\'s just when McClane arrives in Washington that the whole system breaks down and chaos ensues.','http://ia.media-imdb.com/images/M/MV5BNDQxMDE1OTg4NV5BMl5BanBnXkFtZTcwMTMzOTQzMw@@._V1_SY317_CR0,0,214,317_AL_.jpg'),(9,'Who Am I - Kein System ist sicher',102,'Thriller','Benjamin, a young German computer whiz, is invited to join a subversive hacker group that wants to be noticed on the world\'s stage. Plot Summary | Add Synopsis','http://ia.media-imdb.com/images/M/MV5BNDg4NjU3MTYzNl5BMl5BanBnXkFtZTgwNzE2MDU2MjE@._V1_SY317_CR5,0,214,317_AL_.jpg'),(10,'Brokeback Mountain',134,'Drama, Romance','A raw, powerful story of two young men, a Wyoming ranch hand and a rodeo cowboy, who meet in the summer of 1963 sheepherding in the harsh, high grasslands of contemporary Wyoming and form an unorthodox yet life-long bond--by turns ecstatic, bitter and conflicted.','http://ia.media-imdb.com/images/M/MV5BMTY5NTAzNTc1NF5BMl5BanBnXkFtZTYwNDY4MDc3._V1_SX214_AL_.jpg'),(11,'Marvel\'s The Avengers 2: Age of Ultron',141,'Action, Adventure, Sci-Fi, Thriller','When Tony Stark tries to jumpstart a dormant peacekeeping program, things go awry and Earth\'s Mightiest Heroes, including Iron Man, Captain America, Thor, The Incredible Hulk, Black Widow and Hawkeye, are put to the ultimate test as the fate of the planet hangs in the balance. As the villainous Ultron emerges, it is up to The Avengers to stop him from enacting his terrible plans, and soon uneasy alliances and unexpected action pave the way for a global adventure.','http://ia.media-imdb.com/images/M/MV5BMTU4MDU3NDQ5Ml5BMl5BanBnXkFtZTgwOTU5MDUxNTE@._V1_SY317_CR1,0,214,317_AL_.jpg'),(12,'Der SpongeBob Schwammkopf Film',87,'Animation, Adventure, Comedy, Family','There\'s trouble brewing in Bikini Bottom. Someone has stolen King Neptune\'s crown, and it looks like Mr. Krabs, SpongeBob\'s boss, is the culprit. Though he has just been passed over for the promotion of his dreams, SpongeBob stands by his boss, and along with his best pal Patrick, sets out on a treacherous mission to Shell City to reclaim the crown and save Mr. Krabs\' life.','http://ia.media-imdb.com/images/M/MV5BMTU4OTg2NzA0Nl5BMl5BanBnXkFtZTcwODEwMDgyMQ@@._V1_SX214_AL_.jpg'),(13,'The Lego Movie',100,'Animation, Adventure, Comedy, Family, Fantasy','The LEGO Movie is a 3D animated film which follows lead character, Emmet a completely ordinary LEGO mini-figure who is identified as the most \"extraordinary person\" and the key to saving the Lego universe. Emmet and his friends go on an epic journey to stop the evil tyrant, Lord Business.','http://ia.media-imdb.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX214_AL_.jpg'),(14,'Titanic',194,'Drama, Romance','84 years later, a 101-year-old woman named Rose DeWitt Bukater tells the story to her granddaughter Lizzy Calvert, Brock Lovett, Lewis Bodine, Bobby Buell and Anatoly Mikailavich on the Keldysh about her life set in April 10th 1912, on a ship called Titanic when young Rose boards the departing ship with the upper-class passengers and her mother, Ruth DeWitt Bukater, and her fiance, Caledon Hockley. Meanwhile, a drifter and artist named Jack Dawson and his best friend Fabrizio De Rossi win third-class tickets to the ship in a game. And she explains the whole story from departure until the death of Titanic on its first and last voyage April 15th, 1912 at 2:20 in the morning.','http://ia.media-imdb.com/images/M/MV5BMjExNzM0NDM0N15BMl5BanBnXkFtZTcwMzkxOTUwNw@@._V1_SY317_CR0,0,214,317_AL_.jpg'),(15,'Inception',148,'Action, Mystery, Sci-Fi, Thriller','Dom Cobb is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable. Cobb\'s rare ability has made him a coveted player in this treacherous new world of corporate espionage, but it has also made him an international fugitive and cost him everything he has ever loved. Now Cobb is being offered a chance at redemption. One last job could give him his life back but only if he can accomplish the impossible-inception. Instead of the perfect heist, Cobb and his team of specialists have to pull off the reverse: their task is not to steal an idea but to plant one. If they succeed, it could be the perfect crime. But no amount of careful planning or expertise can prepare the team for the dangerous enemy that seems to predict their every move. An enemy that only Cobb could have seen coming.','http://ia.media-imdb.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX214_AL_.jpg'),(16,'Brugge sehen... und sterben?',107,'Comedy, Crime, Drama','London based hit men Ray and Ken are told by their boss Harry Waters to lie low in Bruges, Belgium for up to two weeks following their latest hit, which resulted in the death of an innocent bystander. Harry will be in touch with further instructions. While they wait for Harry\'s call, Ken, following Harry\'s advice, takes in the sights of the medieval city with great appreciation. But the charms of Bruges are lost on the simpler Ray, who is already despondent over the innocent death, especially as it was his first job. Things change for Ray when he meets Chloe, part of a film crew shooting a movie starring an American dwarf named Jimmy. When Harry\'s instructions arrive, Ken, for whom the job is directed, isn\'t sure if he can carry out the new job, especially as he has gained a new appreciation of life from his stay in the fairytale Bruges. While Ken waits for the inevitable arrival into Bruges of an angry Harry, who feels he must clean up matters on his own, Ray is dealing with his own ...','http://ia.media-imdb.com/images/M/MV5BMTY4OTYxODg4MV5BMl5BanBnXkFtZTcwMDcyNzM2MQ@@._V1_SY317_CR0,0,214,317_AL_.jpg');
/*!40000 ALTER TABLE `filme` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger Filme_before_insert_log before insert on filme
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " neue Filme wird eingetragen: ", NEW.Filme_ID, " ",NEW.Name, " ",NEW.Spiellaenge, " ",NEW.Genre));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger Filme_before_delete_log before delete on filme
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " Filme wird gelöscht: ", OLD.Filme_ID, " ",OLD.Name, " ",OLD.Spiellaenge, " ",OLD.Genre));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kunde`
--

DROP TABLE IF EXISTS `kunde`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kunde` (
  `Kunde_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Strasse` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Ort` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Tele_Nr` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Kunde_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunde`
--

LOCK TABLES `kunde` WRITE;
/*!40000 ALTER TABLE `kunde` DISABLE KEYS */;
INSERT INTO `kunde` VALUES (1,'Spangher','Simon','Narzissenweg 1','91056 Erlangen','simonspangher@web.de','091319749903'),(2,'Ulrich','Johannes','Kellerstraße 4','96250 Ebelsfeld','johannes.ullrich@alo.com','0918234873211'),(3,'Drummer','Florian','Mühlenweg 8','91052 Erlangen','flori@web.de','0151-2551848'),(4,'Sorglos','Susi','Hutweg 3','91054 Erlangen','susi.sorglos@gmx.de','09131-12345'),(5,'Hirsch','Harry','Baumgartenstr. 2','75175 Pforzheim','Hirsch.H@mail.com','0151-12345'),(6,'Nicks','Steffi','Holzweg 8','73124 Oberdorf','Steffi.Nicks@web.de','0170 1518616'),(7,'Unterlaender','Elke','Max-Weber-Str. 12','81023 Muenchen','Elke.Unter@gmai.com','0171 15428453'),(8,'Peters','Paul','Am Markt 1','53522 Koeln','PowerPaul@gmx.de','0151-1584283518'),(9,'Wallung','Walther','Panoramapfad 33','09663 Gruenstadt','WalterWallung@gmail.com','0151/18181561686'),(10,'White','Walther','Kellerweg 1','91052 Erlangen','Heisenberg@gmail.com','0151-158416186'),(11,'Pfeffer','Claudia','Mozartweg 6','74121 Ludwigshafen','Pfeffer.Claudi@mail.com','0160-1518 15818'),(12,'Müller','Hans','Hauptstr. 15','91054 Erlangen','Hans.m@gmail.com','0151-2531752'),(13,'Lustig','Helma','Im Winkel 16a','12329 Talhausen','LustigeHelma@gmail.com','09131-11888'),(14,'Hofmann','Michael','Am Baechle 3','66822 Heidelberg','Michi.Hofmann@gmail.com','0151 184861681'),(15,'Eberth','Isabell','Kellerstr. 6','96251 Bad Staffelstein','isi.eberth@web.de','015150515151'),(17,'Seidel','Kurt','Weg 28','91052 Erlangen','kurt.seide@technikerschule-erlangen.de','09131-1-815');
/*!40000 ALTER TABLE `kunde` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Aktion` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2015-04-30 11:47:03 Film wurde gelöscht: 15 Underworld 121 Action, Fantasy, Thriller'),(2,'2015-04-30 11:48:38 neue Vorstellung wurde eingetragen: 1 12:25 15:00 30.04.2015 1 1'),(3,'2015-04-30 11:50:56 neue Reservierung wurde eingetragen: 1 6 4 1 4 11:50:00'),(4,'2015-04-30 11:55:05 Reservierung wurde gelöscht: 1 6 4 1 4 11:50:00'),(5,'2015-05-02 18:42:17 Vorstellung wird gelöscht: 1 12:25 15:00 30.04.2015 1 1'),(6,'2015-05-02 18:44:41 neue Vorstellung wird eingetragen: 0 18:00 21:30 07.05.2015 1 1'),(7,'2015-05-02 18:44:58 neue Vorstellung wird eingetragen: 0 20:00 23:00 07.05.2015 5 2'),(8,'2015-05-02 18:45:13 neue Vorstellung wird eingetragen: 0 19:00 23:00 08.05.2015 14 1'),(9,'2015-05-02 18:45:31 neue Vorstellung wird eingetragen: 0 15:00 18:00 08.05.2015 10 1'),(10,'2015-05-02 18:45:53 neue Vorstellung wird eingetragen: 0 10:00 12:00 09.08.2015 12 1'),(11,'2015-05-02 18:46:09 neue Vorstellung wird eingetragen: 0 17:00 19:00 09.05.2015 9 1'),(12,'2015-05-02 18:46:34 neue Vorstellung wird eingetragen: 0 12:30 14:30 10.05.2015 13 1'),(13,'2015-05-02 18:47:04 neue Vorstellung wird eingetragen: 0 21:00 24:00 10.05.2015 8 2'),(14,'2015-05-02 18:47:15 neue Vorstellung wird eingetragen: 0 18:00 20:00 11.05.2015 2 1'),(15,'2015-05-02 18:47:32 neue Vorstellung wird eingetragen: 0 11:30 14:30 11.05.2015 5 1'),(16,'2015-05-02 18:47:47 neue Vorstellung wird eingetragen: 0 15:00 18:00 12.05.2015 11 1'),(17,'2015-05-02 18:48:03 neue Vorstellung wird eingetragen: 0 14:00 18:00 12.05.2015 14 2'),(18,'2015-05-02 18:48:36 neue Vorstellung wird eingetragen: 0 09:30 11:30 13.05.2015 9 2'),(19,'2015-05-02 18:49:00 neue Vorstellung wird eingetragen: 0 21:00 24:00 13.05.2015 3 1'),(20,'2015-05-02 18:49:19 neue Vorstellung wird eingetragen: 0 20:00 23:00 14.05.2015 4 1'),(21,'2015-05-02 18:50:04 neue Vorstellung wird eingetragen: 0 14:00 16:00 14.05.2015 7 2'),(22,'2015-05-02 18:51:17 neue Filme wird eingetragen: 0 Inception 148 Action, Mystery, Sci-Fi, Thriller'),(23,'2015-05-03 00:14:41 neue Vorstellung wird eingetragen: 0 14:00 16:00 03.05.2015 7 2'),(24,'2015-05-03 00:21:43 neue Reservierung wird eingetragen: 1 8 4 17 4 now()'),(25,'2015-05-03 00:22:24 Reservierung wird gelöscht: 1 8 4 17 4 now()'),(26,'2015-05-03 00:24:56 neue Reservierung wird eingetragen: 1 3 4 17 4 '),(27,'2015-05-03 00:25:57 Reservierung wird gelöscht: 1 3 4 17 4 '),(28,'2015-05-03 00:26:11 Vorstellung wird gelöscht: 17 00:30 02:00 03.05.2015 7 2'),(29,'2015-05-03 01:08:06 neue Vorstellung wird eingetragen: 0 15:00 17:00 07.05.2015 2 1'),(30,'2015-05-03 01:08:48 neue Vorstellung wird eingetragen: 0 10:00 13:00 07.05.2015 3 1'),(31,'2015-05-03 01:13:05 neue Vorstellung wird eingetragen: 0 09:00 11:00 07.05.2015 2 2'),(32,'2015-05-03 01:13:48 neue Vorstellung wird eingetragen: 0 12:30 15:30 07.05.2015 5 2'),(33,'2015-05-03 01:15:11 neue Vorstellung wird eingetragen: 0 09:30 12:30 08.05.2015 6 2'),(34,'2015-05-03 01:16:31 neue Vorstellung wird eingetragen: 0 12:00 15:00 08.05.2015 4 1'),(35,'2015-05-03 01:17:08 neue Vorstellung wird eingetragen: 0 15:00 18:00 08.05.2015 3 2'),(36,'2015-05-03 01:17:30 neue Vorstellung wird eingetragen: 0 20:00 23:00 08.05.2015 6 2'),(37,'2015-05-03 01:26:53 neue Vorstellung wird eingetragen: 0 20:00 23:00 09.05.2015 6 1'),(38,'2015-05-03 01:27:15 neue Vorstellung wird eingetragen: 0 10:00 13:00 09.05.2015 5 2'),(39,'2015-05-03 01:45:26 neue Vorstellung wird eingetragen: 0 10:00 13:00 09.05.2015 4 2'),(40,'2015-05-03 01:49:21 neue Vorstellung wird eingetragen: 0 18:00 20:00 09.05.2015 2 2'),(41,'2015-05-03 01:51:54 neue Vorstellung wird eingetragen: 0 15:00 17:00 10.05.2015 2 1'),(42,'2015-05-03 01:52:20 neue Vorstellung wird eingetragen: 0 18:00 21:30 10.05.2015 1 1'),(43,'2015-05-03 01:52:55 neue Vorstellung wird eingetragen: 0 17:00 19:00 10.05.2015 2 2'),(44,'2015-05-03 01:53:18 neue Vorstellung wird eingetragen: 0 10:00 13:00 10.05.2015 3 2'),(45,'2015-05-03 01:54:05 neue Vorstellung wird eingetragen: 0 12:00 15:00 11.05.2015 11 1'),(46,'2015-05-03 02:12:31 neue Vorstellung wird eingetragen: 0 20:00 23:00 11.05.2015 15 2'),(47,'2015-05-03 02:12:50 neue Vorstellung wird eingetragen: 0 10:00 14:00 11.05.2015 14 2'),(48,'2015-05-03 02:13:04 neue Vorstellung wird eingetragen: 0 15:00 17:00 11.05.2015 13 2'),(49,'2015-05-03 02:15:10 neue Vorstellung wird eingetragen: 0 19:00 22:00 12.05.2015 10 1'),(50,'2015-05-03 02:15:52 neue Vorstellung wird eingetragen: 0 10:00 12:00 12.05.2015 9 1'),(51,'2015-05-03 02:16:26 neue Vorstellung wird eingetragen: 0 19:00 22:00 12.05.2015 8 2'),(52,'2015-05-03 02:17:35 neue Vorstellung wird eingetragen: 0 09:00 11:00 12.05.2015 7 2'),(53,'2015-05-03 02:19:11 neue Vorstellung wird eingetragen: 0 12:00 14:00 13.05.2015 12 1'),(54,'2015-05-03 02:19:48 neue Vorstellung wird eingetragen: 0 15:00 18:00 13.05.2015 11 1'),(55,'2015-05-03 02:21:05 neue Vorstellung wird eingetragen: 0 12:00 15:00 13.05.2015 8 2'),(56,'2015-05-03 02:21:19 neue Vorstellung wird eingetragen: 0 20:00 23:00 13.05.2015 11 2'),(57,'2015-05-03 02:21:50 neue Vorstellung wird eingetragen: 0 10:00 13:00 14.05.2015 8 1'),(58,'2015-05-03 02:22:14 neue Vorstellung wird eingetragen: 0 17:00 19:00 14.05.2015 7 1'),(59,'2015-05-03 02:23:19 neue Vorstellung wird eingetragen: 0 10:00 13:00 14.05.2015 8 2'),(60,'2015-05-03 02:23:48 neue Vorstellung wird eingetragen: 0 17:00 19:00 14.05.2015 13 2'),(61,'2015-05-03 09:37:28 neue Reservierung wird eingetragen: 1 8 5 42 7 2015-05-03 09:37:28'),(62,'2015-05-03 09:37:28 neue Reservierung wird eingetragen: 1 8 6 42 7 2015-05-03 09:37:28'),(63,'2015-05-03 09:37:28 neue Reservierung wird eingetragen: 1 8 7 42 7 2015-05-03 09:37:28'),(64,'2015-05-03 09:37:29 neue Reservierung wird eingetragen: 1 8 8 42 7 2015-05-03 09:37:29'),(65,'2015-05-03 09:41:48 Reservierung wird gelöscht: 1 8 5 42 7 2015-05-03 09:37:28'),(66,'2015-05-03 09:41:48 Reservierung wird gelöscht: 1 8 6 42 7 2015-05-03 09:37:28'),(67,'2015-05-03 09:41:48 Reservierung wird gelöscht: 1 8 7 42 7 2015-05-03 09:37:28'),(68,'2015-05-03 09:41:48 Reservierung wird gelöscht: 1 8 8 42 7 2015-05-03 09:37:29'),(69,'2015-05-03 09:43:41 neue Reservierung wird eingetragen: 1 6 4 8 8 2015-05-03 09:43:41'),(70,'2015-05-03 09:43:42 neue Reservierung wird eingetragen: 1 6 5 8 8 2015-05-03 09:43:42'),(71,'2015-05-03 09:43:42 neue Reservierung wird eingetragen: 1 6 6 8 8 2015-05-03 09:43:42'),(72,'2015-05-03 09:43:42 neue Reservierung wird eingetragen: 1 6 7 8 8 2015-05-03 09:43:42'),(73,'2015-05-03 09:44:08 Reservierung wird gelöscht: 1 6 4 8 8 2015-05-03 09:43:41'),(74,'2015-05-03 09:44:12 Reservierung wird gelöscht: 1 6 5 8 8 2015-05-03 09:43:42'),(75,'2015-05-03 09:44:15 Reservierung wird gelöscht: 1 6 6 8 8 2015-05-03 09:43:42'),(76,'2015-05-03 09:44:17 Reservierung wird gelöscht: 1 6 7 8 8 2015-05-03 09:43:42'),(77,'2015-05-03 10:06:31 neue Reservierung wird eingetragen: 1 6 6 1 12 2015-05-03 10:06:31'),(78,'2015-05-03 10:06:31 neue Reservierung wird eingetragen: 1 6 7 1 12 2015-05-03 10:06:31'),(79,'2015-05-03 10:06:31 neue Reservierung wird eingetragen: 1 6 8 1 12 2015-05-03 10:06:31'),(80,'2015-05-03 10:08:52 Vorstellung wird gelöscht: 38 19:00 22:00 12.05.2015 10 1'),(81,'2015-05-03 10:08:52 Vorstellung wird gelöscht: 42 12:00 14:00 13.05.2015 12 1'),(82,'2015-05-03 10:08:52 Vorstellung wird gelöscht: 35 20:00 23:00 11.05.2015 15 2'),(83,'2015-05-03 10:11:49 neue Reservierung wird eingetragen: 2 6 1 45 15 2015-05-03 10:11:49'),(84,'2015-05-03 10:11:50 neue Reservierung wird eingetragen: 2 6 2 45 15 2015-05-03 10:11:50'),(85,'2015-05-03 10:11:50 neue Reservierung wird eingetragen: 2 6 3 45 15 2015-05-03 10:11:50'),(86,'2015-05-03 10:11:50 neue Reservierung wird eingetragen: 2 6 4 45 15 2015-05-03 10:11:50'),(87,'2015-05-03 10:11:50 neue Reservierung wird eingetragen: 2 6 5 45 15 2015-05-03 10:11:50'),(88,'2015-05-03 10:11:50 neue Reservierung wird eingetragen: 2 6 6 45 15 2015-05-03 10:11:50'),(89,'2015-05-03 10:15:38 Reservierung wird gelöscht: 2 6 1 45 15 2015-05-03 10:11:49'),(90,'2015-05-03 10:15:52 Reservierung wird gelöscht: 2 6 2 45 15 2015-05-03 10:11:50'),(91,'2015-05-03 10:20:05 neue Reservierung wird eingetragen: 3 1 1 12 3 2015-05-03 10:20:05'),(92,'2015-05-03 10:20:05 neue Reservierung wird eingetragen: 3 1 2 12 3 2015-05-03 10:20:05'),(93,'2015-05-03 10:20:05 neue Reservierung wird eingetragen: 3 1 3 12 3 2015-05-03 10:20:05'),(94,'2015-05-03 10:20:05 neue Reservierung wird eingetragen: 3 1 4 12 3 2015-05-03 10:20:05'),(95,'2015-05-03 10:20:05 neue Reservierung wird eingetragen: 3 1 5 12 3 2015-05-03 10:20:05'),(96,'2015-05-03 10:21:04 neue Reservierung wird eingetragen: 4 8 4 34 2 2015-05-03 10:21:04'),(97,'2015-05-03 10:21:04 neue Reservierung wird eingetragen: 4 8 5 34 2 2015-05-03 10:21:04'),(98,'2015-05-03 10:21:04 neue Reservierung wird eingetragen: 4 8 6 34 2 2015-05-03 10:21:04'),(99,'2015-05-03 10:21:04 neue Reservierung wird eingetragen: 4 8 7 34 2 2015-05-03 10:21:04'),(100,'2015-05-03 10:54:27 neue Filme wird eingetragen: 0 Brugge sehen... und sterben? 107 Comedy, Crime, Drama'),(101,'2015-05-03 10:56:21 neue Vorstellung wird eingetragen: 0 20:00 22:00 03.05.2015 16 1'),(102,'2015-05-03 10:59:29 neue Vorstellung wird eingetragen: 0 20:00 22:00 03.05.2015 16 2'),(103,'2015-05-03 12:21:30 neue Reservierung wird eingetragen: 5 3 1 50 15 2015-05-03 12:21:30'),(104,'2015-05-03 12:21:30 neue Reservierung wird eingetragen: 5 3 2 50 15 2015-05-03 12:21:30'),(105,'2015-05-03 12:21:30 neue Reservierung wird eingetragen: 5 3 3 50 15 2015-05-03 12:21:30'),(106,'2015-05-03 12:21:30 neue Reservierung wird eingetragen: 5 3 4 50 15 2015-05-03 12:21:30'),(107,'2015-05-03 12:57:56 neue Reservierung wird eingetragen: 6 6 2 2 17 2015-05-03 12:57:56'),(108,'2015-05-03 12:57:56 neue Reservierung wird eingetragen: 6 6 3 2 17 2015-05-03 12:57:56'),(109,'2015-05-03 12:57:56 neue Reservierung wird eingetragen: 6 6 4 2 17 2015-05-03 12:57:56'),(110,'2015-05-03 12:57:57 neue Reservierung wird eingetragen: 6 6 5 2 17 2015-05-03 12:57:57'),(111,'2015-05-03 12:57:57 neue Reservierung wird eingetragen: 6 6 6 2 17 2015-05-03 12:57:57'),(112,'2015-05-03 12:58:48 neue Reservierung wird eingetragen: 7 4 5 51 2 2015-05-03 12:58:48'),(113,'2015-05-03 12:58:48 neue Reservierung wird eingetragen: 7 4 6 51 2 2015-05-03 12:58:48'),(114,'2015-05-03 12:58:48 neue Reservierung wird eingetragen: 7 4 7 51 2 2015-05-03 12:58:48'),(115,'2015-05-03 12:58:48 neue Reservierung wird eingetragen: 7 4 8 51 2 2015-05-03 12:58:48'),(116,'2015-05-03 12:59:03 neue Reservierung wird eingetragen: 8 7 4 19 5 2015-05-03 12:59:03'),(117,'2015-05-03 12:59:03 neue Reservierung wird eingetragen: 8 7 5 19 5 2015-05-03 12:59:03'),(118,'2015-05-03 12:59:03 neue Reservierung wird eingetragen: 8 7 6 19 5 2015-05-03 12:59:03'),(119,'2015-05-03 12:59:03 neue Reservierung wird eingetragen: 8 7 7 19 5 2015-05-03 12:59:03'),(120,'2015-05-03 12:59:03 neue Reservierung wird eingetragen: 8 7 8 19 5 2015-05-03 12:59:03'),(121,'2015-05-03 12:59:16 neue Reservierung wird eingetragen: 9 4 4 23 9 2015-05-03 12:59:16'),(122,'2015-05-03 12:59:16 neue Reservierung wird eingetragen: 9 4 5 23 9 2015-05-03 12:59:16'),(123,'2015-05-03 12:59:16 neue Reservierung wird eingetragen: 9 4 6 23 9 2015-05-03 12:59:16'),(124,'2015-05-03 12:59:16 neue Reservierung wird eingetragen: 9 4 7 23 9 2015-05-03 12:59:16'),(125,'2015-05-03 12:59:16 neue Reservierung wird eingetragen: 9 4 8 23 9 2015-05-03 12:59:16'),(126,'2015-05-03 12:59:31 neue Reservierung wird eingetragen: 10 4 1 37 8 2015-05-03 12:59:31'),(127,'2015-05-03 12:59:31 neue Reservierung wird eingetragen: 10 4 2 37 8 2015-05-03 12:59:31'),(128,'2015-05-03 12:59:32 neue Reservierung wird eingetragen: 10 4 3 37 8 2015-05-03 12:59:32'),(129,'2015-05-03 12:59:32 neue Reservierung wird eingetragen: 10 4 4 37 8 2015-05-03 12:59:32'),(130,'2015-05-03 12:59:32 neue Reservierung wird eingetragen: 10 4 5 37 8 2015-05-03 12:59:32'),(131,'2015-05-03 12:59:50 neue Reservierung wird eingetragen: 11 1 4 28 7 2015-05-03 12:59:50'),(132,'2015-05-03 12:59:51 neue Reservierung wird eingetragen: 11 1 5 28 7 2015-05-03 12:59:51'),(133,'2015-05-03 12:59:51 neue Reservierung wird eingetragen: 11 1 6 28 7 2015-05-03 12:59:51'),(134,'2015-05-03 12:59:51 neue Reservierung wird eingetragen: 11 1 7 28 7 2015-05-03 12:59:51'),(135,'2015-05-03 13:00:04 neue Reservierung wird eingetragen: 12 7 2 15 15 2015-05-03 13:00:04'),(136,'2015-05-03 13:00:04 neue Reservierung wird eingetragen: 12 7 3 15 15 2015-05-03 13:00:04'),(137,'2015-05-03 13:00:04 neue Reservierung wird eingetragen: 12 7 4 15 15 2015-05-03 13:00:04'),(138,'2015-05-03 13:00:04 neue Reservierung wird eingetragen: 12 7 5 15 15 2015-05-03 13:00:04'),(139,'2015-05-03 13:00:51 neue Reservierung wird eingetragen: 13 5 6 15 1 2015-05-03 13:00:51'),(140,'2015-05-03 13:00:51 neue Reservierung wird eingetragen: 13 5 7 15 1 2015-05-03 13:00:51'),(141,'2015-05-03 13:00:51 neue Reservierung wird eingetragen: 13 5 8 15 1 2015-05-03 13:00:51'),(142,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 4 41 1 2015-05-03 13:01:11'),(143,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 5 41 1 2015-05-03 13:01:11'),(144,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 6 41 1 2015-05-03 13:01:11'),(145,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 7 41 1 2015-05-03 13:01:11'),(146,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 8 41 1 2015-05-03 13:01:11'),(147,'2015-05-03 13:01:11 neue Reservierung wird eingetragen: 14 4 9 41 1 2015-05-03 13:01:11'),(148,'2015-05-03 13:06:08 neue Reservierung wird eingetragen: 15 6 1 16 14 2015-05-03 13:06:08'),(149,'2015-05-03 13:06:08 neue Reservierung wird eingetragen: 15 6 2 16 14 2015-05-03 13:06:08'),(150,'2015-05-03 13:06:08 neue Reservierung wird eingetragen: 15 6 3 16 14 2015-05-03 13:06:08'),(151,'2015-05-03 13:06:08 neue Reservierung wird eingetragen: 15 6 4 16 14 2015-05-03 13:06:08'),(152,'2015-05-03 13:06:22 neue Reservierung wird eingetragen: 16 7 5 4 12 2015-05-03 13:06:22'),(153,'2015-05-03 13:06:22 neue Reservierung wird eingetragen: 16 7 6 4 12 2015-05-03 13:06:22'),(154,'2015-05-03 13:06:22 neue Reservierung wird eingetragen: 16 7 7 4 12 2015-05-03 13:06:22'),(155,'2015-05-03 13:06:23 neue Reservierung wird eingetragen: 16 7 8 4 12 2015-05-03 13:06:23'),(198,'2015-05-04 15:33:40 Reservierung wird gelöscht: 7 4 5 51 2 2015-05-03 12:58:48'),(199,'2015-05-04 15:33:40 Reservierung wird gelöscht: 7 4 6 51 2 2015-05-03 12:58:48'),(200,'2015-05-04 15:33:40 Reservierung wird gelöscht: 7 4 7 51 2 2015-05-03 12:58:48'),(201,'2015-05-04 15:33:40 Reservierung wird gelöscht: 7 4 8 51 2 2015-05-03 12:58:48'),(202,'2015-05-04 15:33:40 Reservierung wird gelöscht: 5 3 1 50 15 2015-05-03 12:21:30'),(203,'2015-05-04 15:33:40 Reservierung wird gelöscht: 5 3 2 50 15 2015-05-03 12:21:30'),(204,'2015-05-04 15:33:40 Reservierung wird gelöscht: 5 3 3 50 15 2015-05-03 12:21:30'),(205,'2015-05-04 15:33:40 Reservierung wird gelöscht: 5 3 4 50 15 2015-05-03 12:21:30'),(206,'2015-05-04 15:33:42 Vorstellung wird gelöscht: 50 14:00 15:00 03.05.2015 16 1'),(207,'2015-05-04 15:33:42 Vorstellung wird gelöscht: 51 14:00 15:00 03.05.2015 16 2');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservierung`
--

DROP TABLE IF EXISTS `reservierung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservierung` (
  `Reservierung_ID` int(11) NOT NULL,
  `Reihe` int(2) NOT NULL,
  `Sitzplatz` int(2) NOT NULL,
  `Vorstellung_ID` int(11) NOT NULL,
  `Kunde_ID` int(11) NOT NULL,
  `Zeit` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `User_ID` int(11) NOT NULL,
  PRIMARY KEY (`Reservierung_ID`,`Reihe`,`Sitzplatz`,`Vorstellung_ID`),
  KEY `fk_reservierung_vorstellung1_idx` (`Vorstellung_ID`),
  KEY `fk_reservierung_kunde1_idx` (`Kunde_ID`),
  KEY `fk_reservierung_user1_idx` (`User_ID`),
  CONSTRAINT `fk_reservierung_kunde1` FOREIGN KEY (`Kunde_ID`) REFERENCES `kunde` (`Kunde_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservierung_vorstellung1` FOREIGN KEY (`Vorstellung_ID`) REFERENCES `vorstellung` (`Vorstellung_ID`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservierung`
--

LOCK TABLES `reservierung` WRITE;
/*!40000 ALTER TABLE `reservierung` DISABLE KEYS */;
INSERT INTO `reservierung` VALUES (1,6,6,1,12,'2015-05-03 10:06:31',2),(1,6,7,1,12,'2015-05-03 10:06:31',2),(1,6,8,1,12,'2015-05-03 10:06:31',2),(2,6,3,45,15,'2015-05-03 10:11:50',2),(2,6,4,45,15,'2015-05-03 10:11:50',2),(2,6,5,45,15,'2015-05-03 10:11:50',2),(2,6,6,45,15,'2015-05-03 10:11:50',2),(3,1,1,12,3,'2015-05-03 10:20:05',3),(3,1,2,12,3,'2015-05-03 10:20:05',3),(3,1,3,12,3,'2015-05-03 10:20:05',3),(3,1,4,12,3,'2015-05-03 10:20:05',3),(3,1,5,12,3,'2015-05-03 10:20:05',3),(4,8,4,34,2,'2015-05-03 10:21:04',3),(4,8,5,34,2,'2015-05-03 10:21:04',3),(4,8,6,34,2,'2015-05-03 10:21:04',3),(4,8,7,34,2,'2015-05-03 10:21:04',3),(6,6,2,2,17,'2015-05-03 12:57:56',2),(6,6,3,2,17,'2015-05-03 12:57:56',2),(6,6,4,2,17,'2015-05-03 12:57:56',2),(6,6,5,2,17,'2015-05-03 12:57:57',2),(6,6,6,2,17,'2015-05-03 12:57:57',2),(8,7,4,19,5,'2015-05-03 12:59:03',2),(8,7,5,19,5,'2015-05-03 12:59:03',2),(8,7,6,19,5,'2015-05-03 12:59:03',2),(8,7,7,19,5,'2015-05-03 12:59:03',2),(8,7,8,19,5,'2015-05-03 12:59:03',2),(9,4,4,23,9,'2015-05-03 12:59:16',2),(9,4,5,23,9,'2015-05-03 12:59:16',2),(9,4,6,23,9,'2015-05-03 12:59:16',2),(9,4,7,23,9,'2015-05-03 12:59:16',2),(9,4,8,23,9,'2015-05-03 12:59:16',2),(10,4,1,37,8,'2015-05-03 12:59:31',2),(10,4,2,37,8,'2015-05-03 12:59:31',2),(10,4,3,37,8,'2015-05-03 12:59:32',2),(10,4,4,37,8,'2015-05-03 12:59:32',2),(10,4,5,37,8,'2015-05-03 12:59:32',2),(11,1,4,28,7,'2015-05-03 12:59:50',2),(11,1,5,28,7,'2015-05-03 12:59:51',2),(11,1,6,28,7,'2015-05-03 12:59:51',2),(11,1,7,28,7,'2015-05-03 12:59:51',2),(12,7,2,15,15,'2015-05-03 13:00:04',2),(12,7,3,15,15,'2015-05-03 13:00:04',2),(12,7,4,15,15,'2015-05-03 13:00:04',2),(12,7,5,15,15,'2015-05-03 13:00:04',2),(13,5,6,15,1,'2015-05-03 13:00:51',2),(13,5,7,15,1,'2015-05-03 13:00:51',2),(13,5,8,15,1,'2015-05-03 13:00:51',2),(14,4,4,41,1,'2015-05-03 13:01:11',2),(14,4,5,41,1,'2015-05-03 13:01:11',2),(14,4,6,41,1,'2015-05-03 13:01:11',2),(14,4,7,41,1,'2015-05-03 13:01:11',2),(14,4,8,41,1,'2015-05-03 13:01:11',2),(14,4,9,41,1,'2015-05-03 13:01:11',2),(15,6,1,16,14,'2015-05-03 13:06:08',2),(15,6,2,16,14,'2015-05-03 13:06:08',2),(15,6,3,16,14,'2015-05-03 13:06:08',2),(15,6,4,16,14,'2015-05-03 13:06:08',2),(16,7,5,4,12,'2015-05-03 13:06:22',2),(16,7,6,4,12,'2015-05-03 13:06:22',2),(16,7,7,4,12,'2015-05-03 13:06:22',2),(16,7,8,4,12,'2015-05-03 13:06:23',2);
/*!40000 ALTER TABLE `reservierung` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger Reservierung_before_insert_log before insert on reservierung
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " neue Reservierung wird eingetragen: ", NEW.Reservierung_ID, " ",NEW.Reihe, " ",NEW.Sitzplatz, " ",NEW.Vorstellung_ID, " ",NEW.Kunde_ID, " ", NEW.Zeit));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger Reservierung_before_delete_log before delete on reservierung
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " Reservierung wird gelöscht: ", OLD.Reservierung_ID, " ",OLD.Reihe, " ",OLD.Sitzplatz, " ",OLD.Vorstellung_ID, " ",OLD.Kunde_ID, " ", OLD.Zeit));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `saal`
--

DROP TABLE IF EXISTS `saal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saal` (
  `Saal_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Anzahl_Sitze_pro_Reihe` int(2) NOT NULL,
  `Anzahl_Reihen` int(2) NOT NULL,
  `Projektor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Soundanlage` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Saal_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saal`
--

LOCK TABLES `saal` WRITE;
/*!40000 ALTER TABLE `saal` DISABLE KEYS */;
INSERT INTO `saal` VALUES (1,10,8,'OLDSCHOOL Pro','Dobli Digital 5.1'),(2,10,6,'3D Ultra','Dobli Digital 5.1');
/*!40000 ALTER TABLE `saal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `Zeit` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('10:32:50'),('10:32:51'),('10:32:52'),('10:32:53'),('10:32:54'),('10:32:55'),('10:32:56'),('10:32:57'),('10:32:59'),('10:33:00'),('10:33:01'),('10:33:02'),('10:33:03'),('10:33:04'),('10:33:05'),('10:33:06'),('10:33:07'),('10:33:08'),('10:33:09'),('10:33:10'),('10:33:11'),('10:33:12'),('10:33:13'),('10:33:14'),('10:33:15'),('10:33:16'),('10:33:17'),('10:33:18'),('10:33:19'),('10:33:20'),('10:33:21'),('10:33:22'),('10:33:23');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `User_ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `passwort` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`User_ID`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Admin','21232f297a57a5a743894a0e4a801fc3'),(3,'Mitarbeiter','e1928773dc6cc49f7968e6ef6f8272aa');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_filme`
--

DROP TABLE IF EXISTS `v_filme`;
/*!50001 DROP VIEW IF EXISTS `v_filme`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_filme` (
  `Name` tinyint NOT NULL,
  `Bild` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_vorstellung`
--

DROP TABLE IF EXISTS `v_vorstellung`;
/*!50001 DROP VIEW IF EXISTS `v_vorstellung`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_vorstellung` (
  `Vorstellung_ID` tinyint NOT NULL,
  `Bild` tinyint NOT NULL,
  `Name` tinyint NOT NULL,
  `uhrzeit` tinyint NOT NULL,
  `datum` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_vorstellung2`
--

DROP TABLE IF EXISTS `v_vorstellung2`;
/*!50001 DROP VIEW IF EXISTS `v_vorstellung2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_vorstellung2` (
  `Name` tinyint NOT NULL,
  `Bild` tinyint NOT NULL,
  `Uhrzeit` tinyint NOT NULL,
  `Datum` tinyint NOT NULL,
  `Saal_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vorstellung`
--

DROP TABLE IF EXISTS `vorstellung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vorstellung` (
  `Vorstellung_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Beginn` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Ende` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Datum` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Filme_ID` int(11) NOT NULL,
  `Saal_ID` int(11) NOT NULL,
  PRIMARY KEY (`Vorstellung_ID`,`Beginn`,`Datum`,`Saal_ID`),
  UNIQUE KEY `Vorstellung_ID_UNIQUE` (`Vorstellung_ID`),
  KEY `fk_vorstellung_filme_idx` (`Filme_ID`),
  KEY `fk_vorstellung_saal1_idx` (`Saal_ID`),
  CONSTRAINT `fk_vorstellung_filme` FOREIGN KEY (`Filme_ID`) REFERENCES `filme` (`Filme_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_vorstellung_saal1` FOREIGN KEY (`Saal_ID`) REFERENCES `saal` (`Saal_ID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vorstellung`
--

LOCK TABLES `vorstellung` WRITE;
/*!40000 ALTER TABLE `vorstellung` DISABLE KEYS */;
INSERT INTO `vorstellung` VALUES (1,'18:00','21:30','07.05.2015',1,1),(2,'20:00','23:00','07.05.2015',1,2),(3,'19:00','23:00','08.05.2015',1,1),(4,'15:00','18:00','08.05.2015',5,1),(5,'10:00','12:00','09.05.2015',1,1),(6,'17:00','19:00','09.05.2015',2,1),(7,'12:30','14:30','10.05.2015',6,1),(8,'21:00','24:00','10.05.2015',5,2),(9,'18:00','20:00','11.05.2015',2,1),(10,'11:30','14:30','11.05.2015',5,1),(11,'15:00','18:00','12.05.2015',11,1),(12,'14:00','18:00','12.05.2015',14,2),(13,'09:30','11:30','13.05.2015',9,2),(14,'21:00','24:00','13.05.2015',3,1),(15,'20:00','23:00','14.05.2015',4,1),(16,'14:00','16:00','14.05.2015',7,2),(18,'15:00','17:00','07.05.2015',3,1),(19,'10:00','13:00','07.05.2015',4,1),(20,'09:00','11:00','07.05.2015',2,2),(21,'12:30','15:30','07.05.2015',5,2),(22,'09:30','12:30','08.05.2015',6,2),(23,'11:00','14:00','08.05.2015',4,1),(24,'15:00','18:00','08.05.2015',3,2),(25,'20:00','23:00','08.05.2015',6,2),(26,'20:00','23:00','09.05.2015',6,1),(27,'10:00','13:00','09.05.2015',5,2),(28,'14:00','17:00','09.05.2015',4,2),(29,'18:00','20:00','09.05.2015',2,2),(30,'15:00','17:00','10.05.2015',2,1),(31,'18:00','21:30','10.05.2015',1,1),(32,'17:00','19:00','10.05.2015',2,2),(33,'10:00','13:00','10.05.2015',3,2),(34,'20:30','23:30','11.05.2015',11,1),(36,'10:00','14:00','11.05.2015',14,2),(37,'15:00','17:00','11.05.2015',13,2),(39,'10:00','12:00','12.05.2015',9,1),(40,'19:00','22:00','12.05.2015',8,2),(41,'09:00','11:00','12.05.2015',7,2),(43,'15:00','18:00','13.05.2015',11,1),(44,'12:00','15:00','13.05.2015',8,2),(45,'20:00','23:00','13.05.2015',11,2),(46,'10:00','13:00','14.05.2015',8,1),(47,'17:00','19:00','14.05.2015',7,1),(48,'10:00','13:00','14.05.2015',8,2),(49,'17:00','19:00','14.05.2015',13,2);
/*!40000 ALTER TABLE `vorstellung` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger vorstellung_before_insert_log before insert on vorstellung
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " neue Vorstellung wird eingetragen: ", NEW.Vorstellung_ID, " ",NEW.Beginn, " ",NEW.Ende, " ",NEW.Datum, " ",NEW.Filme_ID, " ",NEW.Saal_ID));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger vorstellung_before_delete_log before delete on vorstellung
for each row 
begin

	insert into log (Aktion)
    values (concat(  now(), " Vorstellung wird gelöscht: ", OLD.Vorstellung_ID, " ",OLD.Beginn, " ",OLD.Ende, " ",OLD.Datum, " ",OLD.Filme_ID, " ",OLD.Saal_ID));

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'kino_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `HalfHourDelete` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `HalfHourDelete` ON SCHEDULE EVERY 5 SECOND STARTS '2015-05-04 15:30:12' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN    
        Call reservieren_delete();
        call vorstellung_delete();
        
      END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'kino_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `reservieren_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reservieren_delete`()
BEGIN


        
        delete from reservierung 
		where Vorstellung_ID 
		in(	select vorstellung_ID from vorstellung 
			where (str_to_date(Beginn, '%H:%i:%s')) < (addtime(curtime(), '00:30:00' ))
			and curtime()<(str_to_date(Beginn, '%H:%i:%s'))
            and (str_to_date(Datum, '%d.%m.%Y'))=curdate()
            );
            
      
      
      
      
     
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reservieren_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reservieren_insert`(IN Reservierung_ID_ INT,IN Reihe_ INT, IN Sitzplatz_ INT, IN Vorstellung_ID_ INT, IN Kunde_ID_ INT, IN User_ID_ INT)
BEGIN
Insert into reservierung (Reservierung_ID, Reihe, Sitzplatz, Vorstellung_ID, Kunde_ID, Zeit, User_ID)
values (Reservierung_ID_, Reihe_, Sitzplatz_, Vorstellung_ID_, Kunde_ID_, now(), User_ID_);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vorstellung_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vorstellung_delete`()
BEGIN


        delete from vorstellung 
				where (	str_to_date(Datum, '%d.%m.%Y') = curdate()
					and str_to_date(Ende, '%H:%i:%s') < curtime() )
                 OR str_to_date(Datum, '%d.%m.%Y') < curdate();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_filme`
--

/*!50001 DROP TABLE IF EXISTS `v_filme`*/;
/*!50001 DROP VIEW IF EXISTS `v_filme`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_filme` AS select `filme`.`Name` AS `Name`,`filme`.`Bild` AS `Bild` from `filme` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vorstellung`
--

/*!50001 DROP TABLE IF EXISTS `v_vorstellung`*/;
/*!50001 DROP VIEW IF EXISTS `v_vorstellung`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vorstellung` AS select `vorstellung`.`Vorstellung_ID` AS `Vorstellung_ID`,`filme`.`Bild` AS `Bild`,`filme`.`Name` AS `Name`,`vorstellung`.`Beginn` AS `uhrzeit`,`vorstellung`.`Datum` AS `datum` from (`vorstellung` join `filme`) where (`vorstellung`.`Filme_ID` = `filme`.`Filme_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vorstellung2`
--

/*!50001 DROP TABLE IF EXISTS `v_vorstellung2`*/;
/*!50001 DROP VIEW IF EXISTS `v_vorstellung2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vorstellung2` AS select `filme`.`Name` AS `Name`,`filme`.`Bild` AS `Bild`,`vorstellung`.`Beginn` AS `Uhrzeit`,`vorstellung`.`Datum` AS `Datum`,`vorstellung`.`Saal_ID` AS `Saal_ID` from (`vorstellung` join `filme`) where (`vorstellung`.`Filme_ID` = `filme`.`Filme_ID`) */;
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

-- Dump completed on 2015-05-04 15:35:44
