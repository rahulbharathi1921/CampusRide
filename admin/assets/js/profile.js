// Default admins with passwords
const defaultAdmins = [
  { username: "admin1", email: "admin1@college.com", role: "College Admin", password: "2002" },
  { username: "admin2", email: "admin2@college.com", role: "College Admin", password: "2004" },
  { username: "transport1", email: "transport1@college.com", role: "Transport In-charge", password: "1921" }
];

// Load admins from localStorage or use default
let admins = JSON.parse(localStorage.getItem("admins"));
if (!admins || admins.length === 0) {
  admins = defaultAdmins;
  localStorage.setItem("admins", JSON.stringify(admins));
}

// Container for profile cards
const container = document.querySelector(".profile-cards");

// Generate cards
function generateCards() {
  container.innerHTML = "";
  admins.forEach(admin => {
    const card = document.createElement("div");
    card.classList.add("profile-card");
    card.setAttribute("data-username", admin.username);
    card.innerHTML = `
      <div class="avatar">
        <img src="../../img/icon-7797704_640.png" alt="Admin Avatar">
      </div>
      <div class="profile-info">
        <h3>${admin.role} <span class="status-dot" id="${admin.username}-status"></span></h3>
        <p><strong>Username:</strong> ${admin.username}</p>
        <p><strong>Email:</strong> ${admin.email}</p>
        <p><strong>Role:</strong> ${admin.role}</p>
        <p><strong>Password:</strong> ${"*".repeat(admin.password.length)}</p>
        <button class="edit-btn">Edit Profile</button>
      </div>
    `;
    container.appendChild(card);
  });
  updateStatus();
}

// Modal logic
const modal = document.getElementById("editModal");
const closeModal = document.querySelector(".close");
const saveBtn = document.getElementById("saveBtn");
let currentEditing = null;

document.addEventListener("click", e => {
  if (e.target.classList.contains("edit-btn")) {
    const card = e.target.closest(".profile-card");
    const username = card.getAttribute("data-username");
    currentEditing = admins.find(a => a.username === username);

    if (currentEditing) {
      document.getElementById("editUsername").value = currentEditing.username;
      document.getElementById("editEmail").value = currentEditing.email;
      document.getElementById("editRole").value = currentEditing.role;
      document.getElementById("editPassword").value = currentEditing.password;
      modal.style.display = "flex";
    }
  }
});

// Close modal
closeModal.addEventListener("click", () => modal.style.display = "none");

// Save changes
saveBtn.addEventListener("click", () => {
  if (!currentEditing) return;

  const oldUsername = currentEditing.username;
  const newUsername = document.getElementById("editUsername").value.trim();
  const newEmail = document.getElementById("editEmail").value.trim();
  const newRole = document.getElementById("editRole").value.trim();
  const newPassword = document.getElementById("editPassword").value.trim();

  // Update admin info
  currentEditing.username = newUsername;
  currentEditing.email = newEmail;
  currentEditing.role = newRole;
  currentEditing.password = newPassword;

  // Update localStorage currentAdmin if logged in user changed their username
  if (localStorage.getItem("currentAdmin") === oldUsername) {
    localStorage.setItem("currentAdmin", newUsername);
  }

  // Update status key if exists
  if (localStorage.getItem(oldUsername)) {
    const status = localStorage.getItem(oldUsername);
    localStorage.setItem(newUsername, status);
    localStorage.removeItem(oldUsername);
  }

  // Save updated admins to localStorage
  localStorage.setItem("admins", JSON.stringify(admins));

  generateCards();
  modal.style.display = "none";
});

// Status dots
function updateStatus() {
  admins.forEach(admin => {
    const dot = document.getElementById(`${admin.username}-status`);
    if (!dot) return;
    if (localStorage.getItem(admin.username) === "active") {
      dot.style.background = "green";
      dot.title = "Online now";
    } else {
      dot.style.background = "#aaa";
      dot.title = "Offline";
    }
  });
}

// Logout
function logout() {
  const current = localStorage.getItem("currentAdmin");
  if (current) {
    localStorage.removeItem(current);
    localStorage.removeItem("currentAdmin");
  }
}

// Initial load
window.onload = () => {
  generateCards();
};
setInterval(updateStatus, 5000);
