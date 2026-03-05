def predict_crowd_level(current_count, total_seats):
    percent = (current_count / total_seats) * 100

    if percent < 50:
        return "Low Crowd"
    elif percent < 90:
        return "Medium Crowd"
    else:
        return "High Crowd"
