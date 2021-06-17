-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2021 at 10:07 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gpdc`
--

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `p_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `p_name` varchar(255) DEFAULT NULL,
  `p_dob` varchar(255) DEFAULT NULL,
  `p_age` varchar(255) DEFAULT NULL,
  `p_docname` varchar(255) DEFAULT NULL,
  `p_gender` varchar(10) DEFAULT NULL,
  `time_added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`p_id`, `user_id`, `p_name`, `p_dob`, `p_age`, `p_docname`, `p_gender`, `time_added`) VALUES
(13, 24, 'Fatima Khan', '17-03-1998', '43', 'Dr. Ali', 'Female', '2021-04-19 12:30:02'),
(15, 24, 'Abbas', '8th March', '23', 'Dr.Khan', 'Male', '2021-05-22 21:18:46');

-- --------------------------------------------------------

--
-- Stand-in structure for view `time_added`
-- (See below for the actual view)
--
CREATE TABLE `time_added` (
`p_id` int(11)
,`p_name` varchar(255)
,`p_dob` varchar(255)
,`p_age` varchar(255)
,`p_docname` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `cnic` varchar(255) NOT NULL,
  `speciality` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_type` int(11) NOT NULL DEFAULT -1,
  `register_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `cnic`, `speciality`, `email`, `username`, `password`, `token`, `user_type`, `register_date`) VALUES
(1, 'Fasahat Khan', '1730132456765', '', 'FasahatKhan12@gmail.com', 'Fasahat', '$5$rounds=535000$G3eBQfDjCO8VW672$meHUsqJoBJVq50Mo7KuRtkpLjRpxCfbGBLc5/9kjTX1', '', 1, '2021-03-28 16:03:20'),
(2, 'Ghayyur Abbas Khan', '1730132456765', 'Neuro', 'ghayyur@gmail.com', 'ghayyur', '$5$rounds=535000$G3eBQfDjCO8VW672$meHUsqJoBJVq50Mo7KuRtkpLjRpxCfbGBLc5/9kjTX1', 'c9b80c3a-7e6d-4773-b073-22ddd0cd9fc3', 1, '2021-03-28 16:07:32'),
(24, 'Henry Smith', '1534267181892', 'Neuro', 'fassy.fk@gmail.com', 'Henry', '$5$rounds=535000$CycGiQ//wA3NDUdL$tl3XlH5cJOMqFOH5PbBoojBP2T9WvkzzxSE6WiDJ52/', '', 0, '2021-04-19 12:27:45'),
(44, 'Henry Smith', '1534267181892', 'Neuro', 'fassy.fk@gmail.com', 'Henry12', '$5$rounds=535000$CycGiQ//wA3NDUdL$tl3XlH5cJOMqFOH5PbBoojBP2T9WvkzzxSE6WiDJ52/', '', -1, '2021-04-19 12:27:45');

-- --------------------------------------------------------

--
-- Structure for view `time_added`
--
DROP TABLE IF EXISTS `time_added`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `time_added`  AS  select `patients`.`p_id` AS `p_id`,`patients`.`p_name` AS `p_name`,`patients`.`p_dob` AS `p_dob`,`patients`.`p_age` AS `p_age`,`patients`.`p_docname` AS `p_docname` from `patients` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
