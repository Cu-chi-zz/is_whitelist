CREATE TABLE IF NOT EXISTS `users_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `admin` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;