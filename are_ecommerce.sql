-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 06 déc. 2023 à 09:44
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `are_ecommerce`
--

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id_commande` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL,
  `rue` int(11) NOT NULL,
  `cp` int(11) NOT NULL,
  `ville` int(11) NOT NULL,
  `pays` int(11) NOT NULL,
  PRIMARY KEY (`id_commande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

DROP TABLE IF EXISTS `commentaire`;
CREATE TABLE IF NOT EXISTS `commentaire` (
  `id_commentaire` int(11) NOT NULL AUTO_INCREMENT,
  `note` int(5) NOT NULL,
  `message` varchar(250) NOT NULL,
  `ref_user` int(11) NOT NULL,
  PRIMARY KEY (`id_commentaire`),
  KEY `fk_commentaire_user` (`ref_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id_produit` int(11) NOT NULL AUTO_INCREMENT,
  `nom` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `nbr_img` int(5) NOT NULL,
  `img1` varchar(100) NOT NULL,
  `img2` varchar(100) DEFAULT NULL,
  `img3` varchar(100) DEFAULT NULL,
  `img4` varchar(100) DEFAULT NULL,
  `img5` varchar(100) DEFAULT NULL,
  `prix` float(8,2) NOT NULL,
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `produitcommande`
--

DROP TABLE IF EXISTS `produitcommande`;
CREATE TABLE IF NOT EXISTS `produitcommande` (
  `ref_commande` int(11) NOT NULL,
  `ref_produit` int(11) NOT NULL,
  PRIMARY KEY (`ref_commande`,`ref_produit`),
  KEY `fk_produitcommande_produit` (`ref_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `mdp` varchar(255) NOT NULL,
  `rue` varchar(100) NOT NULL,
  `cp` varchar(100) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `pays` varchar(100) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `date_creation` date NOT NULL,
  `date_last_co` date DEFAULT NULL,
  `date_last_buy` date DEFAULT NULL,
  `total_depense` int(11) DEFAULT NULL,
  `total_depense_mois` int(11) DEFAULT NULL,
  `pdp` varchar(100) DEFAULT 'user',
  `nbr_com` int(11) DEFAULT NULL,
  `date_last_com` date DEFAULT NULL,
  `nbr_com_delete` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `usercommande`
--

DROP TABLE IF EXISTS `usercommande`;
CREATE TABLE IF NOT EXISTS `usercommande` (
  `ref_commande` int(11) NOT NULL,
  `ref_user` int(11) NOT NULL,
  PRIMARY KEY (`ref_commande`,`ref_user`),
  KEY `fk_usercommande_user` (`ref_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `fk_commentaire_user` FOREIGN KEY (`ref_user`) REFERENCES `user` (`id_user`);

--
-- Contraintes pour la table `produitcommande`
--
ALTER TABLE `produitcommande`
  ADD CONSTRAINT `fk_produitcommande_commande` FOREIGN KEY (`ref_commande`) REFERENCES `commande` (`id_commande`),
  ADD CONSTRAINT `fk_produitcommande_produit` FOREIGN KEY (`ref_produit`) REFERENCES `produit` (`id_produit`);

--
-- Contraintes pour la table `usercommande`
--
ALTER TABLE `usercommande`
  ADD CONSTRAINT `fk_usercommande_commande` FOREIGN KEY (`ref_commande`) REFERENCES `commande` (`id_commande`),
  ADD CONSTRAINT `fk_usercommande_user` FOREIGN KEY (`ref_user`) REFERENCES `user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
