CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
)

INSERT INTO `pages` (`id`, `url`, `title`, `content`) VALUES
(1, 'index.php', 'Home', 'Welcome to application home. '),
(2, 'index.php?page=about', 'About Us', 'Welcome to know about our website.'),
(3, 'index.php?page=Contact', 'Contact', 'Enter Email <input type="text" />');
