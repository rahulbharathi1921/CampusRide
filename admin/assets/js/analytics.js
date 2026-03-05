// ===== analytics.js (Backend Connected) =====
const BACKEND_URL = "http://127.0.0.1:5000";

// Card Elements
const busCount = document.getElementById("busCount");
const activeBusCount = document.getElementById("activeBusCount");
const stopCount = document.getElementById("stopCount");

// Table Element
const arrivalTable = document.getElementById("arrivalTable");

// ===============================
// Load Analytics Summary
// ===============================
async function loadAnalytics() {
  try {
    const res = await fetch(`${BACKEND_URL}/analytics/`);
    const data = await res.json();

    // Use keys returned by backend
    busCount.innerText = data.total_buses;       // Default = 13
    activeBusCount.innerText = data.active_buses;
    stopCount.innerText = data.total_stops;

  } catch (error) {
    console.error("Failed to load analytics:", error);
    busCount.innerText = "N/A";
    activeBusCount.innerText = "N/A";
    stopCount.innerText = "N/A";
  }
}

// ===============================
// Load Upcoming Arrivals Table
// ===============================
async function loadArrivals() {
  try {
    const res = await fetch(`${BACKEND_URL}/arrivals/`);
    const arrivals = await res.json();

    arrivalTable.innerHTML = "";

    if (arrivals.length === 0) {
      arrivalTable.innerHTML = `
        <tr>
          <td colspan="4">No arrivals found</td>
        </tr>
      `;
      return;
    }

    arrivals.forEach(item => {
      const row = `
        <tr>
          <td>${item.bus_name}</td>
          <td>${item.route_id}</td>
          <td>${item.stop_name}</td>
          <td>${item.stop_time}</td>
        </tr>
      `;
      arrivalTable.innerHTML += row;
    });

  } catch (error) {
    console.error("Failed to load arrivals:", error);
    arrivalTable.innerHTML = `
      <tr>
        <td colspan="4">Failed to load arrivals</td>
      </tr>
    `;
  }
}

// ===============================
// Page Load
// ===============================
window.addEventListener("DOMContentLoaded", () => {
  loadAnalytics();
  loadArrivals();
});
