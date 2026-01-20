<?php
include 'conexion.php';
$fecha = date("Y-m-d");
header("Content-Type: application/vnd.ms-excel; charset=utf-8");
header("Content-Disposition: attachment; filename=reporte_alumnos_$fecha.xls");
header("Pragma: no-cache");
header("Expires: 0");

echo "No. Control\tNombre Completo\tGrupo\tTelefono\n";

$res = $conexion->query("SELECT * FROM alumnos");

while($r = $res->fetch_assoc()){
    // Eliminar saltos de línea dentro de los datos para no romper el Excel
    $nombre = $r['Nombre'] . " " . $r['Apellido_paterno'];
    echo $r['No_control'] . "\t" . utf8_decode($nombre) . "\t" . $r['Id_grupo'] . "\t" . $r['Telefono'] . "\n";
}
?>