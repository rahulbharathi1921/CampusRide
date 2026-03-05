from flask import Blueprint, jsonify
from database import execute_query

bus_bp = Blueprint('bus', __name__)

@bus_bp.route("/stops/<int:route_id>", methods=["GET"])
def stops_api(route_id):
    query = """
        SELECT stop_order, stop_name, stop_time
        FROM stops
        WHERE route_id = %s
        ORDER BY stop_order
    """
    stops = execute_query(query, (route_id,))
    if stops:
        for stop in stops:
            if stop["stop_time"]:
                stop["stop_time"] = str(stop["stop_time"])
    return jsonify(stops or [])

@bus_bp.route("/buses/", methods=["GET"])
def get_buses():
    query = "SELECT DISTINCT bus_name AS name, route_id AS route_no FROM stops ORDER BY bus_name"
    buses = execute_query(query)
    if buses:
        for idx, bus in enumerate(buses, start=1):
            bus["id"] = idx
            bus["seat_cap"] = 60
    return jsonify(buses or [])
