ALTER TABLE `#__joodb` ADD `tpl_form` TEXT NULL DEFAULT NULL AFTER `tpl_print`;
ALTER TABLE `#__joodb` ADD `fstate` VARCHAR( 255 ) NULL DEFAULT NULL AFTER `fdate`;
DROP TABLE IF EXISTS `#__joodb_sample`;
CREATE TABLE IF NOT EXISTS `#__joodb_sample` (
  `myid` int(1) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `value` varchar(10) DEFAULT NULL,
  `usefull` enum('Yes','No','Unknonwn') NOT NULL DEFAULT 'Yes',
  `picture` varchar(100) DEFAULT NULL,
  `short_description` text,
  `description` text NOT NULL,
  `wikipedia` varchar(254) DEFAULT NULL,
  `category` set('Sport','Food','Tool','Creature') NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`myid`),
  KEY `title` (`title`),
  KEY `state` (`state`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Table with joodb sample nosense data. Save to remove';
INSERT INTO `#__joodb_sample` (`myid`, `title`, `value`, `usefull`, `picture`, `short_description`, `description`, `wikipedia`, `category`, `date`, `state`) VALUES
(1, 'Cat', '3,45', 'No', 'cat.jpg', 'A very useless domestic cat.', 'The cat (Felis catus), also known as the domestic cat or housecat to distinguish it from other felines and felids, is a small carnivorous mammal that is valued by humans for its companionship and its ability to hunt vermin and household pests. It has been associated with humans for at least 9,500 years and is currently the most popular pet in the world.', 'http://en.wikipedia.org/wiki/Cat', 'Sport,Food,Creature', '2009-10-27 16:37:49', 1),
(3, 'Basketball', '9,45', 'Yes', 'basketball.jpg', 'A Baskeball sport utility.', 'Basketball is a team sport in which two teams of 5 players try to score points against one another by placing a ball through a 10 foot (3.048 m) high hoop (the goal) under organized rules. Basketball is one of the most popular and widely viewed sports in the world.', 'http://en.wikipedia.org/wiki/Basketball', 'Sport', '2009-10-27 16:36:39', 1),
(4, 'Salad', '0,30', 'Yes', 'salad.jpg', 'A green vegetable with not enough calories to survive.', 'Salad is any of a wide variety of dishes including: green salads; vegetable salads; salads of pasta, legumes, or grains; mixed salads incorporating meat, poultry, or seafood; and fruit salads. They include a mixture of cold or hot foods, often including raw vegetables and/or fruits.', 'http://en.wikipedia.org/wiki/Salad', 'Food', '2009-10-27 16:36:28', 1),
(5, 'Sunflower', '', 'Yes', 'sunflower.jpg', 'A yellow something. Symbol for hippies and good to make oil of it.', 'What is usually called the flower is actually a head (formally composite flower) of numerous florets (small flowers) crowded together. The outer florets are the sterile ray florets and can be yellow, maroon, orange, or other colors. The florets inside the circular head are called disc florets, which mature into what are traditionally called "sunflower seeds," but are actually the fruit (an achene) of the plant. The inedible husk is the wall of the fruit and the true seed lies within the kernel.', 'http://en.wikipedia.org/wiki/Sunflowers', 'Creature', '2009-10-08 16:41:51', 1),
(6, 'Candy', '0,34', 'No', 'sweets.jpg', 'Not good for health and weight but very tasty.', 'Confectionery is the set of food items that are rich in sugar, any one or type of which is called a confection. Modern usage may include substances rich in artificial sweeteners as well. The word candy (U.S.A.) or sweets (U.K.) is also used for the extensive variety of candies that comprise confectionery. Generally speaking, confections are low in nutritional value, though specially formulated chocolate has been manufactured in the past for military use due to its high concentration of calories.', 'http://en.wikipedia.org/wiki/Sweets', 'Food', '2009-10-22 17:39:25', 1),
(7, 'Light Bulb', '1', 'Yes', 'bulb.jpg', 'Also called Lamb. Crashes if you drop it.', 'The incandescent light bulb, incandescent lamp or incandescent light globe is a source of electric light that works by incandescence (a general term for heat-driven light emissions which includes the simple case of black body radiation). An electric current passes through a thin filament, heating it until it produces light. The enclosing glass bulb prevents the oxygen in air from reaching the hot filament, which otherwise would be destroyed rapidly by oxidation. Incandescent bulbs are also sometimes called electric lamps, a term also applied to the original arc lamps.', 'http://en.wikipedia.org/wiki/Light_bulb', 'Tool', '2009-10-29 17:50:26', 1),
(8, 'Umbrella', '14,34', 'Yes', 'para.jpg', 'Not very stylish but useful wen it rains.', 'An umbrella or parasol (sometimes colloquially; gamp, brolly, umbrellery, or bumbershoot) is a canopy designed to protect against precipitation or sunlight. The term parasol usually refers to an item designed to protect from the sun, and umbrella refers to a device more suited to protect from rain. ellis is stood behind me is the material; some parasols are not waterproof. Parasols are often meant to be fixed to one point and often used with patio tables or other outdoor furniture. Umbrellas are almost exclusively hand-held portable devices; however, parasols can also be hand-held. Umbrellas can be held as fashion accessories.', 'http://en.wikipedia.org/wiki/Umbrella', 'Tool', '2009-10-14 00:00:00', 1),
(9, 'Hambuger', '3,50', 'No', 'burger.jpg', 'I get hungry if i see the picture.', 'A hamburger (or burger) is a sandwich consisting of a cooked patty of ground meat, usually beef, placed in an open bun or between two slices of bread. Hamburgers are often served with lettuce, tomato, onion, pickles, or cheese and condiments such as mustard, mayonnaise, and ketchup.', 'http://en.wikipedia.org/wiki/Hamburger', 'Sport,Food', '2009-10-22 17:52:22', 1),
(10, 'Golfball', '', 'Unknonwn', 'golf.jpg', 'Golf is a expensive sport for older people.', 'Golf is a precision club-and-ball sport, in which competing players (golfers), using many types of clubs, attempt to hit balls into each hole on a golf course while employing the fewest number of strokes. Golf is one of the few ball games that does not require a standardized playing area. Instead, the game is played on golf "courses", each of which features a unique design, although courses typically consist of either nine or 18 holes. Golf is defined, in the rules of golf, as "playing a ball with a club from the teeing ground into the hole by a stroke or successive strokes in accordance with the Rules." Golf competition is generally played for the lowest number of strokes by an individual, known simply as stroke play, or the lowest score on the most individual holes during a complete round by an individual or team, known as match play.', 'http://en.wikipedia.org/wiki/Golfing', 'Sport', '2005-10-12 18:09:30', 1),
(11, 'Tomato', '0,50', 'Yes', 'tomato.jpg', 'People often drink tomato juice while flying.', 'The tomato (Solanum lycopersicum, syn. Lycopersicon lycopersicum & Lycopersicon esculentum[1]) is a herbaceous, usually sprawling plant in the Solanaceae or nightshade family that is typically cultivated for the purpose of harvesting its fruit for human consumption. Savory in flavor (and accordingly termed a vegetable; see section Fruit or vegetable below), the fruit of most varieties ripens to a distinctive red color. Tomato plants typically reach to 1–3 metres (3–10 ft) in height, and have a weak, woody stem that often vines over other plants. The leaves are 10–25 centimetres (4–10 in) long, odd pinnate, with 5–9 leaflets on petioles,[2] each leaflet up to 8 centimetres (3 in) long, with a serrated margin; both the stem and leaves are densely glandular-hairy. The flowers are 1–2 centimetres (0.4–0.8 in) across, yellow, with five pointed lobes on the corolla; they are borne in a cyme of 3–12 together. It is a perennial, often grown outdoors in temperate climates as an annual.', 'http://en.wikipedia.org/wiki/Tomato', 'Food', '2009-10-21 18:10:51', 1),
(12, 'Paprika', '1,9', 'Yes', 'paprica.jpg', 'I wonder why people like to eat Paprika. In Germany they have nearly no taste at all.', 'Paprika is a spice made from the grinding of dried fruits of Capsicum annuum (e.g., bell peppers or chili peppers). In many European countries, the word paprika also refers to bell peppers themselves. The seasoning is used in many cuisines to add color and flavor to dishes. Paprika can range from sweet (mild, not hot) to spicy (hot). Flavors also vary from country to country.', 'http://en.wikipedia.org/wiki/Paprika', 'Food', '2009-10-15 18:15:46', 1),
(13, 'Football', '14', 'Yes', 'football.jpg', 'In America the sport is called soccer. Not to mix with sucker, which is a defamation.', 'Football is the name of several similar team sports, all of which involve (to varying degrees) kicking a ball with the foot in an attempt to score a goal. The most popular of these sports worldwide is association football, more commonly known as just "football" or "soccer". However the word football is applied to whichever form of football became most popular in each particular part of the world. Hence the English language word "football" is applied to "gridiron football" (a name associated with the North American sports, especially American football and Canadian football), Australian football, Gaelic football, rugby league, rugby union, and related games. These rule variations are known as "codes."', 'http://en.wikipedia.org/wiki/Football', 'Sport', '2009-10-27 18:27:31', 1);
DROP TABLE IF EXISTS `#__joodb_settings`;
CREATE TABLE IF NOT EXISTS `#__joodb_settings` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  `value` text NOT NULL,
  `jb_id` int(1) DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `jb_id` (`jb_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Settings table for JooDatabase';


