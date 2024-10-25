$(document).ready(async () => {

  function $q(object = null) {
    return document.querySelector(object);
  }

  function $all(object = null) {
    return document.querySelectorAll(object);
  }

  async function getDatos(link, params) {
    let data = await fetch(`${link}?${params}`);
    return data.json();
  }

  const tbodyClients = $q("#tbodyClients")

  await renderClientsTable();

  async function renderClientsTable() {
    const clients = await getDatos(`http://localhost/linofino/app/controllers/Usuario.controller.php`, `operation=obtenerClients`);
    console.log("clients obtenidos: ", clients);
    tbodyClients.innerHTML = "";
    for (let i = 0; i < clients.length; i++) {
      tbodyClients.innerHTML += `
        <tr>
            <th>${clients[i].id}</th>
            <td>${clients[i].first_name}</td>
            <td>${clients[i].last_name}</td>
            <td>${clients[i].email}</td>
            <td>${clients[i].gender}</td>
            <td>${clients[i].phone}</td>
        </tr>
      `;
    }

    $('#tablaClientes').DataTable({
      paging: true,
      searching: false,
      lengthMenu: [5, 10, 15, 20],
      pageLength: 5,
      language: {
        lengthMenu: "Mostrar _MENU_ filas por página",
        paginate: {
          previous: "Anterior",
          next: "Siguiente"
        },
        emptyTable: "No hay datos disponibles",
        search: "Buscar:",
        info: "Mostrando _START_ a _END_ de _TOTAL_ registros"
      }
    });
  }
})