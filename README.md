# CampusRide 🚌

CampusRide is a comprehensive bus tracking and management solution for campuses. It features a Flask backend, a web-based Admin Dashboard, and a Flutter mobile application for students.

## 🌟 Key Features
- **Real-time Bus Tracking**: Students can view bus locations and estimated arrivals.
- **Admin Dashboard**: Effortlessly manage buses, routes, and schedules.
- **Analytics**: Gain insights into bus activity and stop distributions.
- **Crowd Level Prediction**: Estimate bus occupancy for better travel planning.

## 🏗️ Project Structure
- `backend/`: Python Flask API with modular routing and database logic.
- `admin/`: Web-based dashboard built with HTML, CSS, and Vanilla JavaScript.
- `students/bus_tracking_app/`: Mobile application built with Flutter.

## 🚀 Getting Started

### Backend
1. Navigate to `backend/`.
2. Create a virtual environment: `python -m venv venv`.
3. Install dependencies: `pip install -r requirements.txt`. (Note: Ensure you have MySQL installed).
4. Set up your `.env` file with database credentials.
5. Run the server: `python app.py`.

### Admin Dashboard
1. Simply open `admin/src/login.html` in your browser.
2. Login with default credentials (check `admin/assets/js/login.js`).

### Student App (Flutter)
1. Navigate to `students/bus_tracking_app/`.
2. Run `flutter pub get`.
3. Configure your Google Maps API key in `AndroidManifest.xml`.
4. Run the app: `flutter run`.

## 🛠️ Built With
- **Backend**: Flask, MySQL, Python
- **Frontend**: HTML5, CSS3, JavaScript
- **Mobile**: Flutter, Dart

---
*Created with 💙 for the CampusRide Community.*
