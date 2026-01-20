<?php
require('fpdf/fpdf.php');
include 'conexion.php'; // Usar conexión centralizada

class PDF extends FPDF {
    function Header(){
        $this->SetFont('Arial','B',14);
        $this->Cell(0,10,'Reporte de Alumnos',0,1,'C');
        $this->Ln(5);
        // Encabezados de tabla
        $this->SetFont('Arial','B',10);
        $this->Cell(30,10,'Control',1);
        $this->Cell(80,10,'Nombre Completo',1);
        $this->Cell(30,10,'Grupo',1);
        $this->Ln();
    }
}

$pdf = new PDF();
$pdf->AddPage();
$pdf->SetFont('Arial','',10);

$res = $conexion->query("SELECT * FROM alumnos");

while($row = $res->fetch_assoc()){
    $pdf->Cell(30,10,$row['No_control'],1);
    $pdf->Cell(80,10,utf8_decode($row['Nombre'].' '.$row['Apellido_paterno']),1);
    $pdf->Cell(30,10,$row['Id_grupo'],1);
    $pdf->Ln();
}

$pdf->Output();
?>