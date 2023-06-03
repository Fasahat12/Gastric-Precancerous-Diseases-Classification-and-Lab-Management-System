-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2021 at 11:36 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

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
-- Table structure for table `disease`
--

CREATE TABLE `disease` (
  `disease_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `disease_name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `disease`
--

INSERT INTO `disease` (`disease_id`, `patient_id`, `disease_name`, `image`, `create_date`) VALUES
(1, 16, 'Ulcer', 'static/img/uploads\\wkurubarrp.png', '2021-06-15 02:41:16'),
(2, 16, 'Erosion', 'static/img/uploads\\xatygocsbs.png', '2021-06-15 17:43:16'),
(3, 16, 'Polyp', 'static/img/uploads\\mevkhofzbv.png', '2021-06-15 17:44:55'),
(4, 15, 'Polyp', 'static/img/uploads\\kdpwwwaxky.png', '2021-06-15 17:48:18'),
(5, 15, 'Polyp', 'static/img/uploads\\xdrhdygfek.png', '2021-06-15 17:51:22'),
(6, 18, 'Erosion', 'static/img/uploads\\owofljmyyn.png', '2021-06-15 18:58:56'),
(8, 16, 'Polyp', 'static/img/uploads\\wrhfhmxchm.png', '2021-06-16 03:32:35'),
(9, 16, 'Ulcer', 'static/img/uploads\\bzospdqife.png', '2021-06-16 04:05:43'),
(10, 16, 'Polyp', 'static/img/uploads\\hmmdqwavfl.png', '2021-06-16 04:06:17'),
(11, 15, 'Polyp', 'static/img/uploads\\tiawmkhnsg.png', '2021-06-16 03:30:37'),
(12, 15, 'Ulcer', 'static/img/uploads\\zdhqlnuffr.png', '2021-06-17 01:35:43'),
(13, 18, 'Erosion', 'static/img/uploads\\fshsoqhwja.png', '2021-06-17 00:56:56'),
(14, 18, 'Erosion', 'static/img/uploads\\hvlnfwpiam.png', '2021-06-17 00:57:51'),
(15, 18, 'Erosion', 'static/img/uploads\\jhvfgayfzf.png', '2021-06-17 01:00:57'),
(16, 16, 'Ulcer', 'static/img/uploads\\zuiqoyurec.png', '2021-06-17 01:02:25'),
(17, 16, 'Ulcer', 'static/img/uploads\\axryzvpsid.png', '2021-06-17 01:08:53'),
(18, 16, 'Polyp', 'static/img/uploads\\pcexxnkpza.png', '2021-06-17 01:09:04'),
(19, 16, 'Polyp', 'static/img/uploads\\pfrrhkzyzc.png', '2021-06-17 01:09:14'),
(20, 20, 'Erosion', 'static/img/uploads\\qbkadahpyw.png', '2021-06-17 01:00:10'),
(21, 20, 'Erosion', 'static/img/uploads\\croxlvutbt.png', '2021-06-17 01:18:42'),
(22, 15, 'Ulcer', 'static/img/uploads\\jtqqnejnwx.png', '2021-06-17 01:00:53'),
(23, 20, 'Ulcer', 'static/img/uploads\\mboakoawhl.png', '2021-06-17 11:14:12'),
(24, 20, 'Polyp', 'static/img/uploads\\kokyxfdyyf.png', '2021-06-17 11:14:35'),
(25, 20, 'Polyp', 'static/img/uploads\\jwcgzwlxlf.png', '2021-06-17 11:14:49'),
(26, 20, 'Erosion', 'static/img/uploads\\cqkkoqgspg.png', '2021-06-17 11:15:13'),
(27, 21, 'Polyp', 'static/img/uploads\\zgrgdcyfkb.png', '2021-06-17 11:08:11'),
(28, 15, 'Ulcer', 'static/img/uploads\\qsqyjtfvqs.png', '2021-06-17 10:56:33'),
(29, 15, 'Polyp', 'static/img/uploads\\bufqtnurjd.png', '2021-06-17 10:56:47'),
(30, 21, 'Ulcer', 'static/img/uploads\\vwnrjdboxr.png', '2021-06-17 11:19:58'),
(33, 24, 'Polyp', 'static/img/uploads\\dexrdaurwm.png', '2021-09-22 11:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `lab_reports`
--

CREATE TABLE `lab_reports` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `test_value` decimal(65,2) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lab_reports`
--

INSERT INTO `lab_reports` (`id`, `test_id`, `patient_id`, `test_value`, `date`) VALUES
(1, 6, 16, '1.23', '2021-10-06 03:00:30'),
(2, 6, 24, '1.34', '2021-10-05 03:00:30'),
(3, 6, 15, '1.76', '2021-10-06 03:00:30'),
(4, 6, 16, '1.00', '2021-10-06 03:00:30'),
(5, 6, 24, '0.99', '2021-10-06 03:00:30'),
(6, 6, 18, '0.98', '2021-10-06 03:00:30'),
(7, 6, 18, '0.97', '2021-10-06 03:00:30'),
(8, 6, 24, '1.00', '2021-10-06 03:01:24'),
(9, 7, 15, '12.39', '2021-10-19 18:49:04'),
(10, 6, 15, '1.99', '2021-10-19 18:49:31'),
(11, 7, 15, '5.00', '2021-10-19 18:51:58'),
(12, 7, 16, '1.00', '2021-10-19 19:37:34'),
(13, 7, 15, '2.00', '2021-10-19 19:37:36'),
(14, 7, 15, '3.00', '2021-10-19 19:37:38'),
(15, 7, 16, '2.00', '2021-10-19 19:39:48'),
(16, 7, 16, '3.00', '2021-10-19 19:39:53'),
(17, 6, 16, '2.00', '2021-10-19 21:50:45'),
(18, 7, 16, '1.00', '2021-10-19 21:51:17');

-- --------------------------------------------------------

--
-- Table structure for table `lab_requests`
--

CREATE TABLE `lab_requests` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `urgency_level` varchar(255) NOT NULL,
  `is_analyzed` tinyint(4) NOT NULL DEFAULT 0,
  `request_date` datetime NOT NULL,
  `analysis_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lab_requests`
--

INSERT INTO `lab_requests` (`id`, `test_id`, `patient_id`, `urgency_level`, `is_analyzed`, `request_date`, `analysis_date`) VALUES
(3, 6, 16, 'High', 0, '2021-10-11 13:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

CREATE TABLE `lab_tests` (
  `Id` int(11) NOT NULL,
  `test_name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lab_tests`
--

INSERT INTO `lab_tests` (`Id`, `test_name`, `code`) VALUES
(4, 'HAEMATOLOGY', 'HTG'),
(5, 'URINE ANALYSIS', 'UA');

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
(15, 24, 'Jeremy Jahns', '23-01-1999', '24', 'Bucky Barnes', 'Male', '2021-06-12 04:17:46'),
(16, 24, 'John Doe', '12-03-2001', '22', 'Dr .Tahir', 'Male', '2021-06-13 21:42:06'),
(18, 24, 'James Dean', '1999-12-01', '22', 'randy orton', 'male', '2021-06-13 21:50:36'),
(20, 46, 'Jamie Fox', '18-09-1987', '65', 'Dr. Dre', 'Male', '2021-06-17 00:59:50'),
(21, 46, 'John Walker', '12-01-1990', '31', 'Dr Wajahat', 'Male', '2021-06-17 11:07:13'),
(24, 24, 'Siyab Khan', '08/03/1997', '24', 'Dr. Khan', 'Male', '2021-06-21 01:01:51'),
(25, 24, 'Imran Ali', '10/01/1995', '26', 'Ayesha Khan', 'Male', '2021-10-08 09:41:42');

-- --------------------------------------------------------

--
-- Table structure for table `tests_under`
--

CREATE TABLE `tests_under` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `test_name` varchar(255) NOT NULL,
  `lower_limit` decimal(65,2) NOT NULL,
  `upper_limit` decimal(65,2) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `unit_price` decimal(65,2) NOT NULL,
  `taxes` decimal(65,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tests_under`
--

INSERT INTO `tests_under` (`id`, `test_id`, `test_name`, `lower_limit`, `upper_limit`, `unit`, `unit_price`, `taxes`) VALUES
(6, 5, 'Physical Examination', '0.00', '0.50', '/cmmm', '120.00', '0.00'),
(7, 4, 'PE', '10.00', '15.00', 'cmm', '600.00', '0.00');

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
(1, 'Fasahat Khan', '12', '', 'FasahatKhan12@gmail.com', 'Fasahat', '$5$rounds=535000$G3eBQfDjCO8VW672$meHUsqJoBJVq50Mo7KuRtkpLjRpxCfbGBLc5/9kjTX1', '', 1, '2021-03-28 16:03:20'),
(2, 'Ghayyur Abbas Khan', '14', '', 'ghayyur@gmail.com', 'ghayyur', '$5$rounds=535000$G3eBQfDjCO8VW672$meHUsqJoBJVq50Mo7KuRtkpLjRpxCfbGBLc5/9kjTX1', '', 1, '2021-03-28 16:07:32'),
(24, 'Henry Smith', '1534267181892', 'Neuro', 'fassy.fk@gmail.com', 'Henry', '$5$rounds=535000$CycGiQ//wA3NDUdL$tl3XlH5cJOMqFOH5PbBoojBP2T9WvkzzxSE6WiDJ52/', '', 0, '2021-04-19 12:27:45'),
(46, 'Dave Chapel', '10012-0987231-1', 'Neuro', 'Dave@gmail.com', 'Dave1', '$5$rounds=535000$nDkvRnHpRVayF9Gu$Q.ap8.EWC1pFLrxTtnozSk3VWB2RyFX2rHAhVdsKyC3', '', 0, '2021-06-16 04:09:52'),
(47, 'John', '17805-1299341-1', 'Neuro', 'fassy.fk@gmail.com', 'john123', '$5$rounds=535000$.0NiEZ2z7uRRKaG6$Gw4vVi13ts5FCwfg2c4U6AEh1JwAU0yr7FEnlHdf9H7', '', -1, '2021-10-13 09:07:53');

-- --------------------------------------------------------

--
-- Structure for view `time_added`
--
DROP TABLE IF EXISTS `time_added`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `time_added`  AS SELECT `patients`.`p_id` AS `p_id`, `patients`.`p_name` AS `p_name`, `patients`.`p_dob` AS `p_dob`, `patients`.`p_age` AS `p_age`, `patients`.`p_docname` AS `p_docname` FROM `patients` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `disease`
--
ALTER TABLE `disease`
  ADD PRIMARY KEY (`disease_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `lab_reports`
--
ALTER TABLE `lab_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `lab_requests`
--
ALTER TABLE `lab_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tests_under`
--
ALTER TABLE `tests_under`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `disease`
--
ALTER TABLE `disease`
  MODIFY `disease_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `lab_reports`
--
ALTER TABLE `lab_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `lab_requests`
--
ALTER TABLE `lab_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lab_tests`
--
ALTER TABLE `lab_tests`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tests_under`
--
ALTER TABLE `tests_under`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `disease`
--
ALTER TABLE `disease`
  ADD CONSTRAINT `disease_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`p_id`) ON DELETE CASCADE;

--
-- Constraints for table `lab_reports`
--
ALTER TABLE `lab_reports`
  ADD CONSTRAINT `lab_reports_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_reports_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests_under` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lab_requests`
--
ALTER TABLE `lab_requests`
  ADD CONSTRAINT `lab_requests_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests_under` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_requests_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tests_under`
--
ALTER TABLE `tests_under`
  ADD CONSTRAINT `tests_under_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `lab_tests` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
