from app import db
from app.models import Theater, Movie, Sale
from datetime import datetime, timedelta
import random

def seed_data():
    print("Seeding data...")

    # Seed theaters
    theaters = []
    for i in range(1, 1001):
        theaters.append(Theater(name=f"Theater {i}", location=f"Location {i}"))

    db.session.bulk_save_objects(theaters)
    db.session.commit()
    print(f"Seeded {len(theaters)} theaters.")

    # Seed movies
    movies = []
    for i in range(1, 20001):
        movies.append(Movie(title=f"Movie {i}", genre=random.choice(["Action", "Comedy", "Drama", "Sci-Fi"]),
                            release_date=datetime(2024, random.randint(1, 12), random.randint(1, 28))))

    db.session.bulk_save_objects(movies)
    db.session.commit()
    print(f"Seeded {len(movies)} movies.")

    # Seed sales
    sales = []
    start_date = datetime(2024, 1, 1)
    end_date = datetime(2024, 12, 31)
    current_date = start_date

    while current_date <= end_date:
        for _ in range(10000):
            sales.append(Sale(
                theater_id=random.randint(1, 1000),
                movie_id=random.randint(1, 20000),
                sale_date=current_date,
                tickets_sold=random.randint(1, 500)
            ))

            if len(sales) >= 10000:
                db.session.bulk_save_objects(sales)
                db.session.commit()
                sales = []

        current_date += timedelta(days=1)

    if sales:
        db.session.bulk_save_objects(sales)
        db.session.commit()

    print("Seeding completed!")