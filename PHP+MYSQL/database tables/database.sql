-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.29 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 正在导出表  php_gem.order 的数据：~2 rows (大约)
INSERT INTO `order` (`product_id`, `client_name`, `client_email`, `quantity`, `order_time`) VALUES
	(1, 'tom', '123@123', 1, '2022-11-12 00:17:46'),
	(1, '123', '123@123', 1, '2022-11-12 01:02:06'),
	(6, 'tom', 'xdxdbj4@gmail.com', 1, '2023-01-02 05:03:38'),
	(3, 'sadsadsad', 'asdsa@asd.com', 1, '2023-01-02 06:21:48');

-- 正在导出表  php_gem.products 的数据：~9 rows (大约)
INSERT INTO `products` (`product_id`, `name`, `price`, `image`, `remaining`, `category`) VALUES
	(1, 'Adidas Racer TR21 GX0651', 1000, 'Adidas Racer TR21 GX0651.jpg', 2, 'shoes'),
	(2, 'Adidas RUN FALCON 2.0', 2000, 'Adidas RUN FALCON 2.0.jpg', 12, 'shoes'),
	(3, 'ADIDAS SUPERSTAR', 2200, 'ADIDAS SUPERSTAR.jpg', 100, 'shoes'),
	(4, 'adidas ULTRABOOST 22', 1500, 'adidas ULTRABOOST 22.jpg', 5, 'shoes'),
	(5, 'ADIDAS 3-stripes french terry set', 300, 'ADIDAS 3-stripes french terry set.jpg', 50, 'clothes'),
	(6, 'Adidas Men\'s Lock Up T-Shirt in Black', 500, 'Adidas Men\'s Lock Up T-Shirt in Black.jpg', 30, 'clothes'),
	(7, 'Adidas Originals Adicolor 3 Stripes Short Sleeve T-Shirt', 350, 'Adidas Originals Adicolor 3 Stripes Short Sleeve T-Shirt.jpg', 25, 'clothes'),
	(8, 'Adidas- Men - FRM Sweatpant ', 500, 'Adidas- Men - FRM Sweatpant .jpg', 35, 'pants'),
	(9, 'adidas originals jogging pants', 400, 'adidas originals jogging pants.jpg', 30, 'pants'),
	(10, 'Tiro 21 Track Pants', 600, 'Tiro 21 Track Pants.jpg', 50, 'pants');

-- 正在导出表  php_gem.staff 的数据：~2 rows (大约)
INSERT INTO `staff` (`email`, `password`, `name`, `id`) VALUES
	('Tom@gmail.com', '$2y$10$5Ua5qPhGnsapXj8kQht4DOU9xj.C1jIIX6vzD/s3MIwiI6u0M7obG', 'Tom', 1),
	('Jacky@gmail.com', '$2y$10$rOHh9p2miXa1Ape29eko3e4TkKAurc2B5LSa995V04tDsMmXxbMkq', 'Jacky', 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
