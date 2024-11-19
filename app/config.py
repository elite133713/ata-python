import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://sa:Your_password123@db:5432/MovieSalesDb')
    SQLALCHEMY_TRACK_MODIFICATIONS = False