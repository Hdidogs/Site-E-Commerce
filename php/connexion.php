<?php
include 'SQLHelper.php';

$mail = $_POST['mail'];
$mdp = $_POST['mdp'];

$co = new SQLHelper();
$requete = $co ->con($mail, $mdp);
?>
