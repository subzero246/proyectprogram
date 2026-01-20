<?php
session_start();
include 'conexion.php';

// Protección de sesión
if (!isset($_SESSION['ad'])) {
    header("Location: index.html");
    exit;
}

// Procesar Formulario de Alumnos (Insertar/Editar)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion_alumno'])) {
    $no_control = $conexion->real_escape_string($_POST['no_control']);
    $nombre     = $conexion->real_escape_string($_POST['nombre']);
    $ap_p       = $conexion->real_escape_string($_POST['Apellido_paterno']);
    $telefono   = $conexion->real_escape_string($_POST['telefono']);
    $id_grupo   = (int)$_POST['Id_grupo'];
    $id_edit    = isset($_POST['id_alumno_edit']) ? (int)$_POST['id_alumno_edit'] : 0;

    if ($id_edit > 0) {
        $sql = "UPDATE alumnos SET No_control='$no_control', Nombre='$nombre', Apellido_paterno='$ap_p', Telefono='$telefono', Id_grupo=$id_grupo WHERE Id_alumno=$id_edit";
    } else {
        $sql = "INSERT INTO alumnos (No_control, Nombre, Apellido_paterno, Telefono, Id_grupo) VALUES ('$no_control', '$nombre', '$ap_p', '$telefono', $id_grupo)";
    }
    $conexion->query($sql);
    header("Location: proyecto.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .sidebar { min-height: 100vh; background: #2c3e50; color: white; padding: 20px; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px; border-radius: 5px; cursor: pointer; }
        .sidebar a:hover, .sidebar a.active { background: #34495e; }
        .section-content { display: none; padding: 20px; }
        .active-section { display: block; }
        #qrcode img { margin: 0 auto; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 sidebar">
            <h4>Control Escolar</h4>
            <hr>
            <p>Usuario: <strong><?php echo htmlspecialchars($_SESSION['ad']); ?></strong></p>
            <a onclick="showSection('sec-alumnos')" class="nav-link active">Alumnos</a>
            <a onclick="showSection('sec-reportes')" class="nav-link">Reportes</a>
            <a href="cierre.php" class="btn btn-danger mt-4 w-100">Cerrar Sesión</a>
        </nav>

        <main class="col-md-10">
            <section id="sec-alumnos" class="section-content active-section">
                <h2 class="mt-3">Gestión de Alumnos</h2>
                <button class="btn btn-primary mb-3" onclick="nuevoAlumno()">+ Agregar Alumno</button>
                <table class="table table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>No. Control</th>
                            <th>Nombre</th>
                            <th>Grupo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $res = $conexion->query("SELECT a.*, g.Nombre_grupo FROM alumnos a LEFT JOIN grupos g ON a.Id_grupo = g.Id_grupo");
                        while ($row = $res->fetch_assoc()): 
                        ?>
                        <tr>
                            <td><?php echo $row['No_control']; ?></td>
                            <td><?php echo $row['Nombre'] . " " . $row['Apellido_paterno']; ?></td>
                            <td><?php echo $row['Nombre_grupo'] ?? 'S/G'; ?></td>
                            <td>
                                <button class="btn btn-sm btn-info" onclick='editAlumno(<?php echo json_encode($row); ?>)'>Editar</button>
                                <button class="btn btn-sm btn-dark" onclick="verQR(<?php echo $row['Id_alumno']; ?>, '<?php echo $row['Nombre']; ?>')">Ver QR</button>
                            </td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </section>
            
            <section id="sec-reportes" class="section-content">
                <h2>Reportes</h2>
                <a href="exportar_exel.php" class="btn btn-success">Excel</a>
                <a href="exportar_pdf.php" class="btn btn-danger">PDF</a>
            </section>
        </main>
    </div>
</div>

<div class="modal fade" id="modalQR" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content text-center">
            <div class="modal-header"><h5>Código QR</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div id="qrcode"></div>
                <p id="qr_nombre" class="mt-2 fw-bold"></p>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalAlumno" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <div class="modal-header"><h5 id="modalTitle">Alumno</h5></div>
            <div class="modal-body">
                <input type="hidden" name="accion_alumno" value="1">
                <input type="hidden" name="id_alumno_edit" id="id_alumno_edit">
                <div class="mb-2"><label>No. Control</label><input type="text" name="no_control" id="no_control" class="form-control" required></div>
                <div class="mb-2"><label>Nombre</label><input type="text" name="nombre" id="nombre" class="form-control" required></div>
                <div class="mb-2"><label>Apellido Paterno</label><input type="text" name="Apellido_paterno" id="ap_p" class="form-control" required></div>
                <div class="mb-2"><label>Teléfono</label><input type="text" name="telefono" id="telefono" class="form-control"></div>
                <div class="mb-2"><label>ID Grupo</label><input type="number" name="Id_grupo" id="id_grupo" class="form-control"></div>
            </div>
            <div class="modal-footer"><button type="submit" class="btn btn-primary">Guardar</button></div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script>
const modalForm = new bootstrap.Modal(document.getElementById('modalAlumno'));
const modalQR = new bootstrap.Modal(document.getElementById('modalQR'));
let qrContainer = new QRCode(document.getElementById("qrcode"), { width: 180, height: 180 });

function showSection(id) {
    document.querySelectorAll('.section-content').forEach(s => s.classList.remove('active-section'));
    document.getElementById(id).classList.add('active-section');
}

function nuevoAlumno() {
    document.getElementById('id_alumno_edit').value = "";
    document.getElementById('modalTitle').innerText = "Nuevo Alumno";
    modalForm.show();
}

function editAlumno(data) {
    document.getElementById('id_alumno_edit').value = data.Id_alumno;
    document.getElementById('no_control').value = data.No_control;
    document.getElementById('nombre').value = data.Nombre;
    document.getElementById('ap_p').value = data.Apellido_paterno;
    document.getElementById('telefono').value = data.Telefono;
    document.getElementById('id_grupo').value = data.Id_grupo;
    modalForm.show();
}

function verQR(id, nombre) {
    document.getElementById('qr_nombre').innerText = nombre;
    // La URL debe apuntar a la dirección real de tu archivo de registro
    let url = window.location.origin + "/registro_qr.php?id_alumno=" + id;
    qrContainer.clear();
    qrContainer.makeCode(url);
    modalQR.show();
}
</script>
</body>
</html>