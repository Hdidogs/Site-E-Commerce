<?php

class SQLHelper {
    public function conbdd(): PDO {
        $servername = "localhost";
        $username = "root";
        $password = "";
        $bddname = "are_cinema";

        try {
            $conn = new PDO("mysql:host=$servername;dbname=".$bddname, $username, $password);

            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {

        }

        return $conn;
    }

    public function con(String $mail, String $mdp): bool {
        $co = new SQLHelper();
        $res = $co->conbdd()->prepare("SELECT * FROM user WHERE mail = :mail");
        $res->execute(['mail'=>$mail]);
        $user = $res -> fetchAll();

        foreach ($user as $client) {
            $id = $client['id_user'];
            $clientmdp = $client['mdp'];
        }

        if (password_verify($mdp, $clientmdp)) {
            session_start();
            (int) $_SESSION['id_user'] = $id;
            header("Location: ../html/index.php");
            return true;
        } else {
            header("Location: ../html/index.php");
            return false;
        }
    }

    public function inscription(String $nom, String $prenom, String $rue, String $cp, String $ville, String $mail, String $mdp): bool {
        $co = new SQLHelper();
        $add_user = $co->conbdd()->prepare("INSERT INTO user (id_user, nom, prenom, mail, mdp, rue, cp, ville, administrateur) VALUES (null, :nom, :prenom, :mail, :mdp, :rue, :cp, :ville, :administrateur)");
        $add_user->execute(['nom'=>$nom, 'prenom'=>$prenom, 'rue'=>$rue, 'cp'=>$cp, 'ville'=>$ville, 'email'=>$mail, 'mdp' =>$mdp, 'administrateur'=>0]);

        $id_client = $co->conbdd()->lastInsertId();

        session_start();
        $_SESSION['id_user'] = $id_client;

        if ($id_client != null) {
            header("Location: ../html/index.php");
            return true;
        } else {
            header("Location: ../html/index.php");
            return false;
        }
    }

    public function checkAdmin(int $id): bool {
        $co = new SQLHelper();
        $res = $co->conbdd()->prepare("SELECT * FROM user WHERE id_user = :id_user");
        $res->execute(['id_user'=>$id]);
        $user = $res -> fetchAll();

        foreach ($user as $client) {
            $admin = $client['administrateur'];
        }

        if ($admin == 1) {
            return true;
        } else {
            return false;
        }
    }
}
?>