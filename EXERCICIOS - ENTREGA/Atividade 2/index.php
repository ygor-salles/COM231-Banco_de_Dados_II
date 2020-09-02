<?php
if($_SERVER['REQUEST_METHOD'] == 'POST') {
    pg_connect('host=localhost dbname=injection user=postgres password=123456');
    $user = $_POST['user'];
    $pass = $_POST['pass'];
    $query = "select username, password from injection.users where username='$user' and password='$pass'";
    $result = pg_query($query);
    $rows = pg_fetch_array($result);
    if($rows){
        echo "Logado com sucesso.";
    }else{
        echo "Não Logou.";
    }
}
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="index.php" method="POST">
            <h2>Login</h2><br>
            Usuário:<br>
            <input type="text" name="user"><br><br>
            Senha:<br>
            <input type ="password" name="pass"><br><br>
            <input type="submit" value="Logar">
        </form>
    </body>
</html