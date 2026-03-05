// ===================== manageroute.js =====================

// Backend URL
const BACKEND_URL = "http://127.0.0.1:5000";

// Elements
const busSelect = document.getElementById("busSelect");
const stopTableBody = document.getElementById("stopTableBody");

// Forms
const addStopForm = document.getElementById("addStopForm");
const editStopForm = document.getElementById("editStopForm");
const deleteStopForm = document.getElementById("deleteStopForm");

// Buttons
const showAddStopFormBtn = document.getElementById("showAddStopForm");
const showEditStopFormBtn = document.getElementById("showEditStopForm");
const showDeleteStopFormBtn = document.getElementById("showDeleteStopForm");

const cancelAddStopBtn = document.getElementById("cancelAddStopBtn");
const cancelEditStopBtn = document.getElementById("cancelEditStopBtn");
const cancelDeleteStopBtn = document.getElementById("cancelDeleteStopBtn");

// Dropdowns
const editStopSelect = document.getElementById("editStopSelect");
const deleteStopSelect = document.getElementById("deleteStopSelect");

// Store data
let buses = [];
let stops = [];

// =======================================================
// ✅ LOAD ALL BUSES INTO DROPDOWN
// =======================================================
async function loadBusDropdown() {
  try {
    const res = await fetch(`${BACKEND_URL}/buses/`);
    buses = await res.json();

    busSelect.innerHTML = "";

    if (buses.length === 0) {
      busSelect.innerHTML = `<option value="">No buses found</option>`;
      return;
    }

    // Fill dropdown with buses
    buses.forEach(bus => {
      const option = document.createElement("option");

      // route_no is used to fetch stops
      option.value = bus.route_no;

      option.textContent = `${bus.name} (Route ${bus.route_no})`;

      busSelect.appendChild(option);
    });

    // Auto-load first bus stops
    loadStops();

  } catch (err) {
    console.error("Error loading buses:", err);
    busSelect.innerHTML = `<option value="">Failed to load buses</option>`;
  }
}

// =======================================================
// ✅ LOAD STOPS FOR SELECTED BUS
// =======================================================
async function loadStops() {
  const routeId = busSelect.value;

  if (!routeId) return;

  try {
    const res = await fetch(`${BACKEND_URL}/stops/${routeId}`);
    stops = await res.json();

    stopTableBody.innerHTML = "";

    if (stops.length === 0) {
      stopTableBody.innerHTML = `<tr><td colspan="2">No stops found</td></tr>`;
      return;
    }

    // Fill table
    stops.forEach(stop => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${stop.stop_name}</td>
        <td>${stop.stop_time}</td>
      `;
      stopTableBody.appendChild(row);
    });

    updateStopDropdowns();

  } catch (err) {
    console.error("Error loading stops:", err);
    stopTableBody.innerHTML = `<tr><td colspan="2">Failed to load stops</td></tr>`;
  }
}

// =======================================================
// ✅ UPDATE EDIT + DELETE STOP DROPDOWNS
// =======================================================
function updateStopDropdowns() {
  editStopSelect.innerHTML = `<option value="">Select Stop</option>`;
  deleteStopSelect.innerHTML = `<option value="">Select Stop</option>`;

  stops.forEach((stop, index) => {
    editStopSelect.innerHTML += `
      <option value="${index}">${stop.stop_name}</option>
    `;

    deleteStopSelect.innerHTML += `
      <option value="${index}">${stop.stop_name}</option>
    `;
  });
}

// =======================================================
// ✅ FORM CONTROL
// =======================================================
function hideAllForms() {
  addStopForm.style.display = "none";
  editStopForm.style.display = "none";
  deleteStopForm.style.display = "none";
}

showAddStopFormBtn.addEventListener("click", () => {
  hideAllForms();
  addStopForm.style.display = "flex";
});

showEditStopFormBtn.addEventListener("click", () => {
  hideAllForms();
  editStopForm.style.display = "flex";
});

showDeleteStopFormBtn.addEventListener("click", () => {
  hideAllForms();
  deleteStopForm.style.display = "flex";
});

cancelAddStopBtn.addEventListener("click", hideAllForms);
cancelEditStopBtn.addEventListener("click", hideAllForms);
cancelDeleteStopBtn.addEventListener("click", hideAllForms);

// =======================================================
// ✅ WHEN BUS DROPDOWN CHANGES → LOAD STOPS
// =======================================================
busSelect.addEventListener("change", loadStops);

// =======================================================
// ✅ PAGE LOAD
// =======================================================
window.addEventListener("DOMContentLoaded", () => {
  loadBusDropdown();
});
