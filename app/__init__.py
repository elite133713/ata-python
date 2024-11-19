from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        from app.routes import register_routes
        from app.seed import seed_data
        register_routes(app)
        db.create_all()

    @app.cli.command("seed")
    def seed():
        seed_data()

    return app