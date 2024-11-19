## **Features**

- Select a date to view the theater with the highest sales for that day.
- Display a chart of monthly sales for the top-selling theater.
- Seamless data management using Flask-SQLAlchemy and Flask-Migrate.
- API endpoints to fetch sales data dynamically.

---

## **Database Schema**

Schema dump in root folder `dump.sql`

### Tables and Relationships

**`Theater`**

    - `id` (Primary Key): Unique identifier for the theater.
    - `name` (String): Name of the theater.
    - `location` (String): Location of the theater.

**`Movie`**

    - `id` (Primary Key): Unique identifier for the movie.
    - `title` (String): Title of the movie.
    - `genre` (String): Genre of the movie (e.g., Action, Comedy, Drama).
    - `release_date` (Date): Release date of the movie.

**`Sale`**

    - `id` (Primary Key): Unique identifier for the sale record.
    - `theater_id` (Foreign Key): References `Theater.id`.
    - `movie_id` (Foreign Key): References `Movie.id`.
    - `sale_date` (Date): The date of the sale.
    - `tickets_sold` (Integer): Number of tickets sold.
***Relationships***

    - Each sale is linked to one theater and one movie.

***Indexes***

    - theater_id(Foreign key index)
    - movie_id(Foreign key index)
    - sale_date(Foreign key index)
    - theater_id, movie_id, sale_date(Composite index for faster look up)

---

## **Project Setup**

### Prerequisites

- **Docker** and **Docker Compose** installed on your system.

---

### Steps to Run the Project

**Clone the Repository**:

```bash
git clone <repository-url>
cd ata-python
```

**Build and Start the Containers**
```bash
docker-compose up -d --build
```

**Seed the Database**
```bash
docker-compose exec app bash
```

Run the seeder to populate the database(may take several minutes)
```bash
flask seed
```
Data Seeded

Theaters:
* 1,000 theaters with unique names and locations.

Movies:
* 20,000 movies with random titles, genres, and release dates.

Sales:
* ~ 3,600,000 sales records spanning 2024-01-01 to 2024-12-31.

**Access the Application**

Open your browser and navigate to http://localhost:8090.
