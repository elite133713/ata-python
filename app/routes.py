from flask import render_template, request, jsonify
from app import db
from app.models import Theater, Sale
from datetime import datetime, timedelta

def home():
    return render_template("index.html")

def get_sales():
    try:
        sale_date = request.args.get("saleDate")
        if not sale_date:
            return jsonify({"error": "saleDate is required"}), 400

        # Parse the date
        date_obj = datetime.strptime(sale_date, "%Y-%m-%d")
        start_of_month = date_obj.replace(day=1)
        end_of_month = (date_obj.replace(day=28) + timedelta(days=4)).replace(day=1) - timedelta(days=1)

        # Get the top theater for the selected date
        result = (
            db.session.query(Theater.id, Theater.name, db.func.sum(Sale.tickets_sold).label("total_sales"))
            .join(Sale, Sale.theater_id == Theater.id)
            .filter(Sale.sale_date == sale_date)
            .group_by(Theater.id, Theater.name)
            .order_by(db.desc("total_sales"))
            .first()
        )

        # Handle case where no sales exist for the selected date
        if not result:
            return jsonify({
                "theater": "No data",
                "tickets_sold": 0,
                "chart_data": {"dates": [], "sales": []},
                "error": f"No sales data found for {sale_date}"
            }), 404

        # Get monthly sales data for the top theater
        monthly_sales = (
            db.session.query(Sale.sale_date, db.func.sum(Sale.tickets_sold).label("total_sales"))
            .filter(Sale.sale_date.between(start_of_month, end_of_month))
            .filter(Sale.theater_id == result.id)
            .group_by(Sale.sale_date)
            .order_by(Sale.sale_date)
            .all()
        )

        # Prepare data for the chart
        chart_data = {
            "dates": [sale[0].strftime("%Y-%m-%d") for sale in monthly_sales],
            "sales": [sale[1] for sale in monthly_sales],
        }

        # Prepare the response
        response = {
            "theater": result.name,
            "tickets_sold": result.total_sales,
            "chart_data": chart_data,
        }

        return jsonify(response)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

def register_routes(app):
    app.add_url_rule("/", "home", home, methods=["GET"])
    app.add_url_rule("/get-sales", "get_sales", get_sales, methods=["GET"])