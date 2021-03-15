-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for mysqltiendadb
CREATE DATABASE IF NOT EXISTS `mysqltiendadb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mysqltiendadb`;

-- Dumping structure for table mysqltiendadb.aspnetroleclaims
CREATE TABLE IF NOT EXISTS `aspnetroleclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(767) NOT NULL,
  `ClaimType` text,
  `ClaimValue` text,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetroleclaims: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetroleclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetroleclaims` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetroles
CREATE TABLE IF NOT EXISTS `aspnetroles` (
  `Id` varchar(767) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` text,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetroles: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetroles` DISABLE KEYS */;
INSERT INTO `aspnetroles` (`Id`, `Name`, `NormalizedName`, `ConcurrencyStamp`) VALUES
	('6750895b-94d3-44c7-93ec-bb78c50af3ff', 'Vendedor', 'VENDEDOR', '02451000-5ed7-4e9c-ba5b-f99359c17569'),
	('8fd7bdc4-577e-4201-9918-a98781a2478b', 'Administrador', 'ADMINISTRADOR', 'a8fa022a-ca1a-4e06-ace7-928c01c12220'),
	('f2657a00-09ed-47e5-a7dc-43e23d005db5', 'Cliente', 'CLIENTE', '945a0b32-df9e-428d-9aee-0fa9c6ae8bd5');
/*!40000 ALTER TABLE `aspnetroles` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetuserclaims
CREATE TABLE IF NOT EXISTS `aspnetuserclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(767) NOT NULL,
  `ClaimType` text,
  `ClaimValue` text,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetuserclaims: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetuserclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserclaims` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetuserlogins
CREATE TABLE IF NOT EXISTS `aspnetuserlogins` (
  `LoginProvider` varchar(767) NOT NULL,
  `ProviderKey` varchar(767) NOT NULL,
  `ProviderDisplayName` text,
  `UserId` varchar(767) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetuserlogins: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetuserlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserlogins` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetuserroles
CREATE TABLE IF NOT EXISTS `aspnetuserroles` (
  `UserId` varchar(767) NOT NULL,
  `RoleId` varchar(767) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetuserroles: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetuserroles` DISABLE KEYS */;
INSERT INTO `aspnetuserroles` (`UserId`, `RoleId`) VALUES
	('08973633-84b7-47af-a18e-c16dea621550', '6750895b-94d3-44c7-93ec-bb78c50af3ff'),
	('68cceabc-4f6e-4589-8113-2bde4aba5f25', '8fd7bdc4-577e-4201-9918-a98781a2478b'),
	('a23f0dcf-fb73-42e7-a77e-5e548e5ac6d2', 'f2657a00-09ed-47e5-a7dc-43e23d005db5');
/*!40000 ALTER TABLE `aspnetuserroles` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetusers
CREATE TABLE IF NOT EXISTS `aspnetusers` (
  `Id` varchar(767) NOT NULL,
  `Nombre` text,
  `Apellidos` text,
  `UserName` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` text,
  `SecurityStamp` text,
  `ConcurrencyStamp` text,
  `PhoneNumber` text,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` timestamp NULL DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetusers: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetusers` DISABLE KEYS */;
INSERT INTO `aspnetusers` (`Id`, `Nombre`, `Apellidos`, `UserName`, `NormalizedUserName`, `Email`, `NormalizedEmail`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `ConcurrencyStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEnd`, `LockoutEnabled`, `AccessFailedCount`) VALUES
	('08973633-84b7-47af-a18e-c16dea621550', 'ss', 'ss', 'ss', 'SS', 'ss@example.com', 'SS@EXAMPLE.COM', 0, 'AQAAAAEAACcQAAAAEACHu4qZ0xXLYNidt1oV8oT/rRrMFKNkJQeTqHilo9BHg3AZ8QUmRr0jh647TsJNrQ==', 'DWHTHS3C4ZAMYY5GOWQSHAO2DH76S7VR', 'b14ab25e-ce85-4cb0-b341-d70f30d58ca3', NULL, 0, 0, NULL, 1, 0),
	('68cceabc-4f6e-4589-8113-2bde4aba5f25', 'admin', 'admin', 'admin', 'ADMIN', 'admin@example.com', 'ADMIN@EXAMPLE.COM', 0, 'AQAAAAEAACcQAAAAEGHP70Ak0EcPbX0TdJOVK5Sp6RaFgMy055irOFtrzgx/WFJBnAh/JQo8g8uRH9f6OA==', 'PFIXWTFVSWZUUGEUI5R7PMZICKLCOHXY', 'd6f96d16-0682-4a79-8610-e4abb102815e', NULL, 0, 0, NULL, 1, 0),
	('a23f0dcf-fb73-42e7-a77e-5e548e5ac6d2', 'string', 'string', 'string', 'STRING', 'user@example.com', 'USER@EXAMPLE.COM', 0, 'AQAAAAEAACcQAAAAEHcZOynLXRoO/6A+YJi5MecE+pJOQt7sL6lZO4tjP+W0vHse5lhKu6+EIAyEKT86/A==', 'LRCSWJ2WZTDVPPPZP62VAC5R7YOMNIAD', '0f2c6257-61de-469d-a51d-021b89379a33', NULL, 0, 0, NULL, 1, 0);
/*!40000 ALTER TABLE `aspnetusers` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.aspnetusertokens
CREATE TABLE IF NOT EXISTS `aspnetusertokens` (
  `UserId` varchar(767) NOT NULL,
  `LoginProvider` varchar(767) NOT NULL,
  `Name` varchar(767) NOT NULL,
  `Value` text,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.aspnetusertokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `aspnetusertokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetusertokens` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.orden
CREATE TABLE IF NOT EXISTS `orden` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Estado` text NOT NULL,
  `Fecha` datetime NOT NULL,
  `Productoid` int(11) DEFAULT NULL,
  `UsuarioId` varchar(767) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_Orden_Productoid` (`Productoid`),
  KEY `IX_Orden_UsuarioId` (`UsuarioId`),
  CONSTRAINT `FK_Orden_AspNetUsers_UsuarioId` FOREIGN KEY (`UsuarioId`) REFERENCES `aspnetusers` (`Id`),
  CONSTRAINT `FK_Orden_producto_Productoid` FOREIGN KEY (`Productoid`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.orden: ~0 rows (approximately)
/*!40000 ALTER TABLE `orden` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` text NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Slug` text NOT NULL,
  `Precio` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.producto: ~1 rows (approximately)
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` (`id`, `Nombre`, `Descripcion`, `Cantidad`, `Slug`, `Precio`) VALUES
	(1, 'string', 'string', 9, 'string', 10.00);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;

-- Dumping structure for table mysqltiendadb.__efmigrationshistory
CREATE TABLE IF NOT EXISTS `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table mysqltiendadb.__efmigrationshistory: ~1 rows (approximately)
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
	('20210314235812_initial', '5.0.4');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
