from app import db

class Theater(db.Model):
    __tablename__ = 'theaters'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    location = db.Column(db.String, nullable=False)
    sales = db.relationship('Sale', back_populates='theater')

class Movie(db.Model):
    __tablename__ = 'movies'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String, nullable=False)
    genre = db.Column(db.String, nullable=False)
    release_date = db.Column(db.Date, nullable=False)
    sales = db.relationship('Sale', back_populates='movie')

class Sale(db.Model):
    __tablename__ = 'sales'
    id = db.Column(db.Integer, primary_key=True)
    theater_id = db.Column(db.Integer, db.ForeignKey('theaters.id'), nullable=False, index=True)
    movie_id = db.Column(db.Integer, db.ForeignKey('movies.id'), nullable=False, index=True)
    sale_date = db.Column(db.Date, nullable=False, index=True)
    tickets_sold = db.Column(db.Integer, nullable=False)

    __table_args__ = (
        db.Index('idx_theater_movie_date', 'theater_id', 'movie_id', 'sale_date'),
    )