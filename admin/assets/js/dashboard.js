
async function loadStats() {
    try {
        const busesRes = await fetch("http://127.0.0.1:5000/total_buses");
        const busesData = await busesRes.json();

        const routesRes = await fetch("http://127.0.0.1:5000/total_routes");
        const routesData = await routesRes.json();

        const sosRes = await fetch("http://127.0.0.1:5000/sos_today");
        const sosData = await sosRes.json();

        document.getElementById("totalBuses").innerText = busesData.total;
        document.getElementById("totalRoutes").innerText = routesData.total;
        document.getElementById("sosToday").innerText = sosData.total > 0 ? sosData.total : "NIL";

    } catch (err) {
        console.error("Error fetching stats:", err);
    }
}

window.addEventListener("DOMContentLoaded", loadStats);
