<?php

require_once '../models/Persona.php';
$persona = new Persona();

//IO JSON
header("Content-type: application/json; charset=utf-8");

//Consultas, búsquedas, validaciones (SELECT...)
if (isset($_GET['operation'])){
  switch ($_GET['operation']){
    case '':
      break;
  }
}

//Modificación de datos (INSERT, DELETE, UPDATE)
if (isset($_POST['operation'])){
  switch ($_POST['operation']){
    case 'add':
      $datosRecibidos = [
        "apellidos"     => $persona->limpiarCadena($_POST['apellidos']),
        "nombres"       => $persona->limpiarCadena($_POST['nombres']),
        "telefono"      => $persona->limpiarCadena($_POST['telefono']),
        "dni"           => $persona->limpiarCadena($_POST['dni']),
        "direccion"     => $persona->limpiarCadena($_POST['direccion'])
      ];
      $idpersona = $persona->add($datosRecibidos);
      echo json_encode(['idpersona' => $idpersona]);
      break;
  }
}