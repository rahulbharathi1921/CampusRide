// ======== managebus.js ========

// Table body element
const busTableBody = document.getElementById("busTableBody");

// Form elements
const addBusForm = document.getElementById("addBusForm");
const editBusForm = document.getElementById("editBusForm");
const deleteBusForm = document.getElementById("deleteBusForm");

const showAddBtn = document.getElementById("showAddBusForm");
const showEditBtn = document.getElementById("showEditBusForm");
const showDeleteBtn = document.getElementById("showDeleteBusForm");

const cancelAddBtn = document.getElementById("cancelBtn");
const cancelEditBtn = document.getElementById("editCancelBtn");
const cancelDeleteBtn = document.getElementById("deleteCancelBtn");

const addBusBtn = document.getElementById("addBusBtn");
const updateBusBtn = document.getElementById("updateBusBtn");
const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

const editBusIdSelect = document.getElementById("editBusId");
const deleteBusIdSelect = document.getElementById("deleteBusId");

// Backend URL
const BACKEND_URL = "http://127.0.0.1:5000";

// Store fetched buses
let buses = [];

// ================== Fetch Buses from Backend ==================
async function loadBuses() {
    try {
        const res = await fetch(`${BACKEND_URL}/buses`); // NO trailing slash
        buses = await res.json();

        busTableBody.innerHTML = "";

        if (buses.length === 0) {
            busTableBody.innerHTML = `<tr><td colspan="4">No buses found</td></tr>`;
            return;
        }

        buses.forEach(bus => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${bus.id}</td>
                <td>${bus.name}</td>
                <td>${bus.route_no}</td>
                <td>${bus.seat_cap}</td>
            `;
            busTableBody.appendChild(row);
        });

        updateBusDropdowns();

    } catch (err) {
        console.error("Error fetching buses:", err);
        busTableBody.innerHTML = `<tr><td colspan="4">Failed to load buses</td></tr>`;
    }
}

// ================== Update Edit/Delete Dropdowns ==================
function updateBusDropdowns() {
    editBusIdSelect.innerHTML = `<option value="">Select Bus ID</option>`;
    deleteBusIdSelect.innerHTML = `<option value="">Select Bus ID</option>`;

    buses.forEach(bus => {
        editBusIdSelect.innerHTML += `<option value="${bus.id}">${bus.id}</option>`;
        deleteBusIdSelect.innerHTML += `<option value="${bus.id}">${bus.id}</option>`;
    });
}

// ================== Show/Hide Forms ==================
function hideAllForms() {
    addBusForm.style.display = "none";
    editBusForm.style.display = "none";
    deleteBusForm.style.display = "none";
}

showAddBtn.addEventListener("click", () => {
    hideAllForms();
    addBusForm.style.display = "flex";
});
showEditBtn.addEventListener("click", () => {
    hideAllForms();
    editBusForm.style.display = "flex";
    updateBusDropdowns();
});
showDeleteBtn.addEventListener("click", () => {
    hideAllForms();
    deleteBusForm.style.display = "flex";
    updateBusDropdowns();
});

cancelAddBtn.addEventListener("click", () => addBusForm.style.display = "none");
cancelEditBtn.addEventListener("click", () => editBusForm.style.display = "none");
cancelDeleteBtn.addEventListener("click", () => deleteBusForm.style.display = "none");

// ================== Add Bus (Front-end only for now) ==================
addBusBtn.addEventListener("click", () => {
    const name = document.getElementById("busName").value.trim();
    const route = document.getElementById("routeNo").value.trim();
    const seat = document.getElementById("seatCap").value.trim();

    if (!name || !route || !seat) {
        alert("Please fill all fields!");
        return;
    }

    // Create new bus object locally
    const newBus = {
        id: buses.length ? Math.max(...buses.map(b => b.id)) + 1 : 1,
        name,
        route_no: route,
        seat_cap: seat
    };

    buses.push(newBus);
    loadBuses();

    // Reset form
    document.getElementById("busName").selectedIndex = 0;
    document.getElementById("routeNo").value = "";
    document.getElementById("seatCap").value = "";
    addBusForm.style.display = "none";
});

// ================== Edit Bus ==================
editBusIdSelect.addEventListener("change", () => {
    const selectedId = parseInt(editBusIdSelect.value);
    const bus = buses.find(b => b.id === selectedId);

    if (bus) {
        document.getElementById("editBusName").value = bus.name;
        document.getElementById("editRouteNo").value = bus.route_no;
        document.getElementById("editSeatCap").value = bus.seat_cap;
    }
});

updateBusBtn.addEventListener("click", () => {
    const selectedId = parseInt(editBusIdSelect.value);
    const bus = buses.find(b => b.id === selectedId);

    if (!bus) {
        alert("Select a bus to edit!");
        return;
    }

    const newName = document.getElementById("editBusName").value.trim();
    const newRoute = document.getElementById("editRouteNo").value.trim();
    const newSeat = document.getElementById("editSeatCap").value.trim();

    if (!newName || !newRoute || !newSeat) {
        alert("Please fill all fields!");
        return;
    }

    bus.name = newName;
    bus.route_no = newRoute;
    bus.seat_cap = newSeat;

    loadBuses();
    editBusForm.style.display = "none";
    alert("Bus Updated Successfully ✅");
});

// ================== Delete Bus ==================
confirmDeleteBtn.addEventListener("click", () => {
    const selectedId = parseInt(deleteBusIdSelect.value);
    if (!selectedId) {
        alert("Select a Bus ID!");
        return;
    }

    buses = buses.filter(b => b.id !== selectedId);
    loadBuses();
    deleteBusForm.style.display = "none";
    alert("Bus Deleted Successfully 🗑️");
});

// ================== Load buses on page load ==================
window.addEventListener("DOMContentLoaded", loadBuses);
