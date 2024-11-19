-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 09:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `farah_12`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryID`, `categoryName`) VALUES
(1, 'מזגן עילי'),
(2, 'מזגן מיני מרכזי'),
(3, 'מזגן נייד\r\n'),
(4, 'מזגן מולטי אינוורטר\r\n'),
(5, '‎אביזר'),
(6, 'מערכת VRF/V\r\n'),
(13, 'מזגן מוסדי\r\n'),
(14, 'יחידת חוץ'),
(15, '‎מזגן דו מאייד\r\n'),
(16, '‎מזגן תלת מאייד\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL,
  `total` double NOT NULL,
  `address` varchar(500) NOT NULL,
  `orderTime` date NOT NULL,
  `fullNameOrder` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderID`, `total`, `address`, `orderTime`, `fullNameOrder`) VALUES
(1, 2000, 'zeemer', '2024-11-30', '');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productID` int(11) NOT NULL,
  `productName` varchar(500) NOT NULL,
  `productPrice` int(11) NOT NULL,
  `CreatedDateTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Warranty` int(11) NOT NULL COMMENT 'אחריות בשנים',
  `categoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productID`, `productName`, `productPrice`, `CreatedDateTime`, `Warranty`, `categoryID`) VALUES
(1, 'מזגן עילי tadiran Apollp Inc 140 NG -צבע לבן', 1388, '2024-11-05 11:36:01', 5, 1),
(3, 'מזגן עילי tadiran Apollp Inc 140 NG -צבע לבן', 1388, '2024-11-05 11:36:01', 5, 1),
(4, 'מזגן עילי tadiran Apollp Inc 140 NG -צבע לבן', 1388, '2024-11-05 11:36:01', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `FirstName` varchar(500) NOT NULL,
  `LastName` varchar(500) NOT NULL,
  `Password` varchar(500) NOT NULL,
  `CreatedDateTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `FirstName`, `LastName`, `Password`, `CreatedDateTime`) VALUES
(1, 'Farah', 'Wattad', 'farah123', '2024-11-02 07:24:04'),
(2, 'yosef', 'wattad', 'yosef123', '2024-11-02 07:24:35'),
(3, 'test', 'last', '', '2024-11-05 10:05:15'),
(6, 'seleen', 'herzalla', 'seleen123', '2024-11-12 09:48:39'),
(9, 'Bob', '123', 'momo', '2024-11-12 10:01:29'),
(10, 'YOSEF', 'WATTAD', '123', '2024-11-12 10:04:46'),
(11, 'FARAH', 'WATTAD', '123', '2024-11-12 10:04:46'),
(12, 'YOSEF', 'WATTAD', '123', '2024-11-12 10:05:30'),
(13, 'FARAH', 'WATTAD', '123', '2024-11-12 10:05:30'),
(14, 'YOSEF', 'WATTAD', '123', '2024-11-16 07:07:27'),
(15, 'FARAH', 'WATTAD', '123', '2024-11-16 07:07:27'),
(16, 'aa', 'ss', 'dd', '2024-11-16 07:09:54'),
(17, 'FARAH', 'WATTAD', '123', '2024-11-16 07:09:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
