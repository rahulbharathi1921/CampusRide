// Default admins (no localStorage needed)
const admins = [
  { username: "admin1", password: "2002" },
  { username: "admin2", password: "2004" },
  { username: "transport1", password: "1921" }
];

function login() {
  const user = document.getElementById("username").value.trim();
  const pass = document.getElementById("password").value.trim();
  const msg = document.getElementById("msg");

  if (user === "" || pass === "") {
    msg.innerText = " Please enter both username and password!";
    msg.style.color = "red";
    return;
  }

  // Match admin
  const matchedAdmin = admins.find(a =>
    a.username === user && a.password === pass
  );

  console.log("Entered:", user, pass);
  console.log("Matched:", matchedAdmin);

  if (matchedAdmin) {
    msg.innerText = " Login Successful!";
    msg.style.color = "green";

    // Store admin session
    sessionStorage.setItem("currentAdmin", matchedAdmin.username);

    setTimeout(() => {
      // ✅ Correct path
      window.location.href = "dashboard.html";
    }, 500);
  } else {
    msg.innerText = " Invalid Username or Password!";
    msg.style.color = "red";
  }
}
