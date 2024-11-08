-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 07, 2024 lúc 05:36 AM
-- Phiên bản máy phục vụ: 10.4.24-MariaDB
-- Phiên bản PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `nhac_duong_lau`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `peoples`
--

CREATE TABLE `peoples` (
  `id` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `province_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `images_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images_list`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `peoples`
--

INSERT INTO `peoples` (`id`, `province_id`, `province_name`, `image_url`, `code`, `name`, `age`, `price`, `description`, `sortAddress`, `images_list`) VALUES
(2, 1, 'An Giang', 'https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-19.jpg', 'A1', 'Nguyễn Văn AAAAAAA', 21, 'Từ 1tr - 10tr', 'Nhìn cái tró gì', 'Hà Nội', '[\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-20.jpg\",\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-21.jpg\",\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-22.jpg\",\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-23.jpg\",\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-24.jpg\",\"https://meatworld.com.vn/wp-content/uploads/anh-gai-xinh-che-mat-25.jpg\"]');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id` int(8) NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_phone` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance` bigint(12) NOT NULL DEFAULT 0,
  `membership_level` int(3) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`first_name`, `last_name`, `username`, `id`, `password`, `email`, `number_phone`, `balance`, `membership_level`) VALUES
('Doanh', 'Tran Danh', 'nhimcaptain', 5, '$2a$10$goyruridxArez2EgfYnF..8RZJ0dAZ.dTukR5m2.uVdeccQ9WbSZ6', 'ndaka@gmail.com', '', 0, 1),
('test', 'Tran Danh13', 'nhimcaptain13', 6, '$2a$10$flxC8bmqgJsjHEdVnwPGgu.EC39KSQqtH3vXUDx0LoV/iAQWhMb.G', 'ndakaa13@gmail.com', '234', 0, 1),
('aaa', 'tran the', 'nhimcd', 7, '$2a$10$lalrRbCC4BYjEPH2UDxCluue/nNXoMfjYBdJoDAGFAQyqUSRzIrRK', 'ndakaa1222@gmail.com', '23433', 0, 1),
('aaa', 'tran the', 'testuser', 8, '$2a$10$WD.F/XOLItWg4bWpk2kNx.zog4cZI8gHGqXRbBNFUsoV8PqQ/afo2', '', '', 0, 1),
('aaa', 'tran the', 'testuser1', 9, '$2a$10$UHtiO8dl8r9kjbZMtw5Tm.M41uxbyF18xOfLeOdGZJzVs/OUQoeji', '', '', 0, 1),
('', '', 'nhimcaptain1', 10, '$2a$10$B9P7KFBl3KzTDmZxabY8qO4wKB3rWJPFybOsRcrlHqD/uHPX4KBae', '', '', 0, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `peoples`
--
ALTER TABLE `peoples`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `peoples`
--
ALTER TABLE `peoples`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
