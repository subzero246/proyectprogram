<?php
date_default_timezone_set('America/Mexico_City');
include 'conexion.php';

$mensaje = "Esperando lectura...";
$tipo = "secondary";

if (isset($_GET['id_alumno'])) {
    $id_alumno = (int)$_GET['id_alumno'];
    $hora = date('H:i:s');
    $fecha = date('Y-m-d');
    
    $dias = ['Monday'=>'lunes','Tuesday'=>'martes','Wednesday'=>'miercoles','Thursday'=>'jueves','Friday'=>'viernes'];
    $dia_actual = $dias[date('l')] ?? 'otro';

    // Buscar si el alumno tiene clase AHORA según su grupo
    $sql = "SELECT H.Id_horario, M.Nombre_materia, A.Nombre 
            FROM horarios H 
            INNER JOIN materias M ON H.Id_materia = M.Id_materia 
            INNER JOIN alumnos A ON A.Id_grupo = H.Id_grupo 
            WHERE A.Id_alumno = ? AND H.Dia_semana = ? AND ? BETWEEN H.Hora_inicio AND H.Hora_fin LIMIT 1";

    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("iss", $id_alumno, $dia_actual, $hora);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($fila = $res->fetch_assoc()) {
        $id_h = $fila['Id_horario'];
        
        // Evitar duplicados el mismo día
        $check = $conexion->query("SELECT Id_asistencia FROM asistencias WHERE Id_alumno=$id_alumno AND Id_horario=$id_h AND Fecha='$fecha'");
        
        if ($check->num_rows == 0) {
            $ins = $conexion->prepare("INSERT INTO asistencias (Id_alumno, Id_horario, Fecha, Estado_asistencia) VALUES (?, ?, ?, 'Presente')");
            $ins->bind_param("iis", $id_alumno, $id_h, $fecha);
            $ins->execute();
            $mensaje = "✅ Asistencia Registrada: " . $fila['Nombre'] . " en " . $fila['Nombre_materia'];
            $tipo = "success";
        } else {
            $mensaje = "⚠️ Ya se registró asistencia hoy para esta clase.";
            $tipo = "warning";
        }
    } else {
        $mensaje = "❌ No tienes clases programadas en este momento ($dia_actual $hora).";
        $tipo = "danger";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro QR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="card p-4 shadow-sm text-center" style="max-width: 400px;">
        <div class="alert alert-<?php echo $tipo; ?>"><?php echo $mensaje; ?></div>
        <a href="proyecto.php" class="btn btn-primary">Volver</a>
    </div>
</body>
</html>