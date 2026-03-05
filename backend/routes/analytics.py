from flask import Blueprint, jsonify
from datetime import datetime
from database import execute_query

analytics_bp = Blueprint('analytics', __name__)

@analytics_bp.route("/analytics/", methods=["GET"])
def analytics_summary():
    # Total buses = 13 default
    total_buses = 13
    
    # Active buses
    now_time = datetime.now().strftime("%H:%M:%S")
    active_query = "SELECT COUNT(DISTINCT bus_name) AS active_buses FROM stops WHERE stop_time >= %s"
    active_result = execute_query(active_query, (now_time,), fetch_all=False)
    active_buses = active_result["active_buses"] if active_result else 0

    # Total stops
    stops_query = "SELECT COUNT(*) AS total_stops FROM stops"
    stops_result = execute_query(stops_query, fetch_all=False)
    total_stops = stops_result["total_stops"] if stops_result else 0

    return jsonify({
        "total_buses": total_buses,
        "active_buses": active_buses,
        "total_stops": total_stops
    })

@analytics_bp.route("/total_buses", methods=["GET"])
def total_buses():
    return jsonify({"total": 13})

@analytics_bp.route("/total_routes", methods=["GET"])
def total_routes():
    # Total unique route_ids in stops table
    query = "SELECT COUNT(DISTINCT route_id) AS total FROM stops"
    result = execute_query(query, fetch_all=False)
    return jsonify({"total": result["total"] if result else 0})

@analytics_bp.route("/sos_today", methods=["GET"])
def sos_today():
    return jsonify({"total": 0})

@analytics_bp.route("/arrivals/", methods=["GET"])
def upcoming_arrivals():
    query = """
        SELECT bus_name, route_id, stop_name, stop_time
        FROM stops
        ORDER BY stop_time ASC
        LIMIT 5
    """
    arrivals = execute_query(query)
    if arrivals:
        for a in arrivals:
            if a["stop_time"]:
                a["stop_time"] = str(a["stop_time"])
    return jsonify(arrivals or [])
