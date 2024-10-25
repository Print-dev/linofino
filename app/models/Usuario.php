<?php

require_once 'Conexion.php';

class Usuario extends Conexion
{

  private $pdo;

  public function __CONSTRUCT()
  {
    $this->pdo = parent::getConexion();
  }

  public function add($params = []): int
  {
    try {
      $cmd = $this->pdo->prepare("call spu_usuarios_registrar(@idusuario, ?,?,?,?)");
      $cmd->execute(
        array(
          $params['idpersona'],
          $params['nomusuario'],
          $params['claveacceso'],
          $params['perfil']
        )
      );
      $response = $this->pdo->query("SELECT @idusuario AS idusuario")->fetch(PDO::FETCH_ASSOC);
      return (int) $response['idusuario'];
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return -1;
    }
  }

  /**
   * Retorna una lista de usuarios
   */
  public function getAll(): array
  {
    return parent::getData("spu_usuarios_listar");
  }

  /**
   * Retorna el registro del usuario indicado
   */
  public function login($params = []): array
  {
    try {
      $cmd = $this->pdo->prepare("call spu_usuarios_login(?)");
      $cmd->execute(
        array($params['nomusuario'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
    }
  }

  /**
   * Obtiene una lista de vistas a las que el usuario puede acceder
   * @param array $params el idperfil se debe enviar como arreglo asociativo
   * @return array retorna una collecion de datos
   */

  public function obtenerPermisos($params = []): array
  {
    try {
      $cmd = $this->pdo->prepare("call spu_usuarios_obtener_permisos(?)");
      $cmd->execute(
        array($params['idperfil'])
      );
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }

  public function obtenerClients($params = []): array
  {
    try {
      $cmd = $this->pdo->prepare("select * from clients");
      $cmd->execute();
      return $cmd->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
      error_log("Error: " . $e->getMessage());
      return [];
    }
  }
}

/*
$usuario = new Usuario();
var_dump($usuario->login(['nomusuario' => 'jfranciax'])); 
*/