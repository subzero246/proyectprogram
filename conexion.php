<?php
$servidor = "localhost";
$usuario_db = "root";
$contra_db = "";
$base_datos = "controla";

$conexion = mysqli_connect($servidor, $usuario_db, $contra_db, $base_datos);

if (!$conexion) {
    die("Error de conexión: " . mysqli_connect_error());
}
// Configurar para evitar problemas con acentos/eñes
mysqli_set_charset($conexion, "utf8");
?>