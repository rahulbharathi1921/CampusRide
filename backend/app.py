import os
import sys

# Ensure backend directory is in path for local development
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from flask import Flask, jsonify
from flask_cors import CORS
from config import Config
from routes.bus import bus_bp
from routes.analytics import analytics_bp
from routes.crowd import crowd_bp

def create_app():
    app = Flask(__name__)
    CORS(app)
    
    app.config.from_object(Config)

    # Register Blueprints
    app.register_blueprint(bus_bp)
    app.register_blueprint(analytics_bp)
    app.register_blueprint(crowd_bp)

    @app.route("/")
    def home():
        return jsonify({
            "message": "💖 CampusRide Backend is Running Successfully!",
            "try_endpoints": ["/buses/", "/stops/1", "/analytics/", "/arrivals/", "/crowd/1"]
        })

    return app

if __name__ == "__main__":
    app = create_app()
    print(f"💖 CampusRide Backend is running on port {Config.PORT}! 💖")
    app.run(debug=Config.DEBUG, port=Config.PORT)
