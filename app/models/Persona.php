<?php

require_once 'Conexion.php';

class Persona extends Conexion{

  private $pdo;

  public function __CONSTRUCT() { $this->pdo = parent::getConexion(); }

  public function add($params = []):int{
    try{
      $cmd = $this->pdo->prepare("call spu_personas_registrar(@idpersona, ?,?,?,?,?)");
      $cmd->execute(
        array(
          $params['apellidos'],
          $params['nombres'],
          $params['telefono'],
          $params['dni'],
          $params['direccion']
        )
      );
      //Actualización: capturamos el valor de salida OUT
      $response = $this->pdo->query("SELECT @idpersona AS idpersona")->fetch(PDO::FETCH_ASSOC);
      return (int) $response['idpersona'];
    }catch(Exception $e){
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

}

/*
$persona = new Persona();
$id = $persona->add([
  "apellidos"   => "Flores Atuncar",
  "nombres"     => "Cristina",
  "telefono"    => "956111222",
  "dni"         => "45454545",
  "direccion"   => ""
]);

echo $id;
*/