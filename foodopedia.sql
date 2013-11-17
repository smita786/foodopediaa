-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: foodopedia
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.12.04.1

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
-- Table structure for table `auth_cas`
--

DROP TABLE IF EXISTS `auth_cas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_cas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `service` varchar(512) DEFAULT NULL,
  `ticket` varchar(512) DEFAULT NULL,
  `renew` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_cas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_cas`
--

LOCK TABLES `auth_cas` WRITE;
/*!40000 ALTER TABLE `auth_cas` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_cas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_event`
--

DROP TABLE IF EXISTS `auth_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_stamp` datetime DEFAULT NULL,
  `client_ip` varchar(512) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `origin` varchar(512) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_event_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_event`
--

LOCK TABLES `auth_event` WRITE;
/*!40000 ALTER TABLE `auth_event` DISABLE KEYS */;
INSERT INTO `auth_event` VALUES (1,'2013-11-14 18:03:58','127.0.0.1',NULL,'auth','Group 1 created'),(2,'2013-11-14 18:03:58','127.0.0.1',1,'auth','User 1 Registered'),(3,'2013-11-14 18:04:29','127.0.0.1',1,'auth','User 1 Logged-out'),(4,'2013-11-14 18:04:30','127.0.0.1',1,'auth','User 1 Logged-out'),(5,'2013-11-14 18:04:43','127.0.0.1',1,'auth','User 1 Logged-in');
/*!40000 ALTER TABLE `auth_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(512) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'user_1','Group uniquely assigned to user 1');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_membership`
--

DROP TABLE IF EXISTS `auth_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_membership_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_membership_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_membership`
--

LOCK TABLES `auth_membership` WRITE;
/*!40000 ALTER TABLE `auth_membership` DISABLE KEYS */;
INSERT INTO `auth_membership` VALUES (1,1,1);
/*!40000 ALTER TABLE `auth_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `name` varchar(512) DEFAULT NULL,
  `table_name` varchar(512) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_permission_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `registration_key` varchar(512) DEFAULT NULL,
  `reset_password_key` varchar(512) DEFAULT NULL,
  `registration_id` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'smita','kumari','kumarismita62@gmail.com','pbkdf2(1000,20,sha512)$b7b2be2b1033d36f$675356b0a2182076299503e7bd7d3d900743aa2a','','','');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytable`
--

DROP TABLE IF EXISTS `mytable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myfield` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytable`
--

LOCK TABLES `mytable` WRITE;
/*!40000 ALTER TABLE `mytable` DISABLE KEYS */;
/*!40000 ALTER TABLE `mytable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recepies`
--

DROP TABLE IF EXISTS `recepies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recepies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `image_loc` varchar(512) DEFAULT NULL,
  `description` longtext,
  `serves` varchar(512) DEFAULT NULL,
  `ingredients` varchar(2056) DEFAULT NULL,
  `cooking_time` varchar(128) DEFAULT NULL,
  `steps` longtext,
  `all_ingreds` varchar(1028) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recepies`
--

LOCK TABLES `recepies` WRITE;
/*!40000 ALTER TABLE `recepies` DISABLE KEYS */;
INSERT INTO `recepies` VALUES (12,'\"Lunch\"','biriyani','biriyani','recepies.image_loc.b2fcabf5ff68aff4.627265616b666173745f696d6167652e6a7067.jpg','this is biriyani lunch','1 plate','[[\"rice\", \"200\", \"gram\"], [\"butter\", \"2\", \"tbsp\"], [\"salt\", \"4\", \"tsp\"]]','23:23min','1.doing something\r\n2.doening something else','[\"rice\", \"butter\", \"salt\"]'),(13,'[\"breakfast\", \"Snacks\"]','samosa','samosa','recepies.image_loc.9121d369d328f91d.636f666665652e6a7067.jpg','new samosa okiesssss','5','[[\"maida\", \"500\", \"gram\"], [\"sugar\", \"2\", \"cup\"], [\"milk\", \"200\", \"pieces\"]]','12:30min','one step\r\ntwo step','[\"maida\", \"sugar\", \"milk\"]'),(14,'[\"breakfast\", \"Snacks\"]','samosa','samosa','recepies.image_loc.a4aa8fc132350065.73616d6f73612e6a7067.jpg','A fried or baked pastry with a savory filling, such as spiced potatoes, onions, peas etc.','10 samosas','[[\"maida\", \"1\", \"cup\"], [\"oil\", \"2\", \"tbsp\"], [\"salt\", \"2\", \"tbsp\"], [\"boiled potato\", \"2\", \"pieces\"], [\"boiled peas\", \"1/4\", \"cup\"], [\"grated ginger\", \"1/8\", \"tbsp\"], [\"red chilli powder\", \"1/2\", \"tbsp\"], [\"garam masala\", \"1/4\", \"tbsp\"]]','30 mins','1.Mix the maida with salt, oil, ghee and combine to form a crumbly mixture. Now slowly add enough water to make a pliable dough, not too soft. Divide the dough and shape into balls. Keep aside covered with moist cloth for 15-20 mts.<br>\r\n2.Add the ginger, spice powders and a tbsp of water and saute for a few secs. Add the crumbled potato and boiled peas and cook over medium flame for a few minutes, approx 3-4 mts.<br>\r\n3.Now that the stuffing is ready, prepare the outer layer for the samosas.<br>\r\n4.Roll each ball with the rolling pin into a slightly thin puri,Take a knife and divide the rolled puri into two by cutting through the center.<br>\r\n5.Now take a semi-circle piece of the roti, and make a fold in the shape of a triangle. Seal along the fold. Now place this cone between your thumb and index finger and place a ball of the stuffing inside. Wet your finger and run it along the edges of the dough with water and seal to enclose the stuffing.<br>\r\n6.Press the ends firmly so that the filling does not come out during the deep frying process.<br>\r\n7.Heat enough oil in a wide vessel to deep fry the samosas. Heat the oil till hot but not piping hot. Reduce flame to low medium and drop 2-3 samosas into the oil slowly and deep fry them till golden brown, turning them carefully to the other side so that it cooks on all sides. Deep fry on low to medium heat and not piping hot oil.<br>\r\n8.Remove onto absorbent paper and serve warm over a cup of chai.\r\n','[\"maida\", \"oil\", \"salt\", \"boiled potato\", \"boiled peas\", \"grated ginger\", \"red chilli powder\", \"garam masala\"]'),(16,'[\"breakfast\", \"Lunch\"]','aloo paratha','aloo-paratha','recepies.image_loc.bc0b080075a2176e.616c6f6f2d706172617468612e6a7067.jpg','paratha,whole-wheat Indian flatbread,stuffed with aloo mixture.','6 parathas','[[\"whole wheat flour or atta\", \"2\", \"cup\"], [\"salt\", \"1\", \"tsp\"], [\"potatoes, boiled, peeled and mashed\", \"2\", \"pieces\"], [\"green chili paste\", \"1\", \"tbsp\"], [\"chopped coriander leaves\", \"1 1/2\", \"tbsp\"], [\"red chilli powder\", \"1/2\", \"tbsp\"], [\"ghee\", \"1\", \"cup\"]]','30 mins','1. Add salt to the atta, combine, slowly add water to form a soft yet slightly firm dough. Cover with damp cloth and let it rest for 10 mts. Get the stuffing ready in the mean time.<br>\r\n2.Prepare stuffing by combining mashed potato, green chili paste, coriander leaves and pinch of salt and combine.<br>\r\n3.Pinch a large lemon sized ball of dough and roll to form a 3″ diameter circle. Place some stuffing and take the edges of the dough and cover the stuffing. Prepare with rest of dough.<br>\r\n4.Dust the working surface with some atta and roll out the stuffed dough to form 6″-7″ diameter circles.<br>\r\n5.Heat a iron tawa and once its hot, place a paratha and let it cook for 15 secs. Flip the paratha and let it cook for a few more secs. Once light brown spots appear, drizzle some oil or ghee and roast to a golden shade on both sides.<br>\r\n6.Serve hot with any curry of your choice or yogurt or raita.','[\"whole wheat flour or atta\", \"salt\", \"potatoes, boiled, peeled and mashed\", \"green chili paste\", \"chopped coriander leaves\", \"red chilli powder\", \"ghee\"]'),(17,'[\"Lunch\", \"Dinner\"]','palak paneer','palak-paneer','recepies.image_loc.a0230fd0e38590bf.70616c616b2d70616e6565722e6a7067.jpg','an Indian dish consisting of spinach and paneer in a thick curry sauce based on pureed spinach.','5 medium sized bowls','[[\"chopped palak or spinach\", \"10\", \"cup\"], [\"paneer\", \"1 1/2\", \"cup\"], [\"oil\", \"2\", \"tbsp\"], [\"chopped onions\", \"3/4\", \"cup\"], [\"ginger\", \"1\", \"pieces\"], [\"green chilli\", \"2\", \"\"], [\"turmeric powder\", \"1/2\", \"tsp\"], [\"tomato\", \"3/4\", \"cup\"], [\"garam masala\", \"1\", \"tsp\"], [\"fresh cream\", \"2\", \"tbsp\"], [\"garlic\", \"2\", \"tsp\"]]','20 mins','1.Blanch the spinach in a vesselful of boiling water for 2 to 3 minutes.<br>\r\n2.Drain, refresh with cold water and keep aside to cool for sometime.<br>\r\n3.Blend in a mixer to a smooth purée and keep aside.<br>\r\n4.Heat the oil in a kadhai , add the onions and sauté on a medium flame till they turn translucent.<br>\r\n5.Add the garlic, ginger, green chillies and turmeric powder and sauté on a medium flame for 1 to 2 minutes.<br>\r\n6.Add the tomato pulp and sauté till the mixture leaves oil, while stirring continuously.<br>\r\n7.Add the spinach purée and 2 tbsp of water, mix well and cook on a medium flame for 2 minutes.<br>\r\n8.Add the salt, garam masala and fresh cream and mix well.<br>\r\n9.Add the paneer, mix gently and cook on a medium flame for another 1 to 2 minutes.<br>','[\"chopped palak or spinach\", \"paneer\", \"oil\", \"chopped onions\", \"ginger\", \"green chilli\", \"turmeric powder\", \"tomato\", \"garam masala\", \"fresh cream\", \"garlic\"]'),(18,'[\"breakfast\", \"Lunch\", \"Dinner\"]','mix veg paratha','mix-veg-paratha','recepies.image_loc.968b4c5890e483e8.6d69782d706172617468612e6a7067.jpg','perfect for both breakfast and lunch, make parathas with lots of vegetables.','5 parathas','[[\"Whole wheat Flour\", \"2\", \"cup\"], [\"oil\", \"3-4\", \"tbsp\"], [\"salt\", \"to taste\", \"\"], [\"potato\", \"1\", \"cup\"], [\"peas\", \"1/4\", \"cup\"], [\"carrot\", \"1\", \"pieces\"], [\"cabbage\", \"1/2\", \"cup\"], [\"paneer\", \"1/2\", \"cup\"], [\"cauliflower\", \"1/2\", \"cup\"], [\"onion\", \"1\", \"pieces\"], [\"ginger\", \"1\", \"tsp\"], [\"Turmeric powder\", \"1/4\", \"tsp\"], [\"Chilli powder\", \"1\", \"tsp\"], [\"Garam Masala powder\", \"1/2\", \"tsp\"]]','20 mins','1.Place the flour and salt in a large bowl and mix well.Add water knead till it becomes a soft,pliable and non sticky dough.Keep cover and let sit for at least 30 minutes. <br>\r\n2.First boil potato and green peas till soft n cooked.Then peel skin from potato and mash it along with peas n keep aside.<br>\r\n3.Wash n peel the carrot n shred and grate the paneer also .Cabbage and cauliflower cut into cubs then put into chopper mixture ,keep it aside.<br>\r\n4.Heat oil in a pan,add ginger n onions and saute for a minute.<br>\r\n5.Then add mashed potato n peas,shredded carrots,cauliflower ,cabbage mix well and fry for 5 minutes.<br>\r\n6.Then add turmeric powder, chilli powder and garam masala and salt stir for 4 minutes.<br>\r\n7.Then add paneer stir fry for few seconds and  mix well,turn off the stove.keep it for cool.<br>\r\n8.Now take the chapathi dough, divide the dough into make small medium size balls.<br>\r\n9.Take one dough ball,and roll it to 3\" and keep 1 mixed veg filling and seal the edge together and roll it to a smooth ball and then gently roll it like regular chapathi (with less pressure)Do the same for the remaining dough n filling.<br>\r\n10.Heat a tawa,fry the parathas on both sides till turn golden brown,drizzle some oil on around the parathas (if u need oil ). After that remove form the tawa.<br>\r\n11.Serve hot with pickle or plain curd or yogurt.<br>','[\"Whole wheat Flour\", \"oil\", \"salt\", \"potato\", \"peas\", \"carrot\", \"cabbage\", \"paneer\", \"cauliflower\", \"onion\", \"ginger\", \"Turmeric powder\", \"Chilli powder\", \"Garam Masala powder\"]'),(19,'[\"breakfast\", \"Snacks\"]','chocolate chip cookies','chocolate-chip-cookies','recepies.image_loc.bfadc60b1bb53744.63686f636f2d636869702e6a7067.jpg','Crisp edges, chewy middles, and so, so easy to make.','4 dozen','[[\"flour\", \"1\", \"cup\"], [\"baking soda\", \"1/2\", \"tsp\"], [\"baking powder\", \"1/4\", \"tsp\"], [\"salt\", \"1/2\", \"tsp\"], [\"unsalted butter\", \"1/2\", \"cup\"], [\"sugar\", \"1 3/4\", \"tbsp\"], [\"brown sugar\", \"1/3\", \"cup\"], [\"vanilla extract\", \"1/2\", \"tsp\"], [\"Flax Meal\", \"1\", \"tbsp\"], [\"chocolate chips\", \"1\", \"cup\"], [\"coffee beans\", \"1\", \"cup\"]]','60 mins','1.Take 1 tbsp of  Flax meal put into a bowl.Add 3 tbsp of water to it.Let it stand for few minutes.<br>\r\n2.Take 1 tbsp of  Flax meal put into a bowl.Add 3 tbsp of water to it.Let it stand for few minutes Mix the dry ingredients all purpose flour,baking soda,baking powder and salt in a bowl.<br>\r\n3.Take white sugar,brown sugar ,vanilla extract and butter in a bowl.Beat until creamy.<br>\r\n4.Add the flax meal + water mixture and beat well.<br>\r\n5.Beat the dry ingredients in gradually and add the chocolate chips and coffee beans and mix with a spatula.<br>\r\n6.Drop by tablespoonful (about 2 inches apart)into ungreased baking sheet and bake  in a preheated 375 F oven for about 9-11 minutes or just until set and beginning to brown around edges and on the bottoms.<br>\r\n7. Remove from the oven and allow to cool for a couple of minutes before moving to the wire racks to cool completely.<br>','[\"flour\", \"baking soda\", \"baking powder\", \"salt\", \"unsalted butter\", \"sugar\", \"brown sugar\", \"vanilla extract\", \"Flax Meal\", \"chocolate chips\", \"coffee beans\"]'),(22,'[\"breakfast\", \"Drink\", \"Snacks\"]','grape juice','grape-juice','recepies.image_loc.a72b8b8ca71455d5.67726170652e6a7067.jpg','Easy Summer drink and rich in Vitamin C.','2 glasses','[[\"black grape\", \"2\", \"cup\"], [\"lemon\", \"1/2\", \"\"], [\"sugar\", \"1/4\", \"cup\"], [\"ice cubes\", \"as needed\", \"\"]]','10 mins','1.Remove the grapes from its stem,rinse it well.Transfer it to a blender/ mixer.\r\n2.Grind it along with little water to a fine paste.Strain a metal strainer,add water for the juice ot easily stain.Discard the seeds and the waste.\r\n3. Squeeze lemon juice.Add sugar and stir well until sugar is dissolved completely.Add ice-cubes and serve chilled.\r\nNOTE: Adjust sugar level according to the sourness of the grapes. Don\'t dilute the juice more and add ice-cubes only while serving else the juice will be more diluted.','[\"black grape\", \"lemon\", \"sugar\", \"ice cubes\"]'),(23,'[\"breakfast\", \"Drink\", \"Snacks\"]','mango shake','mango-shake','recepies.image_loc.b2421b8221c653c6.6d616e676f7368616b652e6a7067.jpg','To beat summer heat, rich, creamy, refreshing and delicious shake/beverage ready in minutes.','2 servings','[[\"cold milk\", \"2\", \"cup\"], [\"vanilla icecream\", \"small scoops\", \"\"], [\"mango chopped\", \"1.5\", \"cup\"], [\"sugar\", \"2-3\", \"tbsp\"]]','10 mins','1.Add chopped mangoes and sugar in a blender and blend it to a fine paste.Then add milk.\r\n2.Then a scoop of icecream, blend together to a smooth creamy shake.\r\n3.Serve Chilled!\r\nNOTE: Make sure to use chilled milk else there are chances for the milk to curdle.\r\nYou can even use mango icecream instead of vanilla icecream.','[\"cold milk\", \"vanilla icecream\", \"mango chopped\", \"sugar\"]'),(24,'[\"Lunch\", \"Dinner\"]','veg biryani','veg-biryani','recepies.image_loc.bf143b76779be65f.62697279616e692e6a7067.jpg','delicious, flavourful, rich and exotic rice dish which looks colorful with assorted vegetables and spiced to give a nice fragrance around.','4 plates','[[\"rice\", \"1.5\", \"cup\"], [\"bayleaf\", \"1\", \"\"], [\"cinnamon\", \"1\", \"pieces\"], [\"salt\", \"to taste\", \"\"], [\"cardamom\", \"1\", \"\"], [\"vegetable like carrots , beans , capsicum , peas , potatos , cauliflower\", \"2\", \"cup\"], [\"oil\", \"2\", \"tbsp\"], [\"cumin seeds\", \"1/2\", \"tsp\"], [\"onion\", \"3/4\", \"cup\"], [\"green chilli and red chilli\", \"2\", \"tbsp\"], [\"Turmeric powder\", \"1/4\", \"tsp\"], [\"chopped coriander \", \"2\", \"tsp\"], [\"garam masala\", \"1/2\", \"tsp\"], [\"tomato\", \"1\", \"cup\"], [\"paneer\", \"1/4\", \"cup\"], [\"milk\", \"1/4\", \"cup\"], [\"ghee\", \"2\", \"tbsp\"]]','30 mins','1.Combine 4½ cups of water, bayleaf, cinnamon, clove, cardamom, rice and salt in a deep non-stick pan, cover with a lid and cook on a medium flame for 10 to 12 minutes or till the rice is cooked.\r\n2.Strain the rice using a strainer and keep aside.\r\n3.Heat the oil in a deep non-stick pan and add the cumin seeds.\r\n4.When the seeds crackle, add the onions and sauté on a medium flame for 1 to 2 minutes or till the onions turn translucent.\r\n5.Add the ginger-green chilli paste, turmeric powder, coriander powder, chilli powder and garam masala and sauté on a medium flame for a few seconds.\r\n6.Add the tomatoes and 2 tbsp of water, mix well and cook on a medium flame for 4 to 5 minutes.\r\n7.Add the mixed vegetables, paneer, salt and milk and cook on a medium flame for another 2 to 3 minutes, while stirring occasionally.\r\n8.Add the sugar, mix well and cook on a medium flame for 1 more minute.\r\n9.Combine the curds, coriander and saffron colour in a bowl and mix well.\r\n10.Add the prepared rice mixture and mix well.\r\n11.Transfer ½ of the rice mixture in a handi and spread it evenly with the back of a spoon.\r\n12.Add all the prepared vegetable gravy on it and spread it evenly.\r\n13.Top it with the remaining ½ of the rice mixture and spread it evenly.\r\n14.Pour the ghee evenly over it and cover it with a lid.\r\n15.Place the handi on a non-stick tava (griddle) and cook on a slow flame for 25 to 30 minutes. Serve immediately.','[\"rice\", \"bayleaf\", \"cinnamon\", \"salt\", \"cardamom\", \"vegetable like carrots , beans , capsicum , peas , potatos , cauliflower\", \"oil\", \"cumin seeds\", \"onion\", \"green chilli and red chilli\", \"Turmeric powder\", \"chopped coriander \", \"garam masala\", \"tomato\", \"paneer\", \"milk\", \"ghee\"]'),(25,'[\"breakfast\", \"Lunch\", \"Snacks\"]','sauce fruit salad','sauce-fruit-salad','recepies.image_loc.b9d561174eda9d01.73617563792d66727569742e6a7067.jpg','Layers of fresh fruits are soaked a citrusy sauce and become a refreshing side dish or dessert on a hot day.','4-6','[[\"fresh pinapple\", \"2\", \"cup\"], [\"peeled mango\", \"1\", \"cup\"], [\"banana\", \"1\", \"cup\"], [\"orange\", \"1\", \"cup\"], [\"sugar\", \"1\", \"tbsp\"], [\"fresh lime\", \"1\", \"tbsp\"], [\"cinnamon\", \"1/8\", \"tsp\"], [\" fresh orange juice\", \"2/3\", \"cup\"], [\" fresh lemon juice\", \"1/3\", \"cup\"], [\"toasted coconut\", \"1\", \"cup\"], [\"grated orange zest\", \"1/2\", \"tsp\"], [\"grated lemon zest\", \"1/2\", \"tsp\"], [\"blueberries\", \"2\", \"cup\"], [\"kiwi\", \"3\", \"pieces\"], [\"grapes\", \"1\", \"cup\"], [\"strawberries\", \"1\", \"cup\"]]','15 mins','1.Bring orange juice, lemon juice, brown sugar, orange zest, and lemon zest to a boil in a saucepan over medium-high heat. Reduce heat to medium-low, and simmer until slightly thickened, about 5 minutes. Remove from heat and set aside to cool.\r\n2.Layer the fruit in a large, clear glass bowl in this order: pineapple, strawberries, kiwi fruit, bananas, oranges, grapes, coconut and blueberries. Pour the cooled sauce over the fruit. Cover and refrigerate for 3 to 4 hours before serving.','[\"fresh pinapple\", \"peeled mango\", \"banana\", \"orange\", \"sugar\", \"fresh lime\", \"cinnamon\", \" fresh orange juice\", \" fresh lemon juice\", \"toasted coconut\", \"grated orange zest\", \"grated lemon zest\", \"blueberries\", \"kiwi\", \"grapes\", \"strawberries\"]'),(26,'[\"breakfast\", \"Lunch\", \"Snacks\"]','sauce fruit salad','sauce-fruit-salad','recepies.image_loc.ac4ef6ff30b6cdc6.73617563792d66727569742e6a7067.jpg','Layers of fresh fruits are soaked a citrusy sauce and become a refreshing side dish or dessert on a hot day.','4-6','[[\"fresh pinapple\", \"2\", \"cup\"], [\"peeled mango\", \"1\", \"cup\"], [\"banana\", \"1\", \"cup\"], [\"orange\", \"1\", \"cup\"], [\"sugar\", \"1\", \"tbsp\"], [\"fresh lime\", \"1\", \"tbsp\"], [\"cinnamon\", \"1/8\", \"tsp\"], [\" fresh orange juice\", \"2/3\", \"cup\"], [\" fresh lemon juice\", \"1/3\", \"cup\"], [\"toasted coconut\", \"1\", \"cup\"], [\"grated orange zest\", \"1/2\", \"tsp\"], [\"grated lemon zest\", \"1/2\", \"tsp\"], [\"blueberries\", \"2\", \"cup\"], [\"kiwi\", \"3\", \"pieces\"], [\"grapes\", \"1\", \"cup\"], [\"strawberries\", \"1\", \"cup\"]]','15 mins','1.Bring orange juice, lemon juice, brown sugar, orange zest, and lemon zest to a boil in a saucepan over medium-high heat. Reduce heat to medium-low, and simmer until slightly thickened, about 5 minutes. Remove from heat and set aside to cool.\r\n2.Layer the fruit in a large, clear glass bowl in this order: pineapple, strawberries, kiwi fruit, bananas, oranges, grapes, coconut and blueberries. Pour the cooled sauce over the fruit. Cover and refrigerate for 3 to 4 hours before serving.','[\"fresh pinapple\", \"peeled mango\", \"banana\", \"orange\", \"sugar\", \"fresh lime\", \"cinnamon\", \" fresh orange juice\", \" fresh lemon juice\", \"toasted coconut\", \"grated orange zest\", \"grated lemon zest\", \"blueberries\", \"kiwi\", \"grapes\", \"strawberries\"]'),(27,'[\"breakfast\", \"Drink\", \"Snacks\"]',' Raspberry Banana Mango Smoothie',' raspberry-banana-mango-smoothie','recepies.image_loc.a99e78965d137f95.736d6f6f746869652e6a7067.jpg','A quick healthy breakfast for those on the run or a healthy dessert!','2 servings','[[\"raspberries\", \"3\", \"ounce\"], [\"peeled banana\", \"1\", \"\"], [\"peeled mango\", \"1\", \"\"], [\"yoghurt\", \"5\", \"ounce\"], [\"cold milk\", \"3\", \"ounce\"]]','10 mins','1.Puree all the ingredients in the liquidiser until you have a smooth thick drink.\r\n2.Drink straight away.\r\n\r\n','[\"raspberries\", \"peeled banana\", \"peeled mango\", \"yoghurt\", \"cold milk\"]'),(28,'[\"Drink\", \"Snacks\"]','Caramel & Coconut Milk Shakes','caramel-coconut-milk-shakes','recepies.image_loc.b5efe75fc663f08c.636172616d61656c2e6a7067.jpg','Coffee creamer flavored like Caramel makes this milk shake taste divine! Chocolate, caramel and coconut combine in a delicious cookie-tasting ice cream treat.','2 glasses','[[\"vanilla icecream\", \"1\", \"cup\"], [\"chocolate icecream\", \"1\", \"cup\"], [\"milk\", \"1\", \"cup\"], [\"nestle coffee\", \"2\", \"tbsp\"], [\" caramel syrup\", \"1\", \"tbsp\"], [\"Toasted coconut flakes \", \"50\", \"gram\"]]','10 mins','1.Place ice cream, milk and Coffee-mate in blender, cover.\r\n2.Blend until smooth. \r\n3.Swirl caramel syrup around inside of 2 glasses.\r\n4.Divide milk shake between glasses.\r\n5.Garnish milk shakes with coconut and chocolate.\r\n','[\"vanilla icecream\", \"chocolate icecream\", \"milk\", \"nestle coffee\", \" caramel syrup\", \"Toasted coconut flakes \"]'),(29,'\"Snacks\"','coffee cake','coffee-cake','recepies.image_loc.afd938817591a43f.636f6666656563616b652e6a7067.jpg','Sweet, delicious coffee cake recipes, with a rich crumble topping, taste great as an afternoon snack.','8 servings','[[\"caster sugar\", \"150\", \"gram\"], [\"eggs\", \"3\", \"\"], [\"raising flour\", \"150\", \"gram\"], [\"baking powder\", \"1.5\", \"tsp\"], [\"hot water\", \"1\", \"tbsp\"], [\"instant coffee\", \"1/4\", \"cup\"], [\"icing sugar\", \"225\", \"gram\"], [\"butter\", \"100\", \"gram\"], [\"dark chocolate\", \"100\", \"gram\"]]','50 mins','1.Preheat the oven at 160C, 325 F.\r\n2.Add the sugar and the butter to a bowl and whisk until very fluffy and a pale cream. \r\n3.Wisk the eggs in a mug with a fork and then add them gradually to the mixture with 1 tbsp of flour each time. Make sure you don\'t use all the flour. \r\n4.Add the rest of the flour and the baking powder to the mixture and fold it in gently. \r\n5.Dissolve the coffee and chocolates in the boiling water and add to the mixture still folding. Divide into the sandwich tins and cook for 30 minutes \r\n6.Meanwhile Cream the butter and the icing sugar until light and fluffy. Dissolve the coffee in boiling water, making sure you don\'t add too much water or the icing will be runny and add it to the butter and icing sugar. Whisk and leave in the fridge until the cake is done. \r\n7.Once the cakes are done and have been put onto plates spread the icing on the bottom of one of the cakes (leaving around half of the icing for the top) and spread the chocolates. Spread the remainig icing ontop of the cake. decorate with cherries or walnuts if you have.','[\"caster sugar\", \"eggs\", \"raising flour\", \"baking powder\", \"hot water\", \"instant coffee\", \"icing sugar\", \"butter\", \"dark chocolate\"]'),(30,'[\"breakfast\", \"Snacks\"]','poha','poha','recepies.image_loc.97af603c41606c47.706f68612e6a7067.jpg',' Poha, made from flattened rice, is an easy-to-cook, nutritious snack. It is often eaten for breakfast/brunch or snacks.','3 cups','[[\"poha\", \"3\", \"cup\"], [\"asafoetida\", \"a pinch\", \"\"], [\"green chilli\", \"1-2\", \"\"], [\"onion\", \"1\", \"\"], [\"potato\", \"1\", \"\"], [\"peanuts\", \"1/2\", \"cup\"], [\"Turmeric powder\", \"3/4\", \"tsp\"], [\"curry leaves\", \"4-5\", \"\"], [\"salt\", \"to taste\", \"\"], [\"cilantro\", \"1/2\", \"cup\"], [\"lemon\", \"1/2\", \"\"], [\"mustard seeds\", \"1\", \"tsp\"]]','15 mins','1.Soak the Poha for 5 mins then drain in a colander.\r\n2.Heat oil in a pan. \r\n3.Season with asafoetida, then mustard seeds. As soon as they crackle, add diced onion and green chilies. Fry until translucent.\r\n4.In parallel, heat diced potatoes in microwave for ~2 minutes to partly cook them. \r\n5.Add turmeric and curry leaves to hot oil once onions are done. Add nuts. Add heated potatoes. Sauté until potatoes are done. \r\n6.Add Poha and salt and mix thoroughly. Cook for 3-4 minutes.\r\n7.Transfer to serving bowl and sprinkle with fresh chopped cilantro and lemon juice (or lime juice) before serving.','[\"poha\", \"asafoetida\", \"green chilli\", \"onion\", \"potato\", \"peanuts\", \"Turmeric powder\", \"curry leaves\", \"salt\", \"cilantro\", \"lemon\", \"mustard seeds\"]'),(31,'[\"breakfast\", \"Lunch\", \"Dinner\", \"Snacks\"]','masala dosa','masala-dosa','recepies.image_loc.859aca777c6b4301.646f73612e6a7067.jpg','classic among South Indian breakfast, made by stuffing a dosa with lightly cooked potatoes, onions, green chilli and spices','3 servings','[[\"rice\", \"1.5\", \"cup\"], [\"urad dal\", \"1/2\", \"cup\"], [\"salt\", \"to taste\", \"\"], [\"oil\", \"as needed\", \"\"], [\"potato\", \"2\", \"pieces\"], [\"onion\", \"1\", \"\"], [\"split peas\", \"1/2\", \"tsp\"], [\"mustard seed\", \"1/2\", \"tsp\"], [\"turmeric powder\", \"1/2\", \"tsp\"], [\"green chilli\", \"1-2\", \"\"]]','10 mins','DOSA SHELL:\r\n1.Separately soak rice and urad dal at least 6 hour or overnight in water.\r\n2.Grind to paste. Mix together, add salt with water to make batter. Leave in room temperature overnight.\r\n3.Mix onion and chilies to the thin batter.\r\n4.Heat pan or griddle with little ghee or oil.\r\n5.Spread the mix on pan in circular motion to make thin Dosa. Cook on both the sides, if desired.\r\nMASALA FILLING:\r\n1.Heat oil. Add mustard seed, peas, onions and spice.\r\n2.Fry for about 5 minutes on medium heat or/until onions are turned into golden brown\r\n3.Add potatoes and mix and cook some more Serve\r\n4.Add filling inside Dosa and roll. Serve hot with Chutney.','[\"rice\", \"urad dal\", \"salt\", \"oil\", \"potato\", \"onion\", \"split peas\", \"mustard seed\", \"turmeric powder\", \"green chilli\"]'),(32,'[\"breakfast\", \"Lunch\", \"Dinner\", \"Snacks\"]','idli','idli','recepies.image_loc.a07301e34c8dfd3e.69646c692e6a7067.jpg','a savory south Indian cake, popular as both a breakfast or snack food.','15 servings','[[\"rice\", \"2\", \"cup\"], [\"urad dal\", \"1\", \"cup\"], [\"salt\", \"1.5\", \"tbsp\"], [\"baking powder\", \"a pinch\", \"\"], [\"oil\", \"as needed\", \"\"]]','10 mins','1.Pick, wash and soak the daal overnight or for 8 hours.\r\n2.Pick, wash and drain the rice. Grind it coarsely in a blender.\r\n3.Grind the daal into a smooth and forthy paste.\r\n4.Now mix the grinded rice and daal together into a batter.\r\n5.Mix salt and set aside in a warm place for 8-9 hours or overnight for fermenting.\r\n6.Idlis are ready to be cooked when the batter is well fermented.\r\n7.Grease the idle holder or pan well and fill each of thm with 3/4th full of batter.\r\n8.Steam cook idlis on medium flame for about 10 minutes or until done.\r\n9.Use a butter knife to remove the idlis.\r\n10.Serve them with sambhar or chutney.','[\"rice\", \"urad dal\", \"salt\", \"baking powder\", \"oil\"]'),(33,'[\"Lunch\", \"Dinner\"]','naan','naan','recepies.image_loc.acef3d06e03bf032.6e61616e2e6a7067.jpg','an unleavened Indian bread that is made from wheat flour or maida and is traditionally prepared in a tandoori oven.','4 servings','[[\"maida\", \"3\", \"cup\"], [\"wheat flour\", \"1\", \"cup\"], [\"baking soda\", \"1\", \"tsp\"], [\"baking powder\", \"1.5\", \"tbsp\"], [\"sugar\", \"1\", \"tbsp\"], [\"warm water\", \"1/4\", \"cup\"], [\"warm milk\", \"3/4\", \"cup\"], [\"yoghurt\", \"1\", \"cup\"], [\"butter or ghee\", \"as needed\", \"\"], [\"dry yeast\", \"3/4\", \"tsp\"]]','10 mins','1.Combine yeast, sugar, and warm water and let sit for 5 to 10 minutes, or until foamy. In the meantime, combine flours, baking powder, and baking soda in a bowl. Make a well in the center.\r\n2.Stir milk and yogurt together. Once the yeast mixture is foamy, stir it into the yogurt and milk. Pour into the well of the dry ingredients.\r\n3.Stir with a wooden spoon to combine, then knead dough until smooth. Place dough in a well-oiled bowl, cover with a tea towel or plastic wrap, and let rise for about an hour, or until doubled in size.\r\n4.When dough is ready, punch down and turn out on a well-floured surface.\r\n5.Divide in half, then divide each half into eight pieces of equal size.\r\n6.Roll each piece out into a thin oval approximately 6 inches long and 1/8 inch thick. Heat a cast iron skillet over medium-high heat on the stovetop.\r\n7.Once the pan is hot, brush each side of the naan with melted butter or ghee. \r\n8.Place dough into your skillet. Let cook for around 1 minute, or until dough puffs and bubbles form on top. \r\n9.Flip and let cook for another minute. Repeat with remaining pieces of dough. ','[\"maida\", \"wheat flour\", \"baking soda\", \"baking powder\", \"sugar\", \"warm water\", \"warm milk\", \"yoghurt\", \"butter or ghee\", \"dry yeast\"]'),(34,'[\"Lunch\", \"Dinner\", \"Snacks\"]','gulab jamun','gulab-jamun','recepies.image_loc.8481ad433511ffb9.67756c61626a616d756e2e6a706567.jpeg','Popular Indian dessert made with fresh Khoya  and eaten with a sugar syrup.','4','[[\"khoya\", \"1\", \"cup\"], [\"maida\", \"3\", \"tbsp\"], [\"baking soda\", \"1/8\", \"tsp\"], [\"cardamom\", \"2\", \"\"], [\"sugar\", \"2\", \"cup\"], [\"water\", \"2\", \"cup\"], [\"oil\", \"as needed\", \"\"]]','20 mins','1.Bring khoya to room temperature if its frozen. Crumble it with your hands and measure it. Take khoya, maida and cooking soda in a mixing bowl. Mix well.\r\n2.Slowly add water (add carefully as less is needed) and make a smooth dough without any cracks. No need to knead hard, just gather with your hands so that it forms a smooth dough without lumps. Keep aside for 5 mins and make equal sized balls\r\n3.Meanwhile prepare the sugar syrup with water, sugar, powdered elachi and saffron, bring to boil and boil for 8 minutes to 10 minutes in medium flame.\r\n4.Mean while you can fry the rolled jamuns. Bring oil hot, not smoking hot, but hot enough to fry the jamuns. Keep in low flame and add the jamuns and keep rolling the jamuns gently with the use of the ladle inside the oil so that it gets evenly cooked and fried to deep golden brown in colour. Fry only few at a time, dont dump the jamuns so many in oil.\r\n5.Drain in kitchen towel and immediately add it to hot syrup. Let it get soaked well. Add essence lastly if desired.\r\n\r\nNOTE:\r\n1.If you have cracks in the dough or balls when you are making, sprinkle more water and make a smooth dough. You can use ghee if its sticky, thought it was not sticky at all for me.\r\n2.If oil is not hot enough, the jamuns will get cracked and suck more oil.\r\n3.Sometimes oil will get low in heat while you fry jamun, so make sure to keep the flame more in between when needed.','[\"khoya\", \"maida\", \"baking soda\", \"cardamom\", \"sugar\", \"water\", \"oil\"]'),(35,'[\"breakfast\", \"Lunch\", \"Dinner\"]','aloo sabki','aloo-sabji','recepies.image_loc.a6eda8259bf24c27.616c6f6f7361626a692e6a7067.jpg','The ever popular potato finds its way into every cuisine and is cooked in a different, delicious way each time and flavoured with fennel and nigella and other subtle spices','4 servings','[[\"potato peeled\", \"4\", \"cup\"], [\"curd\", \"1\", \"cup\"], [\"besan\", \"1\", \"tsp\"], [\"mustard seeds\", \"1/2\", \"tsp\"], [\"cumin seeds\", \"1\", \"tsp\"], [\"saunf\", \"1\", \"tsp\"], [\"nigella seeds\", \"1/2\", \"tsp\"], [\"bayleaf\", \"1\", \"\"], [\"cloves\", \"2\", \"\"], [\"cinnamon\", \"2\", \"\"], [\"hing\", \"1/8\", \"tsp\"], [\"Chilli powder\", \"2\", \"tsp\"], [\"turmeric powder\", \"1/4\", \"tsp\"], [\"coriander cumin seeds\", \"1\", \"tsp\"], [\"ghee\", \"1\", \"tbsp\"], [\"salt\", \"to taste\", \"\"], [\"chopped coriander leaves\", \"2\", \"tbsp\"]]','15 mins','1.In a bowl, combine the curds and gram flour together and whisk well. Keep aside.\r\n2.Heat the ghee in a pan and add the mustard seeds. When they crackle, add the cumin seeds, fennel seeds, nigella seeds, bay leaf, cloves, cinnamon and asafoetida and stir for a few seconds.\r\n3.Add the curds and gram flour mixture, chilli powder, turmeric powder, coriander-cumin seed powder and continue stirring till it comes to a boil.\r\n4.Add the potatoes and salt with 1/2 cup of water and mix well. Bring to a boil.\r\n5.Serve hot, garnished with the coriander.','[\"potato peeled\", \"curd\", \"besan\", \"mustard seeds\", \"cumin seeds\", \"saunf\", \"nigella seeds\", \"bayleaf\", \"cloves\", \"cinnamon\", \"hing\", \"Chilli powder\", \"turmeric powder\", \"coriander cumin seeds\", \"ghee\", \"salt\", \"chopped coriander leaves\"]'),(36,'[\"breakfast\", \"Lunch\", \"Dinner\"]','potatoes in tomato gravy','potatoes-in-tomato-gravy','recepies.image_loc.b4ddd5cc9ac16bb9.74616d617461722e6a7067.jpg',' potatoes in tomato gravy, a great side dish to have with roti or puri.','4 servings','[[\"oil\", \"1\", \"tbsp\"], [\"mustard seed\", \"1/4\", \"tsp\"], [\"cumin seeds\", \"1/4\", \"tsp\"]]','10 mins','1.Heat oil in a medium pan.  Add the tempering of mustard seeds, let pop, then cumin seeds, let sizzle, then hing.  Add potatoes, sauté.  If this aloo-tamatar subzi is not meant for fasting or festival food, you could also add onions and garlic at this point.\r\n2.Cover the pan and let potatoes soften in their steam, about 2 minutes.  Sprinkle a pinch of salt to speed up the process, mix once in a while.\r\n3.Once potatoes are somewhat tender, add tomatoes + ginger paste/grated ginger + turmeric powder + red chili powder + coriander powder + salt + sugar and mix everything well.  Cook until tomatoes soften.  Potatoes do not have to be completely soft and mushy at this point because they are going to cook further in water and soften more.\r\n4.add 1 cup of water to the pan.  If need be, then add a little more, just until all the vegetables are immersed in water.  Do not add too much water at once otherwise boiling it longer to thicken the gravy is going to waste time.\r\n5.Cover and cook, mixing once in a while, for 2 minutes.  Adjust salt and spice level according to your taste.  You could add garam masala at this point also.\r\n6.Mash some of the potatoes so the watery gravy will automatically have a little thicker consistency.\r\n7.Garnish the potatoes in tomato gravy with coriander leaves/cilantro.  Serve it with soft and warm whole wheat flour roti.  And may be with some green chilies and onions on the side.','[\"oil\", \"mustard seed\", \"cumin seeds\"]');
/*!40000 ALTER TABLE `recepies` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-14 22:45:58
