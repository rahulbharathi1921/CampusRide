from flask import Blueprint, jsonify
from prediction import predict_crowd_level

crowd_bp = Blueprint('crowd', __name__)

bus_info = {
    1: {"total_seats": 40, "current_count": 20},
    2: {"total_seats": 50, "current_count": 45}
}

@crowd_bp.route("/crowd/<int:bus_id>", methods=["GET"])
def crowd_api(bus_id):
    bus = bus_info.get(bus_id)
    if not bus:
        return jsonify({"error": "Bus not found"}), 404
    crowd_level = predict_crowd_level(bus["current_count"], bus["total_seats"])
    return jsonify({
        "bus_id": bus_id,
        "total_seats": bus["total_seats"],
        "current_count": bus["current_count"],
        "crowd_level": crowd_level
    })
