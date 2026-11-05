-- Script SQL completo y depurado


-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-11-2026 a las 17:41:38
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

CREATE DATABASE IF NOT EXISTS thehearth_v2
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE thehearth_v2;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `thehearth_v2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `active`) VALUES
(1, 'Meats', 'High-quality cuts of meat grilled to perfection.', 1),
(2, 'Seafood', 'Fresh fish and seafood sourced directly from the coast.', 1),
(3, 'Sides', 'Delicious side dishes to complement your main meal.', 1),
(4, 'Beverages', 'Refreshing soft drinks, juices, and water.', 1),
(5, 'Wines', 'Selection of fine red, white, and rosé wines.', 1),
(6, 'Spirits', 'Premium liquors, cocktails, and distilled spirits.', 1),
(7, 'Desserts', 'Homemade sweet treats and desserts to finish your meal.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `extra_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingredients`
--

INSERT INTO `ingredients` (`id`, `name`, `extra_price`, `active`) VALUES
(1, 'Salt', 0.00, 1),
(2, 'Pepper', 0.00, 1),
(3, 'Garlic Butter', 1.50, 1),
(4, 'Cherry Reduction', 2.00, 1),
(5, 'Mint Sauce', 1.50, 1),
(6, 'Serrano Ham', 3.00, 1),
(7, 'Melted Cheese', 2.00, 1),
(8, 'Cauliflower Purée', 2.50, 1),
(9, 'Lemon-Dill Butter', 1.50, 1),
(10, 'Garlic Cream', 1.50, 1),
(11, 'Lobster Meat', 6.00, 1),
(12, 'Wild Mushrooms', 2.50, 1),
(13, 'Ice', 0.00, 1),
(14, 'Wild Berries', 2.00, 1),
(15, 'Red Fruit Syrup', 1.50, 1),
(16, 'Vanilla Bean Ice Cream', 2.50, 1),
(17, 'Oat Crumble', 1.50, 1),
(18, 'Graham Cracker Crust', 1.50, 1),
(19, 'Apple-Bourbon Gastrique', 2.50, 1),
(20, 'Side Salad', 3.00, 1),
(21, 'Roasted Vegetables', 2.50, 1),
(22, 'Cucumber & Rose Infusion', 2.00, 1),
(23, 'Berry Compote', 2.00, 1),
(24, 'Fresh Thyme & Shallots', 1.00, 1),
(25, 'Truffle Oil', 3.50, 1),
(26, 'Bacon', 2.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(20) NOT NULL COMMENT 'Values: discount, 2x1, combo, code',
  `value` decimal(10,2) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `days_of_week` varchar(50) DEFAULT '1,2,3,4,5,6,7' COMMENT 'Días permitidos, ej: 1,2 (L-M) o 3,4,5,6,7 (X-D)',
  `stackable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '¿Permite combinarse con otras ofertas?',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL DEFAULT '2100-12-31 23:59:59',
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `offers`
--

INSERT INTO `offers` (`id`, `name`, `description`, `type`, `value`, `code`, `days_of_week`, `stackable`, `start_date`, `end_date`, `active`) VALUES
(1, 'Tuesday Meat Special', '15% off on our finest Tomahawk Steak on Mondays and Tuesdays.', 'discount', 15.00, NULL, '1,2', 0, '2026-11-01 00:00:00', '2100-12-31 23:59:59', 1),
(2, 'Sweet Thursdays', 'Buy one dessert and get another one free every Thursday.', '2x1', 50.00, NULL, '4', 1, '2026-11-01 00:00:00', '2100-12-31 23:59:59', 1),
(3, 'Ultimate Steak & Wine Experience', 'Tomahawk Steak paired with a selected bottle of wine for 135€.', 'combo', 135.00, NULL, '3,4,5,6,7', 1, '2026-11-01 00:00:00', '2100-12-31 23:59:59', 1),
(4, 'General 10% Off', 'Get 10% off on your order using our special code.', 'code', 10.00, 'THEHEARTH10', '1,2,3,4,5,6,7', 0, '2026-01-01 00:00:00', '2100-12-31 23:59:59', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `offer_product`
--

CREATE TABLE `offer_product` (
  `offer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `offer_product`
--

INSERT INTO `offer_product` (`offer_id`, `product_id`) VALUES
(1, 1),
(3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT 'Values: pending, confirmed, processing, dispatched, delivered, cancelled',
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'card' COMMENT 'Values: cash, card',
  `payment_status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT 'Values: pending, payed, failed'
) ;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `order_date`, `subtotal`, `discount`, `total`, `payment_method`, `payment_status`) VALUES
(1, 1, 'delivered', '2026-11-03 20:30:00', 161.00, 18.75, 142.25, 'card', 'payed'),
(2, 2, 'delivered', '2026-11-04 21:00:00', 213.00, 31.95, 181.05, 'card', 'payed'),
(3, 1, 'delivered', '2026-11-05 21:15:00', 171.00, 8.00, 163.00, 'cash', 'payed'),
(4, 2, 'delivered', '2026-11-05 22:00:00', 165.00, 16.50, 148.50, 'card', 'payed'),
(5, 1, 'delivered', '2026-11-06 20:45:00', 138.00, 6.00, 132.00, 'card', 'payed'),
(6, 2, 'delivered', '2026-11-06 21:30:00', 279.00, 14.00, 265.00, 'cash', 'payed'),
(7, 2, 'delivered', '2026-11-07 20:15:00', 155.00, 0.00, 155.00, 'card', 'payed'),
(8, 2, 'delivered', '2026-11-08 21:00:00', 174.00, 0.00, 174.00, 'cash', 'payed'),
(9, 1, 'delivered', '2026-11-09 14:30:00', 142.00, 0.00, 142.00, 'card', 'payed'),
(10, 1, 'delivered', '2026-11-03 21:15:00', 160.00, 0.00, 160.00, 'card', 'payed'),
(11, 2, 'processing', '2026-11-10 20:00:00', 150.00, 15.00, 135.00, 'card', 'pending'),
(12, 1, 'delivered', '2026-11-12 21:30:00', 190.00, 19.00, 171.00, 'cash', 'payed'),
(13, 2, 'delivered', '2026-11-13 22:00:00', 173.00, 8.00, 165.00, 'card', 'payed'),
(14, 1, 'delivered', '2026-11-14 21:15:00', 162.00, 12.00, 150.00, 'card', 'payed'),
(15, 1, 'pending', '2026-11-15 15:00:00', 135.00, 0.00, 135.00, 'cash', 'pending');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(150) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `amount` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL COMMENT 'CHECK amount > 0 AND unit_price >= 0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `order_detail`
--

INSERT INTO `order_detail` (`id`, `order_id`, `product_id`, `product_name`, `unit_price`, `amount`, `subtotal`) VALUES
(1, 1, 1, '45-Day Dry-Aged Tomahawk Steak', 106.25, 1, 106.25),
(2, 1, 14, 'Pan-Seared U-10 Scallops', 36.00, 1, 36.00),
(3, 1, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(4, 1, 19, 'Coca-Cola', 4.00, 2, 8.00),
(5, 2, 1, '45-Day Dry-Aged Tomahawk Steak', 106.25, 1, 106.25),
(6, 2, 2, 'Seared Wagyu A5 Filet Mignon', 180.00, 1, 180.00),
(7, 2, 18, 'Sautéed Wild Mushrooms', 14.00, 1, 14.00),
(8, 2, 20, 'Sprite', 5.00, 2, 10.00),
(9, 3, 1, '45-Day Dry-Aged Tomahawk Steak', 125.00, 1, 125.00),
(10, 3, 24, 'Chardonnay', 10.00, 1, 10.00),
(11, 3, 17, 'Lobster Mac & Cheese', 24.00, 1, 24.00),
(12, 3, 21, 'Mineral Water', 6.00, 2, 12.00),
(13, 4, 3, 'Smoked Duck Breast', 45.00, 1, 45.00),
(14, 4, 11, 'Roasted Rack of Lamb', 48.00, 1, 48.00),
(15, 4, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(16, 4, 25, 'Montepulciano d’Abruzzo', 20.00, 1, 20.00),
(17, 4, 29, 'Molten Chocolate Lava Cake', 12.00, 3, 36.00),
(18, 5, 4, 'Bone-In Veal Chop Milanese', 55.00, 1, 55.00),
(19, 5, 12, 'Smoked Heritage Pork Chop', 38.00, 1, 38.00),
(20, 5, 18, 'Sautéed Wild Mushrooms', 14.00, 1, 14.00),
(21, 5, 29, 'Molten Chocolate Lava Cake', 12.00, 1, 12.00),
(22, 5, 30, 'Fruit Crumble', 0.00, 1, 0.00),
(23, 5, 19, 'Coca-Cola', 4.00, 2, 8.00),
(24, 6, 1, '45-Day Dry-Aged Tomahawk Steak', 125.00, 1, 125.00),
(25, 6, 24, 'Chardonnay', 10.00, 1, 10.00),
(26, 6, 17, 'Lobster Mac & Cheese', 24.00, 1, 24.00),
(27, 6, 29, 'Molten Chocolate Lava Cake', 12.00, 1, 12.00),
(28, 6, 31, 'New York Style Cheesecake', 0.00, 1, 0.00),
(29, 6, 22, 'Sparkling Water', 6.00, 2, 12.00),
(30, 7, 5, 'Butcher\'s Cut', 65.00, 1, 65.00),
(31, 7, 13, 'Spanish Cachopo', 42.00, 1, 42.00),
(32, 7, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(33, 7, 23, 'Freshly Squeezed Orange Juice', 8.00, 2, 16.00),
(34, 7, 29, 'Molten Chocolate Lava Cake', 12.00, 1, 12.00),
(35, 7, 30, 'Fruit Crumble', 12.00, 1, 12.00),
(36, 8, 3, 'Smoked Duck Breast', 45.00, 1, 45.00),
(37, 8, 15, 'Grilled Scottish Salmon', 34.00, 1, 34.00),
(38, 8, 18, 'Sautéed Wild Mushrooms', 14.00, 1, 14.00),
(39, 8, 19, 'Coca-Cola', 4.00, 2, 8.00),
(40, 8, 29, 'Molten Chocolate Lava Cake', 12.00, 2, 24.00),
(41, 9, 11, 'Roasted Rack of Lamb', 48.00, 1, 48.00),
(42, 9, 14, 'Pan-Seared U-10 Scallops', 36.00, 1, 36.00),
(43, 9, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(44, 9, 20, 'Sprite', 5.00, 2, 10.00),
(45, 9, 31, 'New York Style Cheesecake', 12.00, 3, 36.00),
(46, 10, 4, 'Bone-In Veal Chop Milanese', 55.00, 1, 55.00),
(47, 10, 5, 'Butcher\'s Cut', 65.00, 1, 65.00),
(48, 10, 18, 'Sautéed Wild Mushrooms', 14.00, 1, 14.00),
(49, 10, 21, 'Mineral Water', 6.00, 2, 12.00),
(50, 10, 32, 'Homemade Vanilla Bean Panna Cotta', 12.00, 1, 12.00),
(51, 11, 1, '45-Day Dry-Aged Tomahawk Steak', 106.25, 1, 106.25),
(52, 11, 15, 'Grilled Scottish Salmon', 34.00, 1, 34.00),
(53, 11, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(54, 11, 22, 'Sparkling Water', 6.00, 2, 12.00),
(55, 12, 2, 'Seared Wagyu A5 Filet Mignon', 180.00, 1, 180.00),
(56, 12, 18, 'Sautéed Wild Mushrooms', 14.00, 1, 14.00),
(57, 12, 23, 'Freshly Squeezed Orange Juice', 8.00, 2, 16.00),
(58, 13, 1, '45-Day Dry-Aged Tomahawk Steak', 125.00, 1, 125.00),
(59, 13, 25, 'Montepulciano d’Abruzzo', 12.00, 1, 12.00),
(60, 13, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(61, 13, 19, 'Coca-Cola', 4.00, 2, 8.00),
(62, 13, 29, 'Molten Chocolate Lava Cake', 12.00, 1, 12.00),
(63, 14, 3, 'Smoked Duck Breast', 45.00, 1, 45.00),
(64, 14, 11, 'Roasted Rack of Lamb', 48.00, 1, 48.00),
(65, 14, 17, 'Lobster Mac & Cheese', 24.00, 1, 24.00),
(66, 14, 21, 'Mineral Water', 6.00, 2, 12.00),
(67, 14, 29, 'Molten Chocolate Lava Cake', 12.00, 2, 24.00),
(68, 14, 30, 'Fruit Crumble', 0.00, 2, 0.00),
(69, 15, 12, 'Smoked Heritage Pork Chop', 38.00, 1, 38.00),
(70, 15, 13, 'Spanish Cachopo', 42.00, 1, 42.00),
(71, 15, 16, 'Creamy Garlic Mashed Potatoes', 12.00, 1, 12.00),
(72, 15, 20, 'Sprite', 5.00, 2, 10.00),
(73, 15, 31, 'New York Style Cheesecake', 12.00, 2, 24.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_detail_ingredient`
--

CREATE TABLE `order_detail_ingredient` (
  `id` int(11) NOT NULL,
  `order_detail_id` int(11) NOT NULL,
  `ingredient_id` int(11) DEFAULT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `extra_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `action` varchar(20) NOT NULL COMMENT 'Values: included, removed, added'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `order_detail_ingredient`
--

INSERT INTO `order_detail_ingredient` (`id`, `order_detail_id`, `ingredient_id`, `ingredient_name`, `extra_price`, `action`) VALUES
(1, 1, 1, 'Salt', 0.00, 'included'),
(2, 1, 2, 'Pepper', 0.00, 'included'),
(3, 1, 3, 'Garlic Butter', 0.00, 'included'),
(4, 1, 25, 'Truffle Oil', 3.50, 'added'),
(5, 4, 13, 'Ice', 0.00, 'removed'),
(6, 7, 1, 'Salt', 0.00, 'included'),
(7, 7, 2, 'Pepper', 0.00, 'included'),
(8, 7, 12, 'Wild Mushrooms', 0.00, 'included'),
(9, 7, 24, 'Fresh Thyme & Shallots', 0.00, 'included'),
(10, 7, 25, 'Truffle Oil', 3.50, 'added'),
(11, 8, 13, 'Ice', 0.00, 'added'),
(12, 11, 1, 'Salt', 0.00, 'included'),
(13, 11, 2, 'Pepper', 0.00, 'included'),
(14, 11, 7, 'Melted Cheese', 0.00, 'included'),
(15, 11, 11, 'Lobster Meat', 0.00, 'included'),
(16, 11, 11, 'Lobster Meat', 6.00, 'added'),
(17, 12, 13, 'Ice', 0.00, 'removed'),
(18, 20, 1, 'Salt', 0.00, 'included'),
(19, 20, 2, 'Pepper', 0.00, 'included'),
(20, 20, 12, 'Wild Mushrooms', 0.00, 'included'),
(21, 20, 24, 'Fresh Thyme & Shallots', 0.00, 'included'),
(22, 20, 3, 'Garlic Butter', 1.50, 'added'),
(23, 29, 13, 'Ice', 0.00, 'added'),
(24, 32, 1, 'Salt', 0.00, 'included'),
(25, 32, 2, 'Pepper', 0.00, 'included'),
(26, 32, 10, 'Garlic Cream', 0.00, 'included'),
(27, 32, 26, 'Bacon', 2.00, 'added'),
(28, 38, 1, 'Salt', 0.00, 'included'),
(29, 38, 2, 'Pepper', 0.00, 'included'),
(30, 38, 24, 'Fresh Thyme & Shallots', 0.00, 'included'),
(31, 38, 12, 'Wild Mushrooms', 0.00, 'removed'),
(32, 44, 13, 'Ice', 0.00, 'removed'),
(33, 54, 13, 'Ice', 0.00, 'added');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image`, `active`) VALUES
(1, 1, '45-Day Dry-Aged Tomahawk Steak', 'Rich, buttery texture with deep, concentrated beef flavor.', 125.00, 'img/tomahawk.webp', 1),
(2, 1, 'Seared Wagyu A5 Filet Mignon', 'The most tender cut, known for its buttery texture and mild flavor.', 180.00, 'img/wagyu.webp', 1),
(3, 1, 'Smoked Duck Breast', 'Served with cherry reduction and roasted root vegetables.', 45.00, 'img/duckbreast.webp', 1),
(4, 1, 'Bone-In Veal Chop Milanese', 'Breaded and fried veal chop, crisp and tender.', 55.00, 'img/boneinveal.webp', 1),
(5, 1, 'Butcher\'s Cut', 'A rotating selection of our butcher\'s finest daily pick.', 65.00, 'img/butcherscut.webp', 1),
(6, 6, 'Single Barrel Rye Whiskey', 'Spicy and complex with notes of vanilla and oak.', 25.00, 'img/ryewhiskey.webp', 1),
(7, 5, 'Estate Reserve Cabernet Sauvignon', 'Full-bodied red with dark fruit flavors.', 18.00, 'img/cabernetsauvignon.webp', 1),
(8, 6, 'Small Batch Bourbon', 'Smooth finish with hints of caramel and smoke.', 22.00, 'img/batchbourbon.webp', 1),
(9, 6, 'Barrel-Aged Gin', 'Botanical richness with a warm, woody finish.', 16.00, 'img/agedgin.webp', 1),
(10, 6, 'Macallan 12 Year Old Double Cask', 'The perfect balance of American and European oak.', 35.00, 'img/macallan.webp', 1),
(11, 1, 'Roasted Rack of Lamb', 'Succulent herb-crusted lamb rack served with mint reduction and seasonal vegetables.', 48.00, 'img/lambrack.webp', 1),
(12, 1, 'Smoked Heritage Pork Chop', 'Double-cut pork chop, slow-smoked and glazed with an apple-bourbon gastrique.', 38.00, 'img/porkchop.webp', 1),
(13, 1, 'Spanish Cachopo', 'Traditional Asturian breaded veal stuffed with serrano ham and melted cheese.', 42.00, 'img/cachopo.webp', 1),
(14, 2, 'Pan-Seared U-10 Scallops', 'Jumbo scallops seared to golden perfection, served over cauliflower purée.', 36.00, 'img/scallops.webp', 1),
(15, 2, 'Grilled Scottish Salmon', 'Sustainably sourced salmon fillet, grilled and served with lemon-dill butter.', 34.00, 'img/salmon.webp', 1),
(16, 3, 'Creamy Garlic Mashed Potatoes', 'Yukon Gold potatoes whipped with roasted garlic and butter.', 12.00, 'img/garlicmashedpotatoes.webp', 1),
(17, 3, 'Lobster Mac & Cheese', 'Chunks of fresh lobster meat in a rich three-cheese blend.', 24.00, 'img/lobsterm&c.webp', 1),
(18, 3, 'Sautéed Wild Mushrooms', 'Seasonal wild mushrooms sautéed with fresh thyme and shallots.', 14.00, 'img/mushrooms.webp', 1),
(19, 4, 'Coca-Cola', 'Classic chilled Coca-Cola.', 4.00, 'img/coke.webp', 1),
(20, 4, 'Sprite', 'Crisp and refreshing lemon-lime soda.', 5.00, 'img/sprite.webp', 1),
(21, 4, 'Mineral Water', 'Premium still mineral water.', 6.00, 'img/mineral-water.webp', 1),
(22, 4, 'Sparkling Water', 'Effervescent carbonated mineral water.', 6.00, 'img/sparkling-water.webp', 1),
(23, 4, 'Freshly Squeezed Orange Juice', '100% natural orange juice, pressed daily.', 8.00, 'img/orange-juice.webp', 1),
(24, 5, 'Chardonnay', 'Oak-aged with a creamy texture, notes of vanilla, and a buttery finish.', 18.00, 'img/chardonnay.webp', 1),
(25, 5, 'Montepulciano d’Abruzzo', 'A robust Italian red featuring dark cherry notes, soft tannins, and a hint of spice.', 20.00, 'img/abruzzo.webp', 1),
(26, 5, 'Sauvignon Blanc, Marlborough', 'Crisp and refreshing with vibrant notes of citrus, passion fruit, and fresh herbs.', 16.00, 'img/sauvignon-blanc.webp', 1),
(27, 5, 'Pinot Noir, Burgundy', 'An elegant, light-bodied red with earthy undertones and delicate raspberry aromatics.', 24.00, 'img/pinot-noir.webp', 1),
(28, 6, 'Hendrick’s Gin', 'A unique small-batch gin infused with cucumber and rose petals for a refreshingly floral finish.', 15.00, 'img/hendricks-gin.webp', 1),
(29, 7, 'Molten Chocolate Lava Cake', 'Decadent warm chocolate cake with a molten center, served with vanilla bean ice cream.', 12.00, 'img/chocolate-lava-cake.webp', 1),
(30, 7, 'Fruit Crumble', 'Baked seasonal fruit topped with a buttery, cinnamon-spiced oat crumble.', 12.00, 'img/fruit-crumble.webp', 1),
(31, 7, 'New York Style Cheesecake', 'Rich and creamy traditional cheesecake on a buttery graham cracker crust.', 12.00, 'img/cheescake.webp', 1),
(32, 7, 'Homemade Vanilla Bean Panna Cotta', 'Silky Italian cream delicacy infused with real vanilla beans and fresh berry compote.', 12.00, 'img/panna-cotta.webp', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_ingredient`
--

CREATE TABLE `product_ingredient` (
  `product_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 1.00,
  `included` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `product_ingredient`
--

INSERT INTO `product_ingredient` (`product_id`, `ingredient_id`, `amount`, `included`) VALUES
(1, 1, 1.00, 1),
(1, 2, 1.00, 1),
(1, 3, 1.00, 1),
(1, 12, 0.00, 0),
(1, 25, 0.00, 0),
(1, 26, 0.00, 0),
(2, 1, 1.00, 1),
(2, 2, 1.00, 1),
(2, 3, 1.00, 1),
(2, 12, 0.00, 0),
(2, 25, 0.00, 0),
(2, 26, 0.00, 0),
(3, 1, 1.00, 1),
(3, 2, 1.00, 1),
(3, 4, 1.00, 1),
(3, 12, 0.00, 0),
(3, 21, 1.00, 1),
(4, 1, 1.00, 1),
(4, 2, 1.00, 1),
(4, 7, 0.00, 0),
(4, 12, 0.00, 0),
(4, 20, 1.00, 1),
(5, 1, 1.00, 1),
(5, 2, 1.00, 1),
(5, 3, 1.00, 1),
(5, 12, 0.00, 0),
(6, 13, 1.00, 1),
(7, 13, 0.00, 0),
(8, 13, 1.00, 1),
(9, 13, 0.00, 0),
(10, 13, 1.00, 1),
(11, 1, 1.00, 1),
(11, 2, 1.00, 1),
(11, 5, 1.00, 1),
(11, 12, 0.00, 0),
(11, 21, 1.00, 1),
(12, 1, 1.00, 1),
(12, 2, 1.00, 1),
(12, 12, 0.00, 0),
(12, 19, 1.00, 1),
(12, 26, 0.00, 0),
(13, 1, 1.00, 1),
(13, 2, 1.00, 1),
(13, 6, 1.00, 1),
(13, 7, 1.00, 1),
(13, 12, 0.00, 0),
(14, 1, 1.00, 1),
(14, 2, 1.00, 1),
(14, 8, 1.00, 1),
(14, 9, 0.00, 0),
(14, 12, 0.00, 0),
(15, 1, 1.00, 1),
(15, 2, 1.00, 1),
(15, 9, 1.00, 1),
(15, 12, 0.00, 0),
(16, 1, 1.00, 1),
(16, 2, 1.00, 1),
(16, 10, 1.00, 1),
(16, 25, 0.00, 0),
(16, 26, 0.00, 0),
(17, 1, 1.00, 1),
(17, 2, 1.00, 1),
(17, 7, 1.00, 1),
(17, 11, 1.00, 1),
(17, 25, 0.00, 0),
(17, 26, 0.00, 0),
(18, 1, 1.00, 1),
(18, 2, 1.00, 1),
(18, 3, 0.00, 0),
(18, 12, 1.00, 1),
(18, 24, 1.00, 1),
(18, 25, 0.00, 0),
(19, 13, 1.00, 1),
(20, 13, 1.00, 1),
(21, 13, 1.00, 1),
(22, 13, 1.00, 1),
(23, 13, 0.00, 0),
(24, 13, 0.00, 0),
(25, 13, 0.00, 0),
(26, 13, 0.00, 0),
(27, 13, 0.00, 0),
(28, 13, 0.00, 0),
(28, 22, 1.00, 1),
(29, 14, 0.00, 0),
(29, 15, 0.00, 0),
(29, 16, 1.00, 1),
(30, 14, 0.00, 0),
(30, 16, 0.00, 0),
(30, 17, 1.00, 1),
(31, 14, 1.00, 1),
(31, 15, 1.00, 1),
(31, 16, 0.00, 0),
(31, 18, 1.00, 1),
(32, 14, 0.00, 0),
(32, 15, 0.00, 0),
(32, 23, 1.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `rol` varchar(20) NOT NULL DEFAULT 'user' COMMENT 'Values: user, admin',
  `registration_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `address`, `date_of_birth`, `rol`, `registration_date`) VALUES
(1, 'Manel Customer', 'manelcustomer@gmail.com', '1234', '611223344', 'Calle Mayor 123, Barcelona', '1998-04-12', 'user', '2026-10-23 18:00:44'),
(2, 'Manel Admin', 'maneladmin@gmail.com', '1234', '622334455', 'Avenida Principal 45, Barcelona', '1985-09-23', 'admin', '2026-10-23 18:00:44');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indices de la tabla `offer_product`
--
ALTER TABLE `offer_product`
  ADD PRIMARY KEY (`offer_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `order_detail_ingredient`
--
ALTER TABLE `order_detail_ingredient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_detail_id` (`order_detail_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `product_ingredient`
--
ALTER TABLE `product_ingredient`
  ADD PRIMARY KEY (`product_id`,`ingredient_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `order_detail_ingredient`
--
ALTER TABLE `order_detail_ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `offer_product`
--
ALTER TABLE `offer_product`
  ADD CONSTRAINT `offer_product_ibfk_1` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `offer_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Filtros para la tabla `order_detail_ingredient`
--
ALTER TABLE `order_detail_ingredient`
  ADD CONSTRAINT `order_detail_ingredient_ibfk_1` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`),
  ADD CONSTRAINT `order_detail_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Filtros para la tabla `product_ingredient`
--
ALTER TABLE `product_ingredient`
  ADD CONSTRAINT `product_ingredient_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
