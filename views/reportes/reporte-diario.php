<?php require_once '../header.php'; ?>

<main>
  <div class="container-fluid px-4">
    <h1>Reporte diario</h1>
    <br>
    <table id="tablaClientes" class="display">
      <thead>
        <tr>
          <th>#</th>
          <th>First name</th>
          <th>Last name</th>
          <th>Email</th>
          <th>Gender</th>
          <th>Phone</th>
        </tr>
      </thead>
      <tbody id="tbodyClients">
        
      </tbody>
    </table>
  </div>
</main>

<?php require_once '../footer.php'; ?>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Luego, el archivo de DataTables -->

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="../../js/clients/obtener-clients.js"></script>